<?php

namespace App\Controllers\Api;

use App\Models\ClassModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Classes extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new ClassModel();
        $data = array();
        $data['classes'] = $model->orderBy('class_id', 'DESC')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new ClassModel();
        $data = $model->find($id);
        if ($data) {
            return $this->respond($data);
        } else {
            return $this->failNotFound('Class Not Found');
        }
    }
}
