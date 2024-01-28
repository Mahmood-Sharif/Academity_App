<?php
include 'connection.php';

function fetchSports() {
    header('Content-Type: application/json');
    header('Access-Control-Allow-Origin: *'); // Allow requests from all origins

    $conn = getDbConnection(); // Assuming this function is defined in 'connection.php'
    $sql = "SELECT sports_id, sport_name, image_url FROM sports";
    $result = $conn->query($sql);

    $sports = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $sports[] = $row;
        }
        echo json_encode($sports);
    } else {
        echo json_encode([]);
    }

    $conn->close();
}

fetchSports(); // Call the function to execute
?>
