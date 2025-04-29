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
$adminId = getAdminId($token);

if (!$userId && !$operatorId && !$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

if (!isset($_POST['role'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Role is required"
    ));
    die();
}

$role = $_POST['role'];

$sql = "";


if ($role == 'admin' || $role == 'user') {
    $sql = "select * from categories";
} else if ($role == 'operator') {
    $sql = "select * from categories where isDeleted = 0";
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid role"
    ));
    die();
}



$result = mysqli_query($connect, $sql);


$categories = [];

while ($row = mysqli_fetch_assoc($result)) {
    $categories[] = $row;
}

echo json_encode(array(
    "success" => true,
    "message" => "Categories fetched successfully",
    "categories" => $categories
));
