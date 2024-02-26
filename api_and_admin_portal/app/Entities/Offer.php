<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Offer extends Entity
{
    protected $casts = [
      'offer_id' => 'integer',
    ];
}
