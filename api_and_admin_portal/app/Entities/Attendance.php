<?php

namespace App\Entities;

use CodeIgniter\Entity\Entity;

class Attendance extends Entity
{
    protected $casts = [
        'student_id'      => 'integer',
        'date_time'       => 'datetime',
    ];
}
