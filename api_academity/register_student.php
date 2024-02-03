<?php
include 'connection.php';

function registerStudent($connection, $userData) {
    if (!$connection) {
        return ['status' => 'error', 'message' => 'Database connection error'];
    }

    $stmt = $connection->prepare("INSERT INTO students (user_id, age, dob, emergency_contact, first_name, gender, last_name, medical_condition, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    if (!$stmt) {
        return ['status' => 'error', 'message' => 'Prepare statement error'];
    }

    $stmt->bind_param("iisissssi", $userData['user_id'], $userData['age'], $userData['dob'], $userData['emergency_contact'], $userData['first_name'], $userData['gender'], $userData['last_name'], $userData['medical_condition'], $userData['phone']);

    if ($stmt->execute()) {
        $stmt->close();
        return ['status' => 'success', 'message' => 'Student registered successfully'];
    } else {
        $stmt->close();
        return ['status' => 'error', 'message' => 'Failed to register student'];
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $connection = getDbConnection();

    $result = registerStudent($connection, $data);
    $connection->close();

    header('Content-Type: application/json');
    echo json_encode($result);
}
