<?php

include 'connection.php';

function fetchClassesByAcademyId($academyId) {
    $connection = getDbConnection(); // Assuming you have this function from your connection.php

    $sql = "SELECT * FROM classes WHERE academy_id = ?";
    $stmt = $connection->prepare($sql);
    $stmt->bind_param("i", $academyId);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $classes = array();
    while($row = $result->fetch_assoc()) {
        array_push($classes, $row);
    }

    $stmt->close();
    $connection->close();

    return $classes;
}

// Handling the request
$academyId = isset($_GET['academy_id']) ? $_GET['academy_id'] : 0;
$classes = fetchClassesByAcademyId($academyId);

header('Content-Type: application/json');
echo json_encode($classes);