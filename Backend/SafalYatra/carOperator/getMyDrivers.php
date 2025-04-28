<?php
include "../config/connection.php";
include "../utils/authHelper.php";


if (!isset($_POST['token'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Storing the token from POST request


$operatorId = getOperatorId($token);

if (!$operatorId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}


// Query to get the list of listDrivers
$query = "SELECT driver_id, operator_id, driver_name, phone_number, license_number, image_url, email, gender, age, experience, added_date, status FROM drivers 
 WHERE drivers.operator_id = '$operatorId';
";

$result = $connect->query($query);

// Check if there are listDrivers found
if ($result->num_rows > 0) {
    // Fetch the result as an associative array
    $MyDrivers = array();
    while ($row = $result->fetch_assoc()) {
        $MyDrivers[] = $row;
    }

    // Send the JSON response
    echo json_encode(array(
        "success" => true,
        "message" => "Drivers fetched successfully",
        "MyDrivers" => $MyDrivers
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch Drivers",

    ));
    die();
}

// Close the database connection
$connect->close();
