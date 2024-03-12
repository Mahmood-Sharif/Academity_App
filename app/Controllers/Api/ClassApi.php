<?php

// app/Controllers/Api/Class.php

namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use App\Models\ClassModel;
use App\Models\ClassTimingModel;

class ClassApi extends ResourceController
{
    public function getClassesWithPrices($classId)
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
}

