<?php

namespace App\Controllers\Api;

use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

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
}
