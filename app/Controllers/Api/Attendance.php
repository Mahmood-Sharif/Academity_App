<?php

namespace App\Controllers\Api;

use App\Models\AttendanceModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use DateTime;
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
