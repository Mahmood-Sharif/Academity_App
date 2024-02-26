<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Student extends Entity
{
    protected $casts = [
      'student_id'        => 'integer',
      'dob'               => 'datetime',
      'phone'             => 'integer',
      'emergency_contact' => 'integer',
    ];
}
