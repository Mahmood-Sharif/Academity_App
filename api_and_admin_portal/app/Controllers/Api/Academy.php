<?php

namespace App\Controllers\Api;

use App\Models\AcademyModel;
use App\Models\ClassModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Academy extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new AcademyModel();
        $data['academy'] = $model->orderBy('name')->findAll();
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

    // New method to get academies by sport ID
    public function academiesBySport($sportId = null): ResponseInterface
    {
        if (!$sportId) {
            return $this->failNotFound('Sport ID is required');
        }

        $model = new AcademyModel();
        $academies = $model->includeImageUrl()->getAcademiesBySportId($sportId);
        if (empty($academies)) {
            return $this->failNotFound("No academies found for sport ID: $sportId");
        }

        return $this->respond(['academies' => $academies]);
    }

    public function getClassDetails($academyId)
    {
        $model = new ClassModel();
        $classes = $model->where('academy_id', $academyId)->findAll();

        if (empty($classes)) {
            return $this->failNotFound('No classes found for this academy.');
        }

        return $this->respond(['classes' => $classes]);
    }
    
}
