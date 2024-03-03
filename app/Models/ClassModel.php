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

}
