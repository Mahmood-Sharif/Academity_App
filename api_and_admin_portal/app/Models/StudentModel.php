<?php

namespace App\Models;

use CodeIgniter\Model;

class StudentModel extends Model
{
    protected $table = 'students';
    protected $primaryKey = 'student_id';

    protected $allowedFields = [
      'dob',
      'phone',
      'emergency_contact',
      'first_name',
      'last_name',
      'gender',
      'medical_condition',
    ];

}
