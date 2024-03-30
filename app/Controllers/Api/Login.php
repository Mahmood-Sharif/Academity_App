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
        $r = $this->respond(['user' => [
            ...auth()->user()->toArray(),
            'email' => auth()->user()->getEmail()
        ]]);
        log_message('error', var_export($r, true));
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

            $r = $this->respond([
                'status'  => 'Login successful',
                'new_token' => $user->generateAccessToken('mobile-app')->raw_token,
                'user' => [...$user->toArray(), 'email' => $credentials['email']],
            ]);
            log_message('error', var_export($r, true));
            return $r;
        } else {
            $r = $this->respond([
                'status'  => 'Login failed',
                'message' => $loginAttempt->reason(),
            ]);
            log_message('error', var_export($r, true));
            return $r;
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

    public function getUserProfile(): ResponseInterface
    {
        $token = $this->request->header('Authorization');
        $token = str_replace('Bearer ', '', $token);
        log_message('debug', 'Fetching profile with token: ' . $token);

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
            log_message('error', 'Profile fetch exception: ' . $e->getMessage());
            return $this->respond(['status' => 'Failed', 'message' => $e->getMessage()], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    // public function updateUserProfile(): ResponseInterface
    // {
    //     try {
    //         $user = auth()->user();
    //         log_message('info', "Raw POST Data: " . file_get_contents('php://input')); // Add this line

    //         if (!$user) {
    //             return $this->respond(['status' => 'Failed', 'message' => 'User not found'], ResponseInterface::HTTP_NOT_FOUND);
    //         }

    //         $r = auth()->getProvider()->getValidationRules();
    //         $updatedData = $this->request->getPost($r);

    //         // Check if updatedData is empty
    //         if (empty($updatedData)) {
    //             return $this->respond(['status' => 'Failed', 'message' => 'No data provided for update'], ResponseInterface::HTTP_BAD_REQUEST);
    //         }

    //         if (!auth()->getProvider()->validate($updatedData)) {
    //             return $this->respond(['status' => 'Failed', 'message' => 'Validation failed for user profile'], ResponseInterface::HTTP_BAD_REQUEST);
    //         }

    //         if (auth()->getProvider()->update($user->id, $updatedData)) {
    //             return $this->respond(['status' => 'Success', 'message' => 'User profile updated successfully']);
    //         } else {
    //             return $this->respond(['status' => 'Failed', 'message' => 'Failed to update user profile'], ResponseInterface::HTTP_BAD_REQUEST);
    //         }
    //     } catch (Exception $e) {
    //         log_message('critical', "Error updating user profile for user {$user->id}: " . $e->getMessage());
    //         log_message('info', "Data attempted to update: " . json_encode($updatedData));
    //         return $this->respond(['status' => 'Failed', 'message' => 'Internal server error.'], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
    //     }
    // }

    public function updateUserProfile(): ResponseInterface
    {    
        try {
            // Assuming 'auth()' can decode the token and fetch the user
            $user = auth()->user();
    
            if (!$user) {
                return $this->respond(['status' => 'Failed', 'message' => 'User not found'], ResponseInterface::HTTP_NOT_FOUND);
            }
    
            // Extract data from the request body
            $data = $this->request->getPost();
    

                // Optionally reload the user to reflect the latest state
                // $user = auth()->getProvider()->findById($user->id);
            
                // Prepare $updatedData based on the refreshed $user object
                $updatedData = [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->getEmail(), // Assuming getEmail() is the correct method
                    'phone' => $user->phone,
                    'dob' => $user->dob,
                    'gender' => $user->gender,
                    // Include additional fields as needed
                ];
            
                // Return success response with populated $updatedData
                return $this->respond([
                    'status' => 'Success',
                    'message' => 'Profile updated successfully',
                    'user' => $updatedData,
                ]);
            

            foreach ($data as $key => $value) {
                if (property_exists($user, $key)) {
                    $user->$key = $value;
                    $updatedData[$key] = $value; // Prepare data for explicit update if needed
                }
            }
    
            // Attempt to save/update the user details
            // Note: Adjust this part according to your specific user model/entity save or update method
            $result = auth()->getProvider()->save($user); // Assuming this method exists and correctly updates the user
            
            if (!$result) {
                log_message('error', "Failed to update user profile for user {$user->id}.");
                return $this->respond(['status' => 'Failed', 'message' => 'Failed to update profile'], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
            }
    
            // Success response
            return $this->respond([
                'status' => 'Success',
                'message' => 'Profile updated successfully',
                'user' => $updatedData, // Optionally return only the updated fields
            ]);
        } catch (Exception $e) {
            log_message('critical', "Error updating user profile for user {$user->id}: " . $e->getMessage());
            log_message('info', "Data attempted to update: " . json_encode($data)); // Assuming $data is available
            return $this->respond(['status' => 'Failed', 'message' => 'Internal server error.'], ResponseInterface::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
    
}
