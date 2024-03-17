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
        'max_duration',
        'coach_id'
    ];

    protected $validationRules = [
      'class_name'   => 'string|required|min_length[3]|max_length[100]',
      'min_age'      => 'integer|required|is_natural_no_zero',
      'max_age'      => 'integer|required|is_natural_no_zero',
      'max_capacity' => 'integer|required|is_natural_no_zero',
      'min_duration' => 'integer|required|is_natural_no_zero',
      // 'max_duration' => 'integer|required|is_natural_no_zero',
      'coach_id'     => 'integer|required|is_natural_no_zero',
    ];
    protected $validationMessages = [
      'timings' => [
        'valid_json' => 'Rules.class.timings',
      ]
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
