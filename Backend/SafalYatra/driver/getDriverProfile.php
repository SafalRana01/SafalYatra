<?php
// Including database connection and authentication helper
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if the token is provided in the request
if (!isset($_POST['token'])) {
    // Sending a failure response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping script execution
}

$token = $_POST['token']; // Retrieving the token value from POST request

$driverId = getDriverId($token); // Getting driver ID using the token (verifying authenticity)

// Checking if a valid driver ID is returned
if (!$driverId) {
    // Sending a failure response if token is invalid or expired
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping script execution
}


// Preparing a SQL query to fetch driver details 
// and joining car_operators table to get the operator's name
$sql = "SELECT d.driver_name, d.phone_number, d.age, d.gender, d.experience, d.email, d.license_number, d.image_url, d.added_date, o.operator_name
FROM drivers d 
JOIN car_operators o ON d.operator_id = o.operator_id
WHERE d.driver_id = $driverId ";

// Executing the query
$result = mysqli_query($connect, $sql);

// Checking if the query execution was successful
if (!$result) {
    // Sending a failure response if the query failed
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch operators data",

    ));
    die(); // Stopping script execution
}

// Fetching the result as an associative array
$driver = mysqli_fetch_assoc($result);
// Sending a success response along with driver details
echo json_encode(array(
    "success" => true,
    "message" => "Driver data fetched successfully",
    "driver" => $driver

));
