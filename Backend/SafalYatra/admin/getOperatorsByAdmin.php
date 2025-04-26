<?php
// Including database connection and authentication helper files
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if token is provided in the request
if (!isset($_POST['token'])) {
    // Sending error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Storing the token from POST request
$adminId = getAdminId($token); // Getting admin ID from the token using helper function

// If admin ID is not found (invalid token), send error response
if (!$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

// Querying database to get all car operators whose status is either 'active' or 'Verified'
$sql = "SELECT operator_id, operator_name, phone_number, email, registration_number, location, image_url, status, added_date 
        FROM car_operators 
        WHERE status = 'active' OR status = 'Verified' 
        ORDER BY added_date DESC";
$result = mysqli_query($connect, $sql); // Running the query

// Checking if any operators were found
if ($result->num_rows > 0) {
    $allOperators = []; // Creating an array to store all operator records

    // Looping through each row and adding to array
    while ($row = mysqli_fetch_assoc($result)) {
        $allOperators[] = $row;
    }

    // Sending success response with all operator data
    echo json_encode(array(
        "success" => true,
        "message" => "Operators fetched successfully",
        "AllOperators" => $allOperators // Returning all fetched operator data
    ));
} else {
    // Sending success response with all operator data
    echo json_encode(array(
        "success" => false,
        "message" => "No operator found",
        "AllOperators" => [] // Returning an empty array if no data
    ));
}
