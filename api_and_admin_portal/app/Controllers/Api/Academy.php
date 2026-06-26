<?php

namespace App\Controllers\Api;

use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use Config\Database;
use DateTimeImmutable;
use DateTimeZone;

class Academy extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new \App\Models\AcademyModel();
        $data = [];
        $data['academy'] = $model->orderBy('name')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new \App\Models\AcademyModel();
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

        $model = new \App\Models\AcademyModel();
        $academies = $model->includeImageUrl()->getAcademiesBySportId($sportId);
        if (empty($academies)) {
            return $this->failNotFound("No academies found for sport ID: $sportId");
        }

        return $this->respond(['academies' => $academies]);
    }

    public function getClassDetails($academyId): ResponseInterface
    {
        $model = new \App\Models\ClassModel();
        $classes = $model->where('academy_id', $academyId)->findAll();

        if (empty($classes)) {
            return $this->failNotFound('No classes found for this academy.');
        }

        return $this->respond(['classes' => $classes]);
    }

    public function getEnrolledAcademiesDetails(): ResponseInterface
    {
        $studentId = auth()->id();
        if ($studentId === null) {
            return $this->failUnauthorized('A valid API token is required.');
        }

        $date = (new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain')))->format('Y-m-d');
        $db = Database::connect();

        $rows = $db->table('enrollments')
            ->select('enrollments.enrollment_id, enrollments.start_date, enrollments.end_date, enrollments.price_value')
            ->select('classes.class_id, classes.class_name, classes.min_age, classes.max_age, classes.academy_id')
            ->select('academies.location, academies.name, academies.phone, academies.description')
            ->select('prices.price')
            ->select('CONCAT(' . $db->escape(base_url()) . ', media.url) AS image_url', false)
            ->join('classes', 'classes.class_id = enrollments.class_id')
            ->join('academies', 'academies.academy_id = classes.academy_id')
            ->join('media', 'media.media_id = academies.media_id', 'left')
            ->join('prices', 'prices.class_id = classes.class_id AND prices.end_time IS NULL', 'left')
            ->where('enrollments.student_id', $studentId)
            ->where('enrollments.end_date >=', $date)
            ->orderBy('academies.name', 'ASC')
            ->orderBy('classes.class_name', 'ASC')
            ->get()
            ->getResultArray();

        $structuredData = [];
        foreach ($rows as $row) {
            $academyId = (int) $row['academy_id'];

            if (! isset($structuredData[$academyId])) {
                $structuredData[$academyId] = [
                    'academy_id'  => $academyId,
                    'location'    => $row['location'],
                    'name'        => $row['name'],
                    'phone'       => $row['phone'],
                    'description' => $row['description'],
                    'image_url'   => $row['image_url'] ?? '',
                    'classes'     => [],
                ];
            }

            $structuredData[$academyId]['classes'][] = [
                'enrollment_id' => (int) $row['enrollment_id'],
                'class_id'      => (int) $row['class_id'],
                'class_name'    => $row['class_name'],
                'min_age'       => (int) $row['min_age'],
                'max_age'       => (int) $row['max_age'],
                'academy_id'    => $academyId,
                'price'         => $row['price_value'] ?? $row['price'] ?? 'Price Unavailable',
                'start_date'    => $row['start_date'],
                'end_date'      => $row['end_date'],
                'timings'       => [],
            ];
        }

        return $this->respond(['academiesDetails' => array_values($structuredData)]);
    }
}
