<?php
include "../config/connection.php"; // Including the database connection file
include "../utils/authHelper.php"; // Including helper file for token authentication

// Checking if token is being sent in the request
if (!isset($_POST['token'])) {
    // Sending an error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping further execution
}

$token = $_POST['token']; // Storing the token from the request

// Getting the user ID and operator ID using the token
$userId = getUserId($token);
$operatorId = getOperatorId($token);

// Checking if both user and operator are invalid
if (!$userId && !$operatorId) {
    // Sending an error response for invalid token
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping further execution
}


// Writing SQL query to get cars added by this operator and their category names
$query = "SELECT cars.*, categories.category_name 
FROM cars 
JOIN categories ON cars.category_id = categories.category_id WHERE cars.operator_id = '$operatorId';
";

$result = $connect->query($query); // Running the query

// Check if there are listCars found
if ($result->num_rows > 0) {
    // Creating an array to store fetched cars
    $listCars = array();
    // Looping through the result to fetch each car
    while ($row = $result->fetch_assoc()) {
        $listCars[] = $row; // Adding each car to the array
    }

    // Sending a success response with the list of cars
    echo json_encode(array(
        "success" => true,
        "message" => "ListCars fetched successfully",
        "listCars" => $listCars
    ));
} else {
    // Sending an error response if no cars are found
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch listCars",
    ));
    die(); // Stopping further execution
}

$connect->close(); // Closing the database connection
