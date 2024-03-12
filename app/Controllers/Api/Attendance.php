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
}
