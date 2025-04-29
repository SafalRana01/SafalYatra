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

$userId = getUserId($token);
$operatorId = getOperatorId($token);

if (!$userId && !$operatorId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}


// Query to get the list of cities
$query = "SELECT DISTINCT location FROM car_operators";

$result = $connect->query($query);

// Check if there are cities found
if ($result->num_rows > 0) {
    // Fetch the result as an associative array
    $cities = array();
    while ($row = $result->fetch_assoc()) {
        $cities[] = $row["location"];
    }

    // Send the JSON response
    echo json_encode(array(
        "success" => true,
        "message" => "Cities fetched successfully",
        "cities" => $cities
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch cities",

    ));
    die();
}

// Close the database connection
$connect->close();
