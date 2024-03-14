<?php
namespace App\Controllers\Api;

use App\Models\AcademyModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Academies extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new AcademyModel();
        $data = $model->orderBy('academy_id', 'DESC')->findAll();
        
        // Convert numeric values to integers
        foreach ($data as &$row) {
            $row['academy_id'] = (int) $row['academy_id']; // Example field, replace with your actual field names
            // Cast other numeric fields as needed
        }

        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new AcademyModel();
        $data = $model->find($id);

        if ($data) {
            // Convert numeric values to integers
            $data['academy_id'] = (int) $data['academy_id']; // Example field, replace with your actual field names
            // Cast other numeric fields as needed

            return $this->respond($data);
        } else {
            return $this->failNotFound('Academy Not Found');
        }
    }
}


