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
$adminId = getAdminId($token);


if (!$operatorId && !$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

if (isset($_POST['package_id'])) {

    $packageId = $_POST['package_id'];



    $sql = "SELECT u.user_id, u.full_name, u.email, u.phone_number, 
        b.booking_id, b.booking_date, b.total
        FROM users u 
        JOIN bookings b on b.user_id = u.user_id
        JOIN tour_packages tp on b.package_id = tp.package_id
        WHERE b.package_id = '$packageId' AND b.status = 'Success'";

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
}
