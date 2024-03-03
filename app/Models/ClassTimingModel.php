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

    protected $returnType = \App\Entities\ClassEntity::class;

    public function getTimingsForClass(int $id)
    {
        return $this->where('class_id', $id)->findAll();
    }

}
