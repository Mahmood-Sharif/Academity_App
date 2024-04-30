<?php

namespace App\Controllers\Api;

use App\Entities\User;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\Shield\Validation\ValidationRules;
use Exception;

class Login extends ResourceController
{
    public function loginTest(): ResponseInterface
    {
        $r = $this->respond(['user' => [
            ...auth()->user()->toArray(),
            'email' => auth()->user()->getEmail(),
            'type' => auth()->user()->inGroup('coach') ? 'coach' : 'user'
        ]]);
        return $r;
    }

    public function loginUser(): ResponseInterface
    {
        // get data from request
        $credentials = [
            'email'    => $this->request->getPost('email'),
            'password' => $this->request->getPost('password'),
        ];

        $loginAttempt = auth()->check($credentials);

        if ($loginAttempt->isOK()) {
            $user = auth()->getProvider()->findByCredentials(['email' => $credentials['email']]);

            // NOTE: this disallows users to login in multiple devices
            // $user->revokeAllAccessTokens();

            return $this->respond([
                'status'  => 'Login successful',
                'new_token' => $user->generateAccessToken('mobile-app')->raw_token,
                'user' => [
                    ...$user->toArray(),
                    'email' => $credentials['email'],
                    'type' => $user->inGroup('coach') ? 'coach' : 'user'
                ],
            ]);
        } else {
            return $this->respond([
                'status'  => 'Login failed',
                'message' => $loginAttempt->reason(),
            ]);
        }
    }

    public function registerUser(): ResponseInterface
    {
        // get data from request
        $data = [
            'name'             => $this->request->getPost('name'),
            'phone'            => $this->request->getPost('phone'),
            'dob'              => $this->request->getPost('dob'),
            'gender'           => $this->request->getPost('gender'),
            'email'            => $this->request->getPost('email'),
            'password'         => $this->request->getPost('password'),
            'password_confirm' => $this->request->getPost('password_confirm'),
        ];

        if (!$this->validateData($data, 'registration')) {
            return $this->respond([
                'status' => 'Register failed',
                'errors' => $this->validator->getErrors()
            ], 400);
        }

        $users = auth()->getProvider();
        $user = new User($data);
        $user->username = null;

        try {
            $users->save($user);
        } catch (Exception $e) {
            return $this->respond([
                'status' => 'Register failed',
                'errors' => $users->errors()
            ], 400);
        }

        $user = $users->findById($users->getInsertID());
        $users->addToDefaultGroup($user);

        return $this->respond([
            'status'  => 'Register successful',
            'new_token' => $user->generateAccessToken('mobile-app')->raw_token,
            'user' => [
                ...$user->toArray(),
                'email' => $user->email,
                'type' => 'user',
            ]
        ]);
    }

    public function logoutUser(): ResponseInterface
    {
        $token = $this->request->getHeaderLine('Authorization');
        $token = str_replace('Bearer ', '', $token);


        try {
            $result = auth()->user()->revokeAccessToken($token);

            if ($result) {
                return $this->respondDeleted(['status' => 'Logout successful']);
            } else {
                return $this->respond(['status' => 'Logout failed'], ResponseInterface::HTTP_BAD_REQUEST);
            }
        } catch (Exception $e) {

            return $this->respond(['status' => 'Logout failed', 'message' => $e->getMessage()], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function getUserProfile(): ResponseInterface
    {
        $token = $this->request->header('Authorization');
        $token = str_replace('Bearer ', '', $token);

        try {
            // Assuming 'auth()' can decode the token and fetch the user
            $user = auth()->user();

            if (!$user) {
                return $this->respond(['status' => 'Failed', 'message' => 'User not found'], ResponseInterface::HTTP_NOT_FOUND);
            }

            // Assuming the User entity or model has a method to expose necessary data safely
            $userData = [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->getEmail(),
                'phone' => $user->phone,
                'dob' => $user->dob,
                'gender' => $user->gender,
                // Add more fields as necessary
            ];

            return $this->respond([
                'status' => 'Success',
                'user' => $userData,
            ]);
        } catch (Exception $e) {
            return $this->respond(['status' => 'Failed', 'message' => $e->getMessage()], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function updateUserProfile(): ResponseInterface
    {
        try {
            $user = auth()->user();

            if (!$user) {
                return $this->respond(['status' => 'Failed', 'message' => 'User not found'], ResponseInterface::HTTP_NOT_FOUND);
            }

            $rules = (new ValidationRules())->getRegistrationRules();
            unset($rules['password']);
            unset($rules['password_confirm']);
            $updatedData = $this->request->getPost(array_keys($rules));

            // Check if updatedData is empty
            if (empty($updatedData)) {
                return $this->respond(['status' => 'Failed', 'message' => 'No data provided for update'], ResponseInterface::HTTP_BAD_REQUEST);
            }

            if (!auth()->getProvider()->validate($updatedData)) {
                return $this->respond(['status' => 'Failed', 'message' => 'Validation failed for user profile'], ResponseInterface::HTTP_BAD_REQUEST);
            }

            $updatedUser = auth()->getProvider()->findById($user->id);
            $user->fill($updatedData);

            if (auth()->getProvider()->save($user)) {
                $user = auth()->user();
                return $this->respond([
                    'status' => 'Success',
                    'message' => 'User profile updated successfully',
                    'user' => [...$user->toArray(), 'email' => $user->getEmail()],
                ]);
            } else {
                return $this->respond(['status' => 'Failed', 'message' => 'Failed to update user profile'], ResponseInterface::HTTP_BAD_REQUEST);
            }
        } catch (Exception $e) {
            return $this->respond(['status' => 'Failed', 'message' => 'Internal server error.'], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function deleteAccount(): ResponseInterface
    {
        $user = auth()->user();
        if ($user->inGroup('admin')) {
            return $this->fail([
                'status' => 'cannot delete',
                'reason' => 'academy owner',
            ], 400);

        }
        log_message('critical', var_export($this->request->headers(), true));

        $credentials = [
            'email'    => $user->getEmail(),
            'password' => $this->request->getPost('password'),
        ];
        log_message('critical', var_export($credentials, true));

        $loginAttempt = auth('session')->check($credentials);

        log_message('critical', var_export($loginAttempt, true));

        if (!$loginAttempt->isOK()) {
            return $this->fail([
                'status' => 'failed',
                'reason' => 'invalid credentials'
            ], 400);
        }

        $users = auth()->getProvider();

        try {
            $result = $users->delete($user->id, false)->getResult();
        } catch (\Throwable $th) {
        }

        $u = $users->findById($user->id);
        if ($u == null) {
            return $this->respond(['status' => 'deleted']);
        } else {
            return $this->fail(['status' => 'could not delete'], 500);
        }

    }

}
