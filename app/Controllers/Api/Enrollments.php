<?php

namespace App\Controllers\Api;

use App\Models\EnrollmentModel;
use App\Models\StudentModel;
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
    
        // Instantiate the EnrollmentModel
        $enrollmentModel = new EnrollmentModel();
    
        // If class_id is not provided, return an error
        if ($classId === null) {
            return $this->fail('Class ID is required for filtering.');
        }
    
        // Retrieve enrollments by class_id
        $enrollments = $enrollmentModel->where('class_id', $classId)->findAll();
    
        // If no enrollments found, return a failure response
        if (empty($enrollments)) {
            return $this->failNotFound('No enrollments found for the provided class ID.');
        }
    
        // Extract student IDs from enrollments
        $studentIds = array_column($enrollments, 'student_id');
    
        // Instantiate the StudentModel
        $studentModel = new StudentModel();
    
        // Retrieve students by their IDs
        $students = $studentModel->whereIn('student_id', $studentIds)->findAll();
    
        // If no students found, return a failure response
        if (empty($students)) {
            return $this->failNotFound('No students found for the provided class ID.');
        }
    
        return $this->respond($students);
    }
    
    
    
    
} 
