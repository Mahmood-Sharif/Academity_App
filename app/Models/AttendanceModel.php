<?php

namespace App\Models;

use CodeIgniter\Model;
use DateTime;

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

    public function attendanceForClassNow(int $classId, DateTime $datetime): array
    {
        $date = $datetime->format('Y-m-d');
        $time = $datetime->format('H:i:s');
        return $this->db->table('class_timings')
            ->join('enrollments', 'enrollments.class_id = class_timings.class_id')
            ->join('users', 'enrollments.student_id = users.id', 'left')
            ->join('attendance', 'attendance.student_id = enrollments.student_id AND attendance.date_time = ' . $this->db->escape($date) . ' + INTERVAL class_timings.start_time HOUR_SECOND', 'left')
            ->where($this->db->escape($date) . ' BETWEEN enrollments.start_date AND enrollments.end_date')
            ->where($this->db->escape($time) . ' BETWEEN class_timings.start_time AND class_timings.end_time')
            ->where('class_timings.class_id', $classId)
            ->select('attendance.attendance_id')
            ->select('enrollments.student_id')
            ->select('users.name as student_name')
            ->select("IFNULL(attendance.status, 'Absent') as status")
            ->get()->getResult($this->returnType);
    }

    public function attendanceBetween(int $classId, string $startdate, string|null $enddate): array
    {
        $enddate = $enddate ?? $startdate;
        return $this->db->query('call getAttendance(?, ?, ?)', [$classId, $startdate, $enddate])
            ->getResult($this->returnType);
    }

    public function insertAttendance(int $studentId, string $dateTime, string $status): bool
{
    $data = [
        'student_id' => $studentId,
        'date_time' => $dateTime,
        'status' => $status,
    ];

    return $this->insert($data);
}

public function deleteAttendance(int $studentId, string $dateTime): bool
{
    $condition = [
        'student_id' => $studentId,
        'date_time' => $dateTime,
    ];

    return $this->where($condition)->delete();
}
}

