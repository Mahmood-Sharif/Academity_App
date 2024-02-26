<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class User extends Entity
{
    protected $casts = [
      'enrollment_id' => 'integer',
      'start_date'    => 'datetime',
      'end_date'      => 'datetime',
      'student_id'    => 'integer',
      'class_id'      => 'integer',
    ];
}
