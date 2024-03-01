<?php

namespace App\Models;

use CodeIgniter\Model;

class SportModel extends Model
{
    protected $table = 'sports';
    protected $primaryKey = 'sport_id';

    protected $allowedFields = [
      'name',
      'media_id',
    ];

}
