<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Media extends Entity
{
    protected $casts = [
      'media_id' => 'integer',
    ];
}
