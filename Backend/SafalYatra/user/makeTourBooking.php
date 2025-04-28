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
    $_POST['package_id'],
    $_POST['start_date'],
    $_POST['end_date'],
    $_POST['number_of_people']

)) {
    $carId = $_POST['car_id'];
    $driverId = $_POST['driver_id'];
    $packageId = $_POST['package_id'];
    $startDate = $_POST['start_date'];
    $endDate = $_POST['end_date'];
    $numberOfPeople = $_POST['number_of_people'];


    global $connect;

    // Check if the schedule exists
    $sql = "SELECT * FROM tour_packages WHERE package_id = '$packageId'";
    $result = mysqli_query($connect, $sql);

    if (!$result || mysqli_num_rows($result) == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Tour package not found"
        ));
        die();
    }

    $tour = mysqli_fetch_assoc($result);

    $tourCapacity = $tour['tour_capacity'];

    $availableCapacity = $tour['available_capacity'];

    if ($numberOfPeople > $tourCapacity) {
        echo json_encode(array(
            "success" => false,
            "message" => "Tour capacity exceeded"
        ));
        die();
    }

    if ($numberOfPeople > $availableCapacity) {
        echo json_encode(array(
            "success" => false,
            "message" => "Tour capacity not available"
        ));
        die();
    }



    $price_per_person = $tour['price'];

    $total = $price_per_person * $numberOfPeople;

    // Insert booking
    $sql = "INSERT INTO bookings (car_id, user_id, package_id, driver_id, start_date, end_date, total) VALUES ('$carId', '$userId', '$packageId', '$driverId', '$startDate', '$endDate', '$total')";
    $result = mysqli_query($connect, $sql);

    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to make tour booking"
        ));
        die();
    }

    $booking_id = mysqli_insert_id($connect);
    // Echo success message after all booked seats are inserted
    echo json_encode(array(
        "success" => true,
        "message" => "Tour booking made successfully",
        "booking_id" => $booking_id,
        "total" => $total * 100
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "All fields are required"
    ));
}
