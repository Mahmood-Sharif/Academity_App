<?php

namespace App\Controllers\Api;

use App\Entities\User;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use Exception;

class Login extends ResourceController
{
    public function loginTest(): ResponseInterface
    {
        return $this->respondNoContent('success');
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
            $user->revokeAllAccessTokens();

            return $this->respond([
              'status'  => 'Login successful',
              'new_token' => $user->generateAccessToken('mobile-app')->raw_token,
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

}
