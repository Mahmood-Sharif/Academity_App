<?php

namespace App\Controllers\Api;

use App\Models\SportModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Sport extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new SportModel();
        $data = array();
        $data['sports'] = $model->orderBy('name')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new SportModel();
        $data = $model->find($id);
        if ($data) {
            return $this->respond($data);
        } else {
            return $this->failNotFound('Sport Not Found');
        }
    }
}
