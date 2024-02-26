<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class User extends Entity
{
    protected $casts = [
      'user_id' => 'integer',
      'dob'     => 'datetime',
      'phone'   => 'integer',
    ];
}
