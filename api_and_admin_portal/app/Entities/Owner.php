<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Owner extends Entity
{
    protected $casts = [
      'owner_id' => 'integer',
    ];
}
