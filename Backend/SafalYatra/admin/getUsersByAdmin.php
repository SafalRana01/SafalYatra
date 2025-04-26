<?php
// Including the database connection file
include "../config/connection.php";
// Including the helper for token authentication
include "../utils/authHelper.php";

// Checking if the token is sent in the POST request
if (!isset($_POST['token'])) {
    // Returning error if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Storing the token from POST request
$adminId = getAdminId($token); // Getting admin ID after verifying the token

// Checking if admin ID is valid (token is valid)
if (!$adminId) {
    // Returning error if token is invalid
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

// Writing SQL query for fetching user details in latest order
$sql = "SELECT  user_id, full_name, phone_number, gender ,email, address, image_url, added_date FROM users ORDER BY added_date DESC";

// Running the query
$result = mysqli_query($connect, $sql);

// Checking if there are any users in the result
if ($result->num_rows > 0) {
    // Creating an array to store all user records
    $allUsers = [];

    // Looping through each row and adding to the array
    while ($row = mysqli_fetch_assoc($result)) {
        $allUsers[] = $row;
    }

    // Sending successful response with user data
    echo json_encode(array(
        "success" => true,
        "message" => "Users fetched successfully",
        "AllUsers" => $allUsers
    ));
} else {
    // Sending response if no users are found
    echo json_encode(array(
        "success" => false,
        "message" => "No users found",
        "AllUsers" => []


    ));
}
