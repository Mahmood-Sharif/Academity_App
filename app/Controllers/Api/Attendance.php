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
            !empty($customDateTime)
            ? (new DateTime($customDateTime))
            : (new DateTime('now', new DateTimeZone('Asia/Bahrain')));

        $attendance = $this->model->attendanceForClassNow($classId, $currentDateTime);

        if ($attendance) {
            return $this->respond($attendance);
        } else {
            return $this->failNotFound('No attendance for now: ' . $currentDateTime->format(DateTime::ISO8601));
        }
    }

    // Log attendance manually (coaches app)
    public function postAttendance(): ResponseInterface
    {
        log_message('critical', var_export($this->request->getPost(), true));
        $studentId = $this->request->getPost('student_id');
        $classId = $this->request->getPost('class_id');
        $status = $this->request->getPost('status');
        $datetime = $this->request->getPost('datetime');
        if (empty($status)) {
            $status = 'Present';
        }
        if (empty($datetime)) {
            $datetime = new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain'));
        } else {
            $datetime = new DateTimeImmutable($datetime);
        }

        if (empty($classId)  || empty($studentId)) {
            return $this->fail('Invalid request', 400);
        }

        $dow = strtoupper($datetime->format('D'));
        $start = $datetime->sub(new DateInterval('PT10M'));
        $end = $datetime->setTime(23, 59, 59);

        $classTiming = (new ClassTimingModel())
        ->join('enrollments', 'enrollments.class_id = class_timings.class_id', 'left')
        ->where('enrollments.student_id', $studentId)
        ->where('enrollments.class_id', $classId)
        ->where("'$dow' = class_timings.day_of_week")
        ->where("'{$datetime->format('H:i:s')}' BETWEEN class_timings.start_time and class_timings.end_time")
        ->select()
        ->first();

        if ($classTiming === null) {
            return $this->fail('The class is not running now', 500);
        }

        $hour = substr($classTiming->start_time, 0, 2);
        $minute = substr($classTiming->start_time, 3, 2);
        $datetime = $datetime->setTime($hour, $minute)->format(DateTimeImmutable::ATOM);

        $result = false;
        if ($id = $this->model->attendanceExists($studentId, $datetime, $classId)) {
            $result = $this->model->update($id, ['status' => $status]);
        } else {
            $result = $this->model->insert([
                        'student_id' => $studentId,
                        'date_time' => $datetime,
                        'status' => $status,
                        'class_id' => $classId,
                    ]);
        }

        if ($result) {
            return $this->respond([
                'message' => 'Attendance logged successfully',
            ]);
        } else {
            return $this->failServerError('Failed to log attendance');
        }

    }

    // Log attendance with QR code
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

    public function getAttendanceBetween(int $classId, string $startdate, string $enddate): ResponseInterface
    {
        $attendance = $this->model->attendanceBetween($classId, $startdate, $enddate);

        if ($attendance) {
            return $this->respond($attendance);
        } else {
            return $this->failNotFound('No attendance between ' . $startdate . ' and ' . $enddate);
        }
    }

    public function insertAttendance(): ResponseInterface
    {
        $studentId = $this->request->getVar('student_id');
        $dateTime =  $this->request->getVar('date_time');
        $status = $this->request->getVar('status');
        //$status = "Present";
        if ($studentId === null) {
            return $this->failValidationError('Student ID is required.');
        }

        $model = new AttendanceModel();

        if ($model->insertAttendance($studentId, $dateTime, $status)) {
            return $this->respondCreated('Attendance inserted successfully.');
        } else {
            return $this->failServerError('Failed to insert attendance.');
        }
    }

    public function deleteAttendance(int $studentId, string $dateTime): ResponseInterface
    {
        $model = new AttendanceModel();

        if ($model->deleteAttendance($studentId, $dateTime)) {
            return $this->respondDeleted('Attendance deleted successfully.');
        } else {
            return $this->failServerError('Failed to delete attendance.');
        }
    }
}
