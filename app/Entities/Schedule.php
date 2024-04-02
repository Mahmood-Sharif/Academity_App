<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Schedule extends Entity
{
    protected $casts = [
      'class_id'   => 'integer',
    ];
}
