<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Sport extends Entity
{
    protected $casts = [
      'sport_id'          => 'integer',
    ];

}
