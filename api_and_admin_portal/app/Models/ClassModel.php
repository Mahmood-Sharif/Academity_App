<?php

namespace App\Models;

use CodeIgniter\Model;

class ClassModel extends Model
{
    protected $table = 'classes';
    protected $primaryKey = 'class_id';

    protected $allowedFields = [
      'class_name',
      'min_age',
      'max_age',
      'academy_id',
    ];

}
