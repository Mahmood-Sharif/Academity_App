<?php
include 'connection.php';

function loginUsers($connection, $email, $password) {

    $userId = null;
    $storedPassword = null;

    
    $stmt = $connection->prepare("SELECT user_id, password FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->bind_result($userId, $storedPassword);

    if ($stmt->fetch() && $password === $storedPassword) {
        return ['status' => 'Login successful', 'user_id' => $userId];
    } else {
        return ['status' => 'Login failed', 'message' => 'Invalid credentials'];
    }

    $stmt->close();
}

$connection = getDbConnection();
$email = isset($_POST['email']) ? $_POST['email'] : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';

$result = loginUsers($connection, $email, $password);
$connection->close();

header('Content-Type: application/json');
$jsonOutput = json_encode($result);

error_log("Login attempt: " . $jsonOutput); // Log the output

echo $jsonOutput;

// Usage example (uncomment to test)
// loginOwner("email@example.com", "testPassword");
