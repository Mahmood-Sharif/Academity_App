<?php

// app/Controllers/Api/Class.php

namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use App\Models\ClassModel;

class ClassApi extends ResourceController
{
    public function getClassDetails($academyId)
    {
        $model = new ClassModel();
        $classDetails = $model->where('academy_id', $academyId)->includePrice()->findAll();

        return $this->respond(['classes' => $classDetails]);
    }
}
