<?php
// Including database connection and authentication helper files
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

// Preparing SQL query to fetch admin details
$sql = "SELECT admin_name, phone_number, email, image_url, created_at 
        FROM admins 
        WHERE admin_id = $adminId";
$result = mysqli_query($connect, $sql); // Executing SQL query

// Checking if SQL query execution was successful
if (!$result) {
    // Sending error response if data fetch failed
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch admins data",
    ));
    die(); // Stopping script execution
}

// Fetching admin data as associative array
$admin = mysqli_fetch_assoc($result);
// Sending success response with fetched admin data
echo json_encode(array(
    "success" => true,
    "message" => "Admins data fetched successfully",
    "admins" => $admin // Returning fetched admin data
));
