<?php
// Including database connection and authentication helper
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if token is provided in the POST request
if (!isset($_POST['token'])) {
    // Sending error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Storing the token from POST request
$adminId = getAdminId($token); // Getting admin ID from the token

// If token is invalid and admin ID is not found, sending error response
if (!$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

// Querying to get driver details along with their operator name, ordered by the latest added drivers
$sql = "SELECT d.driver_id, d.driver_name, d.phone_number, d.email, d.gender, d.age, d.experience, d.license_number, d.image_url, d.added_date, o.operator_name 
        FROM car_operators o 
        JOIN drivers d ON o.operator_id = d.operator_id
        ORDER BY d.added_date DESC";

$result = mysqli_query($connect, $sql); // Running the query

// Checking if any drivers were found
if ($result->num_rows > 0) {
    $allDrivers = []; // Creating an array to store all driver records

    // Looping through each driver and adding to the array
    while ($row = mysqli_fetch_assoc($result)) {
        $allDrivers[] = $row;
    }

    // Sending successful response with all driver data
    echo json_encode(array(
        "success" => true,
        "message" => "Drivers fetched successfully",
        "AllDrivers" => $allDrivers // Returning fetched driver data
    ));
} else {
    // Sending response if no drivers were found
    echo json_encode(array(
        "success" => false,
        "message" => "No drivers found for the given operator",
        "AllDrivers" => [] // Returning empty array if no drivers


    ));
}
