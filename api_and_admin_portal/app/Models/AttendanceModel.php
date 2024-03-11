<?php

namespace App\Models;

use CodeIgniter\Model;

class AttendanceModel extends Model
{
    protected $table = 'attendance';
    protected $primaryKey = 'attendance_id';

    protected $allowedFields = [
        'student_id',
        'date_time', // date + class start time
        'status',
    ];

    protected $returnType = \App\Entities\Attendance::class;

    public function attendanceBetween(int $classId, string $startdate, string|null $enddate): array
    {
        $enddate = $enddate ?? $startdate;
        return $this->db->query('call getAttendance(?, ?, ?)', [$classId, $startdate, $enddate])
            ->getResult($this->returnType);
    }

}
