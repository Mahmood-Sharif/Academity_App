<?php

namespace App\Controllers\Api;

use App\Models\AcademyModel;
use App\Models\ClassModel;
use App\Models\EnrollmentModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use DateTimeImmutable;
use DateTimeZone;

class Academy extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new AcademyModel();
        $data = [];
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

    public function getClassDetails($academyId): ResponseInterface
    {
        $model = new ClassModel();
        $classes = $model->where('academy_id', $academyId)->findAll();

        if (empty($classes)) {
            return $this->failNotFound('No classes found for this academy.');
        }

        return $this->respond(['classes' => $classes]);
    }

    public function getEnrolledAcademiesDetails(): ResponseInterface
    {
        $academyModel = new AcademyModel();
        $classModel = new ClassModel();
        $enrollmentModel = new EnrollmentModel();

        // Assuming this retrieves the currently logged-in user's ID correctly
        $student_id = auth()->id();

        $date = (new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain')))->format('Y-m-d');

        $academies = $academyModel->includeImageUrl()
            ->join('classes', 'classes.academy_id = academies.academy_id')
            ->join('enrollments', 'enrollments.class_id = classes.class_id')
            ->where('enrollments.student_id', $student_id)
            ->where("enrollments.end_date >= '$date'")
            ->findAll();

        // Assuming EnrollmentModel is related to Classes and Academies, and you have a method to join user details
        $enrollments = array_map(fn ($e) => $e->toArray(), $classModel
            ->includePrice()
            ->join('enrollments', 'enrollments.class_id = classes.class_id')
            ->where('enrollments.student_id', $student_id)
            ->where("enrollments.end_date >= '$date'")
            ->select('enrollments.*')
            ->findAll());

        if (empty($enrollments)) {
            return $this->failNotFound('No enrollments found for this user.');
        }

        $enrollmentsGrouped = array_group_by($enrollments, ['academy_id']);


        // Assuming you need to format the data into a structured array
        $structuredData = [];
        foreach ($academies as $academy) {
            $structuredData[$academy->academy_id] = $academy->toArray();
            $structuredData[$academy->academy_id]['classes'] = $enrollmentsGrouped[$academy->academy_id];
        }

        return $this->respond(['academiesDetails' => array_values($structuredData)]);
    }
}
