<?php

namespace App\Models;

use CodeIgniter\Model;

class ClassModel extends Model
{
    protected $table = 'classes';
    protected $primaryKey = 'class_id';

    protected $allowedFields = [
      'class_name',
      'min_age',
      'max_age',
      'academy_id',
      'max_capacity',
      'min_duration',
      'max_duration'
    ];

    protected $returnType = \App\Entities\ClassEntity::class;

    public function includePrice(): ClassModel
    {
        return $this
          ->join('prices', 'classes.class_id = prices.class_id')
          ->where('prices.end_time IS NULL')
          ->where('prices.start_time < CURRENT_TIMESTAMP')
          ->select('classes.*, prices.price');
    }

    public function includeOwnerId(): ClassModel
    {
        return $this->join('academies', 'classes.academy_id = academies.academy_id')
                    ->select('classes.*')
                    ->select('academies.owner_id');
    }

    public function limitByOwner(int $id): ClassModel
    {
        return $this->join('academies', 'classes.academy_id = academies.academy_id')
                    ->where('academies.owner_id', $id)
                    ->select('classes.*')
                    ->select('academies.owner_id');
    }
}
