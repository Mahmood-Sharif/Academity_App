<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Transaction extends Entity
{
    protected $casts = [
      'transaction_id' => 'integer',
      'timestamp'      => 'datetime',
      'enrollment_id'  => 'integer',
    ];
}
