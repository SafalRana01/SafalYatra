<?php
// Including database connection
include "../config/connection.php";
// Including helper for verifying token and getting admin ID
include "../utils/authHelper.php";

// Checking if token is sent in the request
if (!isset($_POST['token'])) {
    // Returning error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Getting token value from POST request
$adminId = getAdminId($token); // Getting admin ID by verifying token

// Checking if token is valid
if (!$adminId) {
    // Returning error if token is invalid
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

// Checking if both category_id and is_delete are provided
if (isset($_POST['category_id'], $_POST['is_delete'])) {

    // Getting category ID and delete status from POST request
    $categoryId = $_POST['category_id'];
    $isDelete = $_POST['is_delete'];

    // Updating the isDeleted field of the given category
    $sql = "update categories set isDeleted = $isDelete where category_id = $categoryId";

    // Running the update query
    $result = mysqli_query($connect, $sql);

    // Checking if update was successful
    if ($result) {
        // Sending success response
        echo json_encode(array(
            "success" => true,
            "message" => "Category status updated successfully"
        ));
    } else {
        // Sending failure response if query failed
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to update category status"
        ));
    }
} else {
    // Returning error if required data is missing
    echo json_encode(array(
        "success" => false,
        "message" => "category_id, is_delete are required"
    ));
}
