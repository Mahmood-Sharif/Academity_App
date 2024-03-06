<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Academy extends Entity
{
    protected $casts = [
      'academy_id' => 'integer',
      'phone'      => 'integer',
      'owner_id'   => 'integer',
      'media_id'   => 'integer',
    ];
}
