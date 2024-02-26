<?php

namespace App\Models;

use CodeIgniter\Model;

class SportModel extends Model
{
    protected $table = 'sports';
    protected $primaryKey = 'sport_name';

    protected $allowedFields = [
      'media_id',
    ];

}
