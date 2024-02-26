<?php

namespace App\Models;

use CodeIgniter\Model;

class EnrollmentModel extends Model
{
    protected $table = 'enrollments';
    protected $primaryKey = 'enrollment_id';

    protected $allowedFields = [
      'start_date',
      'end_date',
      'student_id',
      'class_id',
    ];

    protected $returnType = \App\Entities\Enrollment::class;

}
