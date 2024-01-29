<?php
include 'connection.php';

$academyId = $_GET['academyId'] ?? '';

if ($academyId) {
    $conn = getDbConnection();
    $sql = "SELECT * FROM academies WHERE academy_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $academyId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        echo json_encode($row);
    } else {
        echo json_encode(["error" => "Academy not found"]);
    }
} else {
    echo json_encode(["error" => "Academy ID not provided"]);
}

$conn->close();
?>
