<?php

namespace App\Controllers\Api;

use App\Models\ClassTimingModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class Schedule extends ResourceController
{
    protected $modelName = '\App\Models\ClassTimingModel';
    /* @var ClassTimingModel $model */
    protected $model;

    public function getScheduleForStudent(): ResponseInterface
    {
        $student_id = $this->request->getGetPost('student_id');
        $fromDate = $this->request->getGetPost('from_date');
        $toDate = $this->request->getGetPost('to_date');

        $schedule = $this->model->getScheduleForStudent($student_id, $fromDate, $toDate);

        if ($schedule) {
            return $this->respond($schedule);
        } else {
            return $this->failNotFound('No schedue');
        }
    }

    public function getScheduleForCoach(): ResponseInterface
    {
        $coach_id = $this->request->getGetPost('coach_id');
        $fromDate = $this->request->getGetPost('from_date');
        $toDate = $this->request->getGetPost('to_date');

        $schedule = $this->model->getScheduleForCoach($coach_id, $fromDate, $toDate);

        if ($schedule) {
            return $this->respond($schedule);
        } else {
            return $this->failNotFound('No schedue');
        }
    }
}
