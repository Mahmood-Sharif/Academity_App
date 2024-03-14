<?php

namespace App\Controllers\Api;

use App\Models\StudentModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Students extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new StudentModel();
        $data = array();
        $data['hello'] = $model->orderBy('student_id', 'DESC')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new StudentModel();
        $data = $model->find($id);
        if ($data) {
            return $this->respond($data);
        } else {
            return $this->failNotFound('Student Not Found');
        }
    }
} 
