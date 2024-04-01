<?php

// app/Controllers/Api/Class.php

namespace App\Controllers\Api;

use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use App\Models\ClassModel;
use App\Models\ClassTimingModel;
use App\Models\EnrollmentModel;

class ClassApi extends ResourceController
{
    public function getClassesWithPrices($classId): ResponseInterface
    {
        $classModel = new ClassModel();
        $timingModel = new ClassTimingModel();

        // Fetch class by ID and include price information
        $classWithPrice = $classModel->includePrice()->find($classId);

        // Check if the class is found
        if (!$classWithPrice) {
            return $this->failNotFound("No class found with ID: $classId");
        }

        // Enhance class information with timing details
        // Since we are dealing with a single class, direct property access is used
        $timings = $timingModel->getTimingsForClass($classWithPrice->class_id);
        $classWithPrice->timings = $timings;

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
