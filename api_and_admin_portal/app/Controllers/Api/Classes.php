<?php

namespace App\Controllers\Api;
use App\Models\ClassTimingModel;
use App\Models\ClassModel;
use App\Models\AcademyModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Classes extends ResourceController
{
    public function index(): ResponseInterface
{
    $classModel = new ClassModel();
    $classTimingModel = new ClassTimingModel();
    $academy = new AcademyModel();
    // Fetch classes along with their timings and academy details using a database join
    $classes = $classModel->select('classes.*, class_timings.day_of_week, class_timings.start_time, class_timings.end_time, academies.name')
                          ->join('class_timings', 'class_timings.class_id = classes.class_id', 'left')
                          ->join('academies', 'academies.academy_id = classes.academy_id', 'left')
                          ->orderBy('classes.class_id', 'DESC')
                          ->findAll();

    $data = [
        'classes' => $classes
    ];

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
