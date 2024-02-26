<?php

namespace App\Models;

use CodeIgniter\Model;

class AcademyModel extends Model
{
    protected $table = 'academies';
    protected $primaryKey = 'academy_id';

    protected $allowedFields = [
      'location',
      'name',
      'phone',
      'description',
      'media_id',
      'owner_id',
    ];

}
