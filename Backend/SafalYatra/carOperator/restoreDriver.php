<?php
include "../config/connection.php"; // Including the database connection file
include "../utils/authHelper.php"; // Including helper file for token authentication

// Checking if token is sent in the request
if (!isset($_POST['token'])) {
    // Sending an error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping the script
}

$token = $_POST['token']; // Storing the token from the request
$operatorId = getOperatorId($token); // Getting the operator ID by decoding the token

// Checking if the operator ID is valid
if (!$operatorId) {
    // Sending an error response if token is invalid
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping the script
}

// Checking if driver ID is sent in the request
if (isset($_POST['driverId'])) {

    $driverId = $_POST['driverId']; // Storing the driver ID
    // Updating the driver's status to 'Available' in the database
    $sql = "UPDATE drivers SET status = 'Available' WHERE driver_id = $driverId";
    $result = mysqli_query($connect, $sql);

    // Checking if the query was successful
    if ($result) {
        // Sending a success response if update worked
        echo json_encode(array(
            "success" => true,
            "message" => "Driver restored successfully"
        ));
    } else {
        // Sending an error response if update failed
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to restore driver"
        ));
        die(); // Stopping the script
    }
} else {
    // Sending an error response if driver ID is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Driver Id is required"
    ));
    die(); // Stopping further execution
}
