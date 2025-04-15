<?php
// Including necessary files for database connection and authentication
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if the 'token' is present in the POST request
if (!isset($_POST['token'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required" // If token is missing, return an error message
    ));
    die(); // Terminating the script after returning the error
}


$token = $_POST['token']; // Retrieving the token from the POST request
$driverId = getDriverId($token); // Fetching the driver ID using the provided token

// If no valid driver ID is found, return an error message
if (!$driverId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token" // If the token is invalid, return an error message
    ));
    die();
}

// Checking if the required fields ('driver_name', 'contact', 'licenseNumber') are set in the POST request
if (isset($_POST['driver_name'], $_POST['contact'], $_POST['licenseNumber'])) {

    // Retrieving the values for 'driver_name', 'contact', and 'licenseNumber' from the POST request
    $driver_name = $_POST['driver_name'];
    $contact = $_POST['contact'];
    $licenseNumber = $_POST['licenseNumber'];
    $imageUrl = null; // Initialize imageUrl as null

    // Checking if an image file is uploaded
    if (isset($_FILES['image'])) {

        $image = $_FILES['image']; // Retrieving the uploaded image
        $image_size = $image['size']; // Getting the size of the uploaded image

        // Checking if the image size exceeds 5 MB
        if ($image_size > 5 * 1024 * 1024) {
            echo json_encode(array(
                "success" => false,
                "message" => "Image size should be less than 5 MB" // Return an error message if the image size is too large
            ));
            die(); // Terminate the script
        }

        // Extracting the file extension of the uploaded image
        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        // Defining allowed image formats
        $allowed = ["jpg", "jpeg", "png", "webp"];

        // Checking if the uploaded image format is allowed
        if (!in_array($ext, $allowed)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid image format" // Return an error if the image format is not allowed
            ));
            die(); // Terminate the script
        }

        // // Generating a unique name for the image and defining the upload path
        // $new_name = uniqid() . "." . $ext;
        // $temp_location = $image['tmp_name']; // Temporary location of the uploaded image
        // $new_location = "../images/" . $new_name; // New location for saving the image
        // $image_url = "images/" . $new_name; // URL to access the image


        // Assuming you already have role and id from token
        $role = 'driver'; // Since this is a driver profile update
        $id = $driverId;

        // Get file extension
        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        // Create unique file name: role_id_timestamp.ext
        $new_name = $role . "_" . $id . "_" . time() . "." . $ext;

        // Temporary and final locations
        $temp_location = $image['tmp_name']; // Temporary location of the uploaded image
        $new_location = "../images/" . $new_name; // New location for saving the image
        $image_url = "images/" . $new_name; // URL to access the image in flutter


        // Moving the uploaded image from the temporary location to the new location
        if (!move_uploaded_file($temp_location, $new_location)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to upload image" // Return an error if the image upload fails
            ));
            die(); // Terminate the script
        }

        $imageUrl = $image_url; // Setting the image URL if the upload is successful
    }

    // If an image was not uploaded, updating the driver's profile without an image
    $sql = '';
    if ($imageUrl == null) {
        $sql = "UPDATE drivers SET driver_name = '$driver_name', phone_number = '$contact', license_number = '$licenseNumber' WHERE driver_id = $driverId";
    } else {
        // If an image was uploaded, include the image URL in the update query
        $sql = "UPDATE drivers SET driver_name = '$driver_name', image_url='$imageUrl', phone_number = '$contact', license_number = '$licenseNumber' WHERE driver_id = $driverId";
    }

    // Executing the SQL query to update the driver's profile
    $result = mysqli_query($connect, $sql);

    // Checking if the query was successful
    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Profile updated successfully" // Return success message if profile update is successful
        ));
        die(); // Terminate the script
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Profile updated failed" // Return error message if profile update fails
        ));
        die(); // Terminate the script
    }
} else {
    // If required fields ('driver_name', 'contact', and 'license_number') are not provided in the POST request
    echo json_encode(array(
        "success" => false,
        "message" => "driver_name,contact and license_number are required", // Return error message
    ));
    die(); // Terminate the script
}
