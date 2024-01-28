<?php
include 'connection.php';

$sportId = $_GET['sportId'] ?? '';

if ($sportId) {
    $conn = getDbConnection();
    $sql = "SELECT * FROM academies WHERE sports_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $sportId);
    $stmt->execute();
    $result = $stmt->get_result();

    $academies = array();

    while ($row = $result->fetch_assoc()) {
        $academies[] = $row;
    }

    echo json_encode($academies);
} else {
    echo json_encode([]);
}

$conn->close();
?>
