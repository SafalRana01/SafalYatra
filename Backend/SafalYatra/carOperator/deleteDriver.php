<?php
// Including database connection file
include "../config/connection.php";
// Including the helper file for verifying operator token
include "../utils/authHelper.php";

// Checking if token is being sent in the request
if (!isset($_POST['token'])) {
    // Returning error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping the script
}

// Storing the token received from request
$token = $_POST['token'];
// Getting the operator ID from token
$operatorId = getOperatorId($token);

// Validating the token by checking if the operator exists
if (!$operatorId) {
    // Returning error response if token is invalid
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping the script
}

// Checking if driver ID is being provided
if (isset($_POST['driverId'])) {
    // Storing the driver ID from request
    $driverId = $_POST['driverId'];

    // Updating the driver's status to 'Unavailable' in the database
    $sql = "UPDATE drivers SET status = 'Unavailable' WHERE driver_id = $driverId";
    $result = mysqli_query($connect, $sql);

    // Checking if the update query executed successfully
    if ($result) {
        // Returning success response
        echo json_encode(array(
            "success" => true,
            "message" => "Driver deleted successfully"
        ));
    } else {
        // Returning error response if update fails
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to delete driver"
        ));
        die(); // Stopping the script
    }
} else {
    // Returning error response if driver ID is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Driver Id is required"
    ));
    die(); // Stopping the script
}
