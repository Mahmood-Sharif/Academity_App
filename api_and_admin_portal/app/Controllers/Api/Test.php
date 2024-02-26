<?php

namespace App\Controllers\Api;

use App\Models\UserModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Test extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new UserModel();
        $data = array();
        $data['hello'] = $model->orderBy('user_id', 'DESC')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new UserModel();
        $data = $model->find($id);
        if ($data) {
            return $this->respond($data);
        } else {
            return $this->failNotFound('User Not Found');
        }
    }
}
