<?php
// Including the database connection file
include "../config/connection.php";
// Including the helper to validate the token and get admin ID
include "../utils/authHelper.php";

// Checking if the token is sent from the client
if (!isset($_POST['token'])) {
    // Sending an error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping the script
}

$token = $_POST['token']; // Getting the token value from the request

$adminId = getAdminId($token); // Getting the admin ID from the token

// Checking if the token is invalid or expired
if (!$adminId) {
    // Sending an error response for invalid token
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping the script
}


// Checking if the category field is provided in the request
if (isset(
    $_POST['category'],
)) {

    // Getting the category name from the request
    $category = $_POST['category'];

    // Preparing a query to check if the category already exists
    $sql = "select * from categories where category_name ='$category'";

    // Executing the select query
    $result = mysqli_query($connect, $sql);

    // Checking if the category already exists
    if (mysqli_num_rows($result) > 0) {
        // Sending a response saying the category already exists
        echo json_encode(array(
            "success" => false,
            "message" => "Category already exists"
        ));
        die(); // Stopping the script
    }

    // Preparing an insert query to add a new category
    $sql = "insert into categories(category_name) values('$category')";

    // Executing the insert query
    $result = mysqli_query($connect, $sql);

    // Checking if the insertion failed
    if (!$result) {
        // Sending an error response for insertion failure
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to add category"
        ));
        die(); // Stopping the script
    }

    // Sending a success response when category is added
    echo json_encode(array(
        "success" => true,
        "message" => "Category added successfully"
    ));
} else {
    // Sending an error response if category field is missing
    echo json_encode(array(
        "success" => false,
        "message" => "title is required"
    ));
    die(); // Stopping the script
}
