<?php

// simple_image_serve.php
if (isset($_GET['image'])) {
    $imagePath = $_GET['image'];
    
    // Security check: You might want to add more robust validation here
    if (file_exists($imagePath) && is_readable($imagePath)) {
        // Detect the MIME type of the image
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mimeType = finfo_file($finfo, $imagePath);
        finfo_close($finfo);

        header('Content-Type: ' . $mimeType);
        readfile($imagePath);
    } else {
        header("HTTP/1.0 404 Not Found");
        echo "Image not found or not readable: " . htmlspecialchars($imagePath);
    }
}
?>
