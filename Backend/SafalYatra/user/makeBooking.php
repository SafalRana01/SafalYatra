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
    $_POST['driver_id'],
    $_POST['location'],
    $_POST['start_date'],
    $_POST['end_date'],

)) {
    $carId = $_POST['car_id'];
    $driverId = $_POST['driver_id'];
    $location = $_POST['location'];
    $startDate = $_POST['start_date'];
    $endDate = $_POST['end_date'];

    global $connect;

    // Check if the schedule exists
    $sql = "SELECT * FROM cars WHERE car_id = '$carId'";
    $result = mysqli_query($connect, $sql);

    if (!$result || mysqli_num_rows($result) == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Schedule not found"
        ));
        die();
    }

    $car = mysqli_fetch_assoc($result);

    $price_per_day = $car['rate_per_hours'];
    $number_of_days = ceil((strtotime($endDate) - strtotime($startDate)) / (60 * 60 * 24)) + 1;
    $total = $price_per_day * $number_of_days;

    // Insert booking
    $sql = "INSERT INTO bookings (car_id, user_id, driver_id, start_date, end_date, location, total) VALUES ('$carId', '$userId',  '$driverId', '$startDate', '$endDate', '$location', '$total')";
    $result = mysqli_query($connect, $sql);

    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to make booking"
        ));
        die();
    }

    $booking_id = mysqli_insert_id($connect);
    // Echo success message after all booked seats are inserted
    echo json_encode(array(
        "success" => true,
        "message" => "Booking made successfully",
        "booking_id" => $booking_id,
        "total" => $total * 100
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "All fields are required"
    ));
}
