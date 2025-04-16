<?php
// Including the database connection file
include "../config/connection.php";
// Including the helper file for verifying admin token
include "../utils/authHelper.php";

// Checking if token is being sent from the client
if (!isset($_POST['token'])) {
    // Returning error response when token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping the script
}

// Getting the token from the request
$token = $_POST['token'];
// Getting the admin ID by decoding the token
$adminId = getAdminId($token);

// Validating the token by checking if admin ID is valid
if (!$adminId) {
    // Returning error response for invalid token
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping the script
}

// Checking if operator_id is being provided in the request
if (isset($_POST['operator_id'])) {

    // Storing the operator ID from POST data
    $operator_id = $_POST['operator_id'];

    // Updating the operator's status to 'active' in the database
    $sql = "UPDATE car_operators SET status = 'active'  WHERE operator_id = '$operator_id'";
    $result = mysqli_query($connect, $sql);

    // Checking if the update query executed successfully
    if ($result) {
        // Returning success response when update is successful
        echo json_encode(array(
            "success" => true,
            "message" => "Operator deleted successfully"
        ));
    } else {
        // Returning error response when update fails
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to delete operator"
        ));
        die(); // Stopping the script
    }
} else {
    // Returning error response when operator_id is not provided
    echo json_encode(array(
        "success" => false,
        "message" => "Operator id is required"
    ));
    die(); // Stopping the script
}
