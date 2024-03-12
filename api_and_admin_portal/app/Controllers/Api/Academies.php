<?php

namespace App\Controllers\Api;

use App\Models\AcademyModel;
use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Academies extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new AcademyModel();
        $data = array();
        $data['hello'] = $model->orderBy('Academy_id', 'DESC')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new AcademyModel();
        $data = $model->find($id);
        if ($data) {
            return $this->respond($data);
        } else {
            return $this->failNotFound('Academy Not Found');
        }
    }
} 

