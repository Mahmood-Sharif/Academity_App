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

        // Fetch the profile image URL from the 'media' table
        $profileImageUrl = null;
        if ($user->profile_image) {
            $mediaModel = new \App\Models\MediaModel(); // Replace with your actual Media model
            $media = $mediaModel->find($user->profile_image);
            if ($media) {
                $profileImageUrl = base_url($media->url); // Assuming the media URL is relative
            }
        }

        // Construct the user profile data including the profile image URL
        $userData = [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->getEmail(),
            'phone' => $user->phone,
            'dob' => $user->dob,
            'gender' => $user->gender,
            'profile_image_url' => $profileImageUrl, // Add the profile image URL here
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

        // Handle the uploaded image
        $uploadedFile = $this->request->getFile('profile_image');

        if ($uploadedFile && $uploadedFile->isValid()) {
            // Upload the image and get the media ID
            $mediaModel = new \App\Models\MediaModel();
            $uploadResult = $mediaModel->uploadMedia($uploadedFile);

            if (isset($uploadResult['errors'])) {
                return $this->respond(['status' => 'Failed', 'message' => $uploadResult['errors']], ResponseInterface::HTTP_BAD_REQUEST);
            }

            // Update the user's profile image with the new media ID
            $user->profile_image = $uploadResult['media_id'];
        }

        // Update other user profile fields if necessary
        $rules = (new ValidationRules())->getRegistrationRules();
        unset($rules['password']);
        unset($rules['password_confirm']);
        $updatedData = $this->request->getPost(array_keys($rules));

        if (!empty($updatedData)) {
            $user->fill($updatedData);
        }

        // Save the updated user
        $users = auth()->getProvider();
        if ($users->save($user)) {
            // Construct the response data
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
                'message' => 'User profile updated successfully',
                'user' => $userData,
            ]);
        } else {
            return $this->respond(['status' => 'Failed', 'message' => 'Failed to update user profile'], ResponseInterface::HTTP_BAD_REQUEST);
        }
    } catch (Exception $e) {
        return $this->respond(['status' => 'Failed', 'message' => 'Internal server error.'], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
    }
}

    public function checkPassword(): ResponseInterface
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

        $loginAttempt = auth()->check($credentials);

        if ($loginAttempt->isOK()) {
            return $this->respond('success');
        } else {
            return $this->fail('invalid');
        }
    }

    public function deleteAccount(): ResponseInterface
    {
        $user = auth()->user();
        if ($user->inGroup('admin')) {
            return $this->respond([
                'status' => 'cannot delete',
                'reason' => 'academy owner',
            ]);
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
            return $this->fail('could not delete', 500);
        }

    }

}
