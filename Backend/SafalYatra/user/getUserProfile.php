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

if (!$userId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}


$sql = "SELECT full_name, phone_number, email, address, gender, image_url, added_date FROM users WHERE user_id = $userId";
$result = mysqli_query($connect, $sql);

if (!$result) {
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch users data",

    ));

    die();
}
$user = mysqli_fetch_assoc($result);
echo json_encode(array(
    "success" => true,
    "message" => "Users data fetched successfully",
    "users" => $user

));
