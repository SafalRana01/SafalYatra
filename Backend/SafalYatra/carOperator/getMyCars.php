<?php
// Including the database connection file
include "../config/connection.php";
// Including helper function to get operator ID from token
include "../utils/authHelper.php";

// Checking if token is being sent in the request
if (!isset($_POST['token'])) {
    // Sending an error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping the script
}

// Storing the token from the POST request
$token = $_POST['token'];

// Getting the operator ID using the token
$operatorId = getOperatorId($token);

// Validating the token by checking if operator ID is found
if (!$operatorId) {
    // Sending an error response for invalid token
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping the script
}


// Creating SQL query to fetch all cars that belong to the operator
// Also joining with categories table to get category name
$query = "SELECT cars.*, categories.category_name 
FROM cars 
JOIN categories ON cars.category_id = categories.category_id WHERE cars.operator_id = '$operatorId' ORDER BY cars.added_date DESC;
";

$result = $connect->query($query); // Running the SQL query

// Check if there are listCars found
if ($result->num_rows > 0) {
    // Creating an array to store car data
    $MyCars = array();
    // Looping through each row and storing it in the array
    while ($row = $result->fetch_assoc()) {
        $MyCars[] = $row;
    }

    // Sending a successful response with the cars data
    echo json_encode(array(
        "success" => true,
        "message" => "Cars fetched successfully",
        "MyCars" => $MyCars
    ));
} else {
    // Sending error response if no cars are found
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch Cars",

    ));
    die(); // Stopping the script
}

// Close the database connection
$connect->close();
