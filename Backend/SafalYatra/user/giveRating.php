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

if (isset(
    $_POST['car_id'],
    $_POST['rating']
)) {

    $car_id = $_POST['car_id'];
    $rating = $_POST['rating'];


    $sql = "SELECT * FROM ratings WHERE car_id = $car_id AND user_id = $userId";

    $result = mysqli_query($connect, $sql);


    $rating_id = null;

    if (mysqli_num_rows($result) > 0) {
        $ratingData = mysqli_fetch_assoc($result);
        $rating_id = $ratingData['rating_id'];
    }

    $sql = '';

    if ($rating_id != null) {
        $sql = "UPDATE ratings SET rating = $rating WHERE rating_id = $rating_id";
    } else {
        $sql = "INSERT INTO ratings (user_id, car_id, rating) VALUES ($userId, $car_id, $rating)";
    }

    $result = mysqli_query($connect, $sql);


    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Rating added successfully"
        ));


        $sql = "UPDATE cars SET rating = (SELECT AVG(rating) FROM ratings WHERE car_id = $car_id) WHERE car_id = $car_id";
        $result = mysqli_query($connect, $sql);
        die();
    }

    echo json_encode(array(
        "success" => false,
        "message" => "Failed to add rating"
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "car_id and rating are required"
    ));
    die();
}
