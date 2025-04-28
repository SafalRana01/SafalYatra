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


if (isset($_POST['booking_id'])) {

    $bookingId = $_POST['booking_id'];

    $sql = "UPDATE bookings SET status = 'Cancelled' WHERE booking_id = $bookingId";
    $result = mysqli_query($connect, $sql);

    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Booking cancelled successfully"
        ));
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Something went wrong"
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Booking id is required"
    ));
}
