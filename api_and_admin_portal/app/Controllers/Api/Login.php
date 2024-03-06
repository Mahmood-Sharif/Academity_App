<?php

namespace App\Controllers\Api;

use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Login extends ResourceController
{
    public function loginUser(): ResponseInterface
    {
        // get data from request
        $credentials = [
          'email'    => $this->request->getPost('email'),
          'password' => $this->request->getPost('password'),
        ];

        $loginAttempt = auth()->check($credentials);

        if ($loginAttempt->isOK()) {
            // TODO: send API access token
            return $this->respond([
              'status'  => 'Login successful',
              'new_token' => null,
            ]);
        } else {
            return $this->respond([
              'status'  => 'Login failed',
              'message' => $loginAttempt->reason(),
            ]);
        }
    }
}
