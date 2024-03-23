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
      // $user->revokeAllAccessTokens();

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
    log_message('debug', 'Attempting to logout with token: ' . $token);

    try {
      $result = auth()->revokeAccessToken($token);
      log_message('debug', 'Token revocation result: ' . print_r($result, true));

      if ($result) {
        return $this->respondDeleted(['status' => 'Logout successful']);
      } else {
        return $this->respond(['status' => 'Logout failed'], ResponseInterface::HTTP_BAD_REQUEST);
      }
    } catch (Exception $e) {
      log_message('error', 'Logout exception: ' . $e->getMessage());
      return $this->respond(['status' => 'Logout failed', 'message' => $e->getMessage()], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
    }
  }

  public function getUserProfile(): ResponseInterface
  {
    $token = $this->request->getHeaderLine('Authorization');
    $token = str_replace('Bearer ', '', $token);
    log_message('debug', 'Fetching profile with token: ' . $token);

    try {
      // Assuming 'auth()' can decode the token and fetch the user
      $user = auth()->getUser($token);

      if (!$user) {
        return $this->respond(['status' => 'Failed', 'message' => 'User not found'], ResponseInterface::HTTP_NOT_FOUND);
      }

      // Assuming the User entity or model has a method to expose necessary data safely
      $userData = [
        'id' => $user->id,
        'name' => $user->name,
        'email' => $user->email,
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
      log_message('error', 'Profile fetch exception: ' . $e->getMessage());
      return $this->respond(['status' => 'Failed', 'message' => $e->getMessage()], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
    }
  }

  public function updateUserProfile(): ResponseInterface
  {
    $token = $this->request->getHeaderLine('Authorization');
    $token = str_replace('Bearer ', '', $token);

    try {
      $user = auth()->getUser($token);

      if (!$user) {
        return $this->respond(['status' => 'Failed', 'message' => 'User not found'], ResponseInterface::HTTP_NOT_FOUND);
      }

      // Get updated data from request
      $updatedData = $this->request->getJSON(true);

      // Validate updated data as needed
      // ...

      // Update user data
      if (isset($updatedData['name'])) $user->name = $updatedData['name'];
      if (isset($updatedData['email'])) $user->email = $updatedData['email'];
      if (isset($updatedData['phone'])) $user->phone = $updatedData['phone'];
      if (isset($updatedData['dob'])) $user->dob = $updatedData['dob'];
      if (isset($updatedData['gender'])) $user->gender = $updatedData['gender'];
      // Add more fields as necessary

      // Assuming you have a method to save the updated user object
      if (auth()->saveUser($user)) {
        return $this->respond(['status' => 'Success', 'message' => 'User profile updated successfully']);
      } else {
        return $this->respond(['status' => 'Failed', 'message' => 'Failed to update user profile'], ResponseInterface::HTTP_BAD_REQUEST);
      }
    } catch (Exception $e) {
      return $this->respond(['status' => 'Failed', 'message' => $e->getMessage()], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
    }
  }
}
