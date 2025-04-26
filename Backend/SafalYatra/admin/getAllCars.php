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
$adminId = getAdminId($token); // Getting admin ID using the token

// If token is invalid, sending error response
if (!$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}


// Query to get list of cars with category and operator information
$query = "SELECT cars.*, categories.category_name, car_operators.operator_id, car_operators.operator_name 
          FROM cars 
          JOIN categories ON cars.category_id = categories.category_id 
          JOIN car_operators ON cars.operator_id = car_operators.operator_id 
          ORDER BY cars.added_date DESC";

$result = $connect->query($query);

// Checking if cars are found
if ($result->num_rows > 0) {
    $AllCars = array(); // Empty array to hold car data
    // Fetching all car details into an array
    while ($row = $result->fetch_assoc()) {
        $AllCars[] = $row;
    }

    // Sending successful response with all cars data
    echo json_encode(array(
        "success" => true,
        "message" => "Cars fetched successfully",
        "AllCars" => $AllCars // Returning fetched car data
    ));
} else {
    // Sending response if no cars are found
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch Cars",

    ));
    die();
}

// Close the database connection
$connect->close();
