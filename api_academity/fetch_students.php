<?php
include 'connection.php';

$userId = $_GET['userId'];

$query = "SELECT * FROM students WHERE user_id = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("i", $userId);
$stmt->execute();
$result = $stmt->get_result();

$students = [];

while($row = $result->fetch_assoc()) {
    $students[] = $row;
}

echo json_encode($students);


