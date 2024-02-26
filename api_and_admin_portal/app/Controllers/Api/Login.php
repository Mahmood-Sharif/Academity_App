<?php

namespace App\Controllers\Api;

use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Login extends ResourceController
{
    public function loginUser(): ResponseInterface
    {
        // get data from request
        $email = $this->request->getVar('email');
        $password = $this->request->getVar('password');

        $model = new UserModel();
        // get user with email and password
        // TODO: use password_hash
        $user = $model->where('email', $email)->where('password', $password)->first();

        if ($user) {
            return $this->respond([
              'status'  => 'Login successful',
              'user_id' => $user['user_id'],
              'email'   => $user['email'],
            ]);
        } else {
            return $this->respond([
              'status'  => 'Login failed',
              'message' => 'Invalid credentials',
            ]);
        }
    }
}
