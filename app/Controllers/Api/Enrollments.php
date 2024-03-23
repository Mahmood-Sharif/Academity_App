<?php

namespace App\Controllers\Api;

use App\Models\EnrollmentModel;
use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Enrollments extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new EnrollmentModel();
        $data = array();
        $data['hello'] = $model->orderBy('enrollment_id', 'DESC')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new EnrollmentModel();
        $data = $model->find($id);
        if ($data) {
            return $this->respond($data);
        } else {
            return $this->failNotFound('enrollment Not Found');
        }
    }

    public function getStudentsByClassId(): ResponseInterface
    {
        // Retrieve the class_id query parameter from the request
        $classId = $this->request->getGet('class_id');
    
        // If class_id is not provided, return an error
        if ($classId === null) {
            return $this->fail('Class ID is required for filtering.');
        }
    
        // Instantiate the StudentModel
        $userModel = new UserModel();
    
        // Perform a join query to retrieve students and their enrollments
        $users = $userModel->select('users.*, enrollments.*')
                                 ->join('enrollments', 'enrollments.student_id = users.id')
                                 ->where('enrollments.class_id', $classId)
                                 ->findAll();
    
        // If no students found, return a failure response
        if (empty($users)) {
            return $this->failNotFound('No students found for the provided class ID.');
        }
    
        return $this->respond($users);
    }
    

    
    
    
    
} 
