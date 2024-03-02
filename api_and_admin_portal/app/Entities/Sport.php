<?php

namespace App\Entities;

use CodeIgniter\Shield\Entities\User as CodeIgniterUser;

class Sport extends CodeIgniterUser
{
    protected $casts = [
      'sport_id'          => 'integer',
    ];

}
