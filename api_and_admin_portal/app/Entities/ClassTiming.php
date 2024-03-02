<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class ClassTiming extends Entity
{
    protected $casts = [
      'timing_id'  => 'integer',
      'class_id'   => 'integer',
      'start_time' => 'datetime',
      'end_time'   => 'datetime',
    ];
}
