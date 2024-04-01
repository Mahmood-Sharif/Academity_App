<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use Endroid\QrCode\QrCode;
use Endroid\QrCode\Writer\PngWriter; // Correctly import PngWriter

class QrCodeController extends ResourceController
{
    public function generateForClassSession(int $classId, string $sessionDateTime)
    {
        // Prepare QR code data
        $data = ['classId' => $classId, 'sessionDateTime' => $sessionDateTime];
        $json_data = json_encode($data);

        // Generate QR code
        $qrCode = new QrCode($json_data);

        // Create a PNG writer
        $writer = new PngWriter();

        // Assuming a method to save QR code data exists
        $this->saveQrCodeData($classId, $sessionDateTime, $json_data);

        // Set header for PNG output
        header('Content-Type: image/png');

        // Output QR code
        echo $writer->write($qrCode)->getString();

        // Note: If saving to a file or returning a data URI, adjust accordingly
    }

    protected function saveQrCodeData($classId, $sessionDateTime, $qrData)
    {
        // Implement QR code data saving logic
    }
}
