<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class ClassEntity extends Entity
{
    protected $casts = [
      'class_id'   => 'integer',
      'min_age'    => 'integer',
      'max_age'    => 'integer',
      'academy_id' => 'integer',

      'student_id'   => 'integer',
    ];
}
