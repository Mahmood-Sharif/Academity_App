<?php

namespace App\Controllers\Api;

use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Test extends ResourceController
{
    public function get(): ResponseInterface
    {
        return $this->fail(['status' => 'hello'], 400);
    }

    public function post(): ResponseInterface
    {
        return $this->fail('hello');
    }
}
