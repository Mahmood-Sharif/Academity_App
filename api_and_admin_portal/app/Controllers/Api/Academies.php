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
        foreach ($data as $row) {
            // Access object properties instead of array keys
            $row->academy_id = (int) $row->academy_id; // Example field, replace with your actual field names
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

    public function byCoach(): ResponseInterface
{

    $coachId = $this->request->getGet('coach_id');
    
    // If class_id is not provided, return an error
    if ($coachId === null) {
        return $this->fail('Coach ID is required for filtering.');
    }
    $model = new AcademyModel();

    // Perform join with classes table to filter by coach ID
    $data = $model->distinct()
              ->select('academies.*')
              ->join('classes c', 'academies.academy_id = c.academy_id')
              ->where('c.coach_id', $coachId)
              ->get()
              ->getResultArray();

    // Check if any academies were found
    if (!empty($data)) {
        // Convert numeric values to integers (optional)
        foreach ($data as &$row) {
            $row['academy_id'] = (int) $row['academy_id']; // Example field, replace with your actual field names
            // Cast other numeric fields as needed
        }

        return $this->respond($data);
    } else {
        // Return a "No Academies Found" response with a specific status code
        return $this->respond([
            'status'  => 404,
            'error'   => 'Not Found',
            'message' => 'No Academies Found for Coach ID: ' . $coachId
        ], 404);
    }
}
}


