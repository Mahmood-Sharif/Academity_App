<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Attendance extends Entity
{
    protected $casts = [
        'attendance_id' => '?integer',
        'student_id'    => 'integer',
        'date_time'     => 'datetime',
        'class_id'      => 'integer',
    ];
}
