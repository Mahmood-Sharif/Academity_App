<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class ClassEntity extends Entity
{
    protected $casts = [
      'class_id'         => 'integer',
      'min_age'          => 'integer',
      'max_age'          => 'integer',
      'academy_id'       => 'integer',
      'min_duration'     => 'integer',
      'max_duration'     => 'integer',
      'max_capacity'     => 'integer',
      'coach_id'         => 'integer',

      // joined columns
      'owner_id'         => 'integer',
      'classes_per_week' => 'integer',
      'num_enrollments'  => 'integer',
    ];
}
