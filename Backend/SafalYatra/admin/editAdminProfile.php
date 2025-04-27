<?php
// Including database connection and authentication helper
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if token is set in POST request
if (!isset($_POST['token'])) {
    // Sending error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping script execution
}

$token = $_POST['token']; // Storing the token from POST request

$adminId = getAdminId($token); // Getting admin ID by verifying token

// Checking if admin ID is valid
if (!$adminId) {
    // Sending error response if token is invalid
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping script execution
}

// Checking if full_name and contact are set
if (isset($_POST['full_name'], $_POST['contact'])) {

    // Storing full name and contact from POST data
    $full_name = $_POST['full_name'];
    $contact = $_POST['contact'];
    $imageUrl = null; // Initializing image URL as null

    // Checking if an image is uploaded
    if (isset($_FILES['image'])) {

        $image = $_FILES['image']; // Storing uploaded image details

        $image_size = $image['size']; // Storing image size

        // Validating if image size is less than 5 MB
        if ($image_size > 5 * 1024 * 1024) {
            // Sending error if image is too large
            echo json_encode(array(
                "success" => false,
                "message" => "Image size should be less than 5 MB"
            ));
            die(); // Stopping script execution
        }

        // Getting file extension of the uploaded image
        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        $allowed = ["jpg", "jpeg", "png", "webp"]; // Defining allowed file types

        // Checking if file extension is allowed
        if (!in_array($ext, $allowed)) {
            // Sending error if file type is invalid
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid image format"
            ));
            die(); // Stopping script execution
        }


        $role = 'admin'; // Defining role as admin
        $id = $adminId; // Defining role as admin

        // Getting file extension of the uploaded image
        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        // Creating a new unique file name
        $new_name = $role . "_" . $id . "_" . time() . "." . $ext;

        $temp_location = $image['tmp_name']; // Storing temporary file location
        $new_location = "../images/" . $new_name; // New location for saving the image
        $image_url = "images/" . $new_name; // URL to access the image in flutter

        // Moving uploaded file to new location
        if (!move_uploaded_file($temp_location, $new_location)) {
            // Sending error if file move fails
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to upload image"
            ));
            die(); // Stopping script execution 
        }

        $imageUrl = $image_url; // Updating image URL if upload is successful
    }

    $sql = ''; // Initializing SQL query

    // Preparing SQL query based on whether image was uploaded
    if ($imageUrl == null) {
        // Preparing SQL to update name and contact only
        $sql = "UPDATE admins SET admin_name = '$full_name', phone_number = '$contact' 
                WHERE admin_id = $adminId";
    } else {
        // Preparing SQL to update name and contact only
        $sql = "UPDATE admins SET admin_name = '$full_name', image_url='$imageUrl', phone_number = '$contact' 
                WHERE admin_id = $adminId";
    }

    $result = mysqli_query($connect, $sql); // Executing the update query

    // Checking if update was successful
    if ($result) {
        // Sending success response if profile updated
        echo json_encode(array(
            "success" => true,
            "message" => "Profile updated successfully"
        ));
        die(); // Stopping script execution
    } else {
        // Sending error response if update failed
        echo json_encode(array(
            "success" => false,
            "message" => "Profile updated failed"
        ));
        die(); // Stopping script execution
    }
} else {
    // Sending error response if update failed
    echo json_encode(array(
        "success" => false,
        "message" => "full_name and contact are required",
    ));
    die(); // Stopping script execution
}
