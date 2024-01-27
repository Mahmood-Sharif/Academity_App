<?php
include 'connection.php';

function fetchAcademiesByOwnerId($ownerId) {
    $connection = getDbConnection(); // Use your database connection function

    $sql = "SELECT * FROM academies WHERE owner_id = ?";
    $stmt = $connection->prepare($sql);
    $stmt->bind_param("i", $ownerId);

    $stmt->execute();
    $result = $stmt->get_result();
    $academies = array();

    while($row = $result->fetch_assoc()) {
        array_push($academies, $row);
    }

    $stmt->close();
    $connection->close();

    return $academies;
}

// Fetching ownerId from the request
$ownerId = isset($_GET['ownerId']) ? $_GET['ownerId'] : 0;
$academies = fetchAcademiesByOwnerId($ownerId);

// Returning the result as JSON
header('Content-Type: application/json');
echo json_encode($academies);

