<?php
// Database connection (example)

// Create a new academy
function createAcademy($location, $name, $phone, $description, $imageUrl, $ownerId)
{
    $connection = getDbConnection();
    $stmt = $connection->prepare("INSERT INTO academies (location, name, phone, description, image_url, owner_id) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssissi", $location, $name, $phone, $description, $imageUrl, $ownerId);

    if ($stmt->execute()) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $connection->close();
}

// Read academy details
function readAcademy($academyId)
{
    $connection = getDbConnection();
    $stmt = $connection->prepare("SELECT * FROM academies WHERE academy_id = ?");
    $stmt->bind_param("i", $academyId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // output data of each row
        while ($row = $result->fetch_assoc()) {
            // Format and return the data as needed
            echo "id: " . $row["academy_id"] . " - Name: " . $row["name"] . " " . $row["location"] . "<br>";
        }
    } else {
        echo "0 results";
    }

    $stmt->close();
    $connection->close();
}

// Update academy details
function updateAcademy($academyId, $location, $name, $phone, $description, $imageUrl, $ownerId)
{
    $connection = getDbConnection();
    $stmt = $connection->prepare("UPDATE academies SET location = ?, name = ?, phone = ?, description = ?, image_url = ?, owner_id = ? WHERE academy_id = ?");
    $stmt->bind_param("ssissii", $location, $name, $phone, $description, $imageUrl, $ownerId, $academyId);

    if ($stmt->execute()) {
        echo "Record updated successfully";
    } else {
        echo "Error updating record: " . $stmt->error;
    }

    $stmt->close();
    $connection->close();
}

// Delete an academy
function deleteAcademy($academyId)
{
    $connection = getDbConnection();
    $stmt = $connection->prepare("DELETE FROM academies WHERE academy_id = ?");
    $stmt->bind_param("i", $academyId);

    if ($stmt->execute()) {
        echo "Record deleted successfully";
    } else {
        echo "Error deleting record: " . $stmt->error;
    }

    $stmt->close();
    $connection->close();
}