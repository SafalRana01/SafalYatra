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

if (isset($_POST['role'])) {

    $role = $_POST['role'];

    $sql = "";

    if ($role == 'user') {

        $sql = "SELECT 
        b.*, 
        c.*, 
        d.driver_id, d.driver_name, d.phone_number, 
        co.operator_id, co.operator_name, co.email AS operator_email,
        tp.package_id, tp.package_name, 
        tp.image_url AS tour_image_url,
        tp.price AS per_person_price,
        tp.start_date AS tour_start_date, tp.end_date AS tour_end_date,
        tp.start_location, tp.destination,
        tp.duration 
    FROM bookings b
    JOIN cars c ON b.car_id = c.car_id
    JOIN drivers d ON b.driver_id = d.driver_id
    JOIN car_operators co ON c.operator_id = co.operator_id
    JOIN tour_packages tp ON b.package_id = tp.package_id 
    WHERE (b.user_id = $userId 
    AND (b.status = 'Success' OR b.status = 'Cancelled') 
    AND b.package_id IS NOT NULL)
    ORDER BY b.booking_date DESC";
    }




    $result = mysqli_query($connect, $sql);







    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Error fetching bookings"
        ));
        die();
    }


    $tourBookings = mysqli_fetch_all($result, MYSQLI_ASSOC);


    echo json_encode(array(
        "success" => true,
        "message" => "Tour bookings fetched successfully",
        "tour_bookings" => $tourBookings
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Role is required"
    ));
    die();
}
