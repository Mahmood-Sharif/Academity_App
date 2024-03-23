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

    public function verifyAndLogAttendance(): ResponseInterface
    {
        $scannedData = $this->request->getPost('scannedData');
        $scannedData = $this->request->getPost('scannedData');
        if (is_null($scannedData) || is_array($scannedData)) {
            return $this->fail('Invalid scanned data format', 400);
        }

        // Check if the QR code data is valid
        $decodedData = json_decode($scannedData, true);
        if (is_null($decodedData)) {
            // JSON decode failed or the data is not a valid JSON
            return $this->fail('Invalid JSON format in scanned data', 400);
        }

        // Proceed with the rest of the method...
        if ($this->isQrCodeValid($decodedData)) {
            $studentId = $this->request->getPost('studentId');
            $classId = $decodedData['classId'];
            $sessionDateTime = $decodedData['sessionDateTime'];

            if ($this->model->logAttendance($studentId, $classId, $sessionDateTime)) {
                return $this->respond(['message' => 'Attendance logged successfully']);
            } else {
                return $this->failServerError('Failed to log attendance');
            }
        } else {
            return $this->failNotFound('Invalid QR code');
        }
    }

    public function isQrCodeValid($data)
    {
        // Validate QR code data, e.g., check if class session exists for given ID and datetime
        // This validation can include checking the classId and sessionDateTime against stored data
    }
}
