<?php
function getDbConnection() {
    $host = "127.0.0.1"; // Replace with your actual MySQL host
    $user = "root";      // Replace with your actual MySQL username
    $password = "";      // Replace with your actual MySQL password
    $db = "academitydb"; // Replace with your actual MySQL database name

    $connection = new mysqli($host, $user, $password, $db);

    if ($connection->connect_error) {
        die("Connection failed: " . $connection->connect_error);
    }

    return $connection;
}
?>
