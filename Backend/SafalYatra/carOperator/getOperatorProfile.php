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


$sql = "SELECT operator_name, phone_number, email, location, registration_number, image_url, added_date FROM car_operators WHERE operator_id = $operatorId";
$result = mysqli_query($connect, $sql);

if (!$result) {
    echo json_encode(array(
        "success" => false,
        "message" => "Failed to fetch operators data",

    ));

    die();
}
$operator = mysqli_fetch_assoc($result);
echo json_encode(array(
    "success" => true,
    "message" => "Operators data fetched successfully",
    "operators" => $operator

));
