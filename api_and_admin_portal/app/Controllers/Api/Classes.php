<?php

namespace App\Controllers\Api;

use App\Models\ClassTimingModel;
use App\Models\ClassModel;
use App\Models\AcademyModel;
use App\Models\EnrollmentModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use Config\Database;

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

    public function getByAcademyId(): ResponseInterface
    {
        $academyId = $this->request->getGet('academy_id');
        if ($academyId === null) {
            return $this->fail('Academy ID is required.', 400);
        }

        $classModel = new ClassModel();

        // Fetch classes along with their timings and academy details using a database join
        $classes = $classModel->select('classes.*, class_timings.day_of_week, class_timings.start_time, class_timings.end_time, academies.name')
                              ->join('class_timings', 'class_timings.class_id = classes.class_id', 'left')
                              ->join('academies', 'academies.academy_id = classes.academy_id', 'left')
                              ->where('classes.academy_id', $academyId)
                              ->orderBy('classes.class_id', 'DESC')
                              ->findAll();

        if (empty($classes)) {
            return $this->failNotFound('No classes found for the provided academy ID.');
        }

        $data = [
            'classes' => $classes
        ];

        return $this->respond($data);
    }

    public function getByCoachId(): ResponseInterface
    {
        $coachId = auth()->id();

        if ($coachId === null) {
            return $this->fail('Coach ID is required.', 400);
        }

        $classModel = new ClassModel();
        $classTimingModel = new ClassTimingModel();
        $academyModel = new AcademyModel();

        // Fetch classes along with their timings and academy details using a database join
        $classes = $classModel->select('classes.*, class_timings.day_of_week, class_timings.start_time, class_timings.end_time, academies.name')
                              ->join('class_timings', 'class_timings.class_id = classes.class_id', 'left')
                              ->join('academies', 'academies.academy_id = classes.academy_id', 'left')
                              ->where('classes.coach_id', $coachId)
                              ->orderBy('classes.class_id', 'DESC')
                              ->findAll();

        if (empty($classes)) {
            return $this->failNotFound('No classes found for the provided academy ID.');
        }

        $data = [
            'classes' => $classes
        ];

        return $this->respond($data);
    }

    // get class prices and timings
    public function getClassesWithPrices($classId)
    {
        $timingModel = new ClassTimingModel();

        $classWithPrice = Database::connect()->table('classes')
            ->select('classes.class_id, classes.class_name, classes.min_age, classes.max_age, classes.academy_id')
            ->select('classes.max_capacity, classes.min_duration, classes.max_duration, classes.coach_id, classes.reg_code')
            ->select('prices.price')
            ->join('prices', 'prices.class_id = classes.class_id AND prices.end_time IS NULL', 'left')
            ->where('classes.class_id', $classId)
            ->orderBy('prices.start_time', 'DESC')
            ->limit(1)
            ->get()
            ->getRowArray();

        if (!$classWithPrice) {
            return $this->failNotFound("No class found with ID: $classId");
        }

        $classWithPrice['class_id'] = (int) $classWithPrice['class_id'];
        $classWithPrice['min_age'] = (int) $classWithPrice['min_age'];
        $classWithPrice['max_age'] = (int) $classWithPrice['max_age'];
        $classWithPrice['academy_id'] = (int) $classWithPrice['academy_id'];
        $classWithPrice['price'] ??= 'Price Unavailable';
        $classWithPrice['timings'] = $timingModel->getTimingsForClass($classWithPrice['class_id']);

        return $this->respond($classWithPrice);
    }

    public function enrollWithCode(): ResponseInterface
    {
        $studentId = auth()->id(); // get user id from token, requires the token filter to be enabled
        $regCode = $this->request->getPost('regCode');

        if ($studentId == null || empty($regCode)) {
            return $this->fail('Missing student ID or registration code');
        }

        $enrollmentModel = new EnrollmentModel();
        if ($enrollmentModel->isEnrolled($studentId, 0, regCode: $regCode)) {
            return $this->fail('Already enrolled in this class');
        }

        $success = $enrollmentModel->enrolWithCode($studentId, $regCode);

        if (!$success) {
            return $this->fail('Enrollment failed. Class may not exist or be full.');
        }

        return $this->respond('Student successfully enrolled.');
    }

}
