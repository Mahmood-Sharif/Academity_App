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
          'email'    => $this->request->getVar('email'),
          'password' => $this->request->getVar('password'),
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
