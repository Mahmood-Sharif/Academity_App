<?php

namespace App\Controllers\Api;

use App\Models\AttendanceModel;
use App\Models\ClassModel;
use App\Models\ClassTimingModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use DateInterval;
use DateTime;
use DateTimeImmutable;
use DateTimeZone;

class Attendance extends ResourceController
{
    protected $modelName = '\App\Models\AttendanceModel';
    /* @var AttendanceModel $model */
    protected $model;

    public function getAttendanceForClassNow(int $classId): ResponseInterface
    {
        // TODO: Check if there is class now

        $customDateTime = $this->request->getGet('datetime');
        // NOTE: if no time is passed by GET parameter, assumes Bahrain timezone (UTC+3)
        $currentDateTime =
            $customDateTime !== null
            ? (new DateTime($customDateTime))
            : (new DateTime('now', new DateTimeZone('Asia/Bahrain')));

        $attendance = $this->model->attendanceForClassNow($classId, $currentDateTime);

        if ($attendance) {
            return $this->respond($attendance);
        } else {
            return $this->failNotFound('No attendance for now: ' . $currentDateTime->format(DateTime::ISO8601));
        }
    }

    public function logAttendance(): ResponseInterface
    {
        $studentId = auth()->id();
        $classId = $this->request->getPost('class_id');
        $datetime = $this->request->getPost('datetime');

        if ($classId === null || $datetime === null) {
            return $this->fail('Invalid scanned data format', 400);
        }

        $class = (new ClassModel())->find($classId);

        if ($class === null) {
            return $this->fail('Class does not exist', 404);
        }

        $datetime = new DateTimeImmutable($datetime);
        $dow = strtoupper($datetime->format('D'));
        $start = $datetime->sub(new DateInterval('PT10M'));
        $end = $datetime->setTime(23, 59, 59);

        $classTiming = (new ClassTimingModel())
        ->join('enrollments', 'enrollments.class_id = class_timings.class_id', 'cross')
        ->where('enrollments.student_id', $studentId)
        ->where('enrollments.class_id', $classId)
        ->where("'$dow' = class_timings.day_of_week")
        ->where("'{$datetime->format('Y-m-d')}' BETWEEN enrollments.start_date and enrollments.end_date")
        ->where("'{$datetime->format('H:i:s')}' BETWEEN class_timings.start_time and class_timings.end_time")
        ->select()
        ->first();

        log_message('critical', 'HMMMMMMMMMM ' . var_export($classTiming, true));

        if ($classTiming === null) {
            return $this->fail('The class is not running now', 500);
        }

        $hour = substr($classTiming->start_time, 0, 2);
        $minute = substr($classTiming->start_time, 3, 2);
        $datetime = $datetime->setTime($hour, $minute)->format(DateTimeImmutable::ATOM);

        if ($this->model->attendanceExists($studentId, $datetime, $classId)) {
            return $this->respond(['message' => 'Attendance already logged today.']);
        }

        if ($this->model->insert([
            'student_id' => $studentId,
            'date_time' => $datetime,
            'status' => 'Present',
            'class_id' => $classId,
        ])) {
            return $this->respond([
                'message' => 'Attendance logged successfully',
                'class' => $class->class_name,
            ]);
        } else {
            return $this->failServerError('Failed to log attendance');
        }
    }
}
