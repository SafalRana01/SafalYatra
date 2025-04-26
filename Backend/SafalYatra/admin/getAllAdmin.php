<?php
// Including the database connection and authentication helper
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if token is provided in the POST request
if (!isset($_POST['token'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Storing the token from POST request

$adminId = getAdminId($token); // Getting admin ID using the token

// Checking if the token is valid
if (!$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

// Querying admin data from the database
$sql = "SELECT admin_id, admin_name, phone_number, email, image_url, created_at 
        FROM admins 
        ORDER BY created_at DESC";
$result = mysqli_query($connect, $sql);

// Checking if any admin records are found
if ($result->num_rows > 0) {
    $allAdmins = []; // Initializing an empty array to store admin data

    // Looping through each admin record and adding it to the array
    while ($row = mysqli_fetch_assoc($result)) {
        $allAdmins[] = $row;
    }

    // Sending successful response with all admin data
    echo json_encode(array(
        "success" => true,
        "message" => "Admins fetched successfully",
        "AllAdmins" => $allAdmins
    ));
} else {
    // Sending response if no admin records are found
    echo json_encode(array(
        "success" => false,
        "message" => "No admin found for the given operator",
        "AllAdmins" => []


    ));
}
