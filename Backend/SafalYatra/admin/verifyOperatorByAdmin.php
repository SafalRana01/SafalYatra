<?php
// Including database connection file and authentication helper functions
include "../config/connection.php";
include "../utils/authHelper.php";


// Checking if token is provided or not
if (!isset($_POST['token'])) {
    // Sending error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Getting token from POST request
$adminId = getAdminId($token); // Getting admin ID using token

// Checking if admin ID is valid
if (!$adminId) {
    // Sending error response if token is invalid 
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

// Checking if operator ID is provided
if (isset($_POST['operator_id'])) {

    // Getting operator ID from POST request
    $operator_id = $_POST['operator_id'];

    // Updating car operator status to 'Verified' and setting admin ID
    $sql = "UPDATE car_operators SET status = 'Verified', admin_id = '$adminId'  WHERE operator_id = '$operator_id'";
    $result = mysqli_query($connect, $sql);

    // Checking if update query was successful
    if ($result) {
        // Sending success response if operator is verified
        echo json_encode(array(
            "success" => true,
            "message" => "Operator verified successfully"
        ));
    } else {
        // Sending error response if failed to verify operator
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to verify operator"
        ));
        die();
    }
} else {
    // Sending error response if operator ID is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Operator id is required"
    ));
    die();
}
