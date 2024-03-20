<?php

namespace App\Models;

use CodeIgniter\Model;

class ClassTimingModel extends Model
{
    protected $table = 'class_timings';
    protected $primaryKey = 'timing_id';

    protected $allowedFields = [
        'timing_id',
        'class_id',
        'day_of_week',
        'start_time',
        'end_time',
    ];

    protected $returnType = 'array'; // Change the return type to array

    public function getTimingsForClass(int $id): array
    {
        return $this->where('class_id', $id)->findAll();
    }

    public function getScheduleForStudent(int $id, string $fromDate, string $toDate): array
    {
        return $this->db->query('call getStudentSchedule(?, ?, ?)', [$id, $fromDate, $toDate])->getResult();
    }

   
}
