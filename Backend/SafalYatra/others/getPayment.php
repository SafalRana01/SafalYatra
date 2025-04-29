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

if (isset($_POST['role'])) {
    $role = $_POST['role'];

    $sql = "";

    if ($role == "user") {
        $sql = "SELECT 
        cars.car_id, cars.name, cars.license_plate, cars.rate_per_hours,
        car_operators.operator_id, car_operators.operator_name, 
        users.user_id, users.full_name AS user_name, users.email AS user_email, users.phone_number AS user_phone_number,
        bookings.*, 
        payments.*
        FROM payments
        INNER JOIN bookings ON bookings.booking_id = payments.booking_id
        LEFT JOIN cars ON bookings.car_id = cars.car_id
        LEFT JOIN car_operators ON cars.operator_id = car_operators.operator_id
        LEFT JOIN users ON bookings.user_id = users.user_id
        WHERE payments.user_id = '$userId'
        ORDER BY payments.payment_date DESC";



        $result = mysqli_query($connect, $sql);

        if ($result) {
            $payments = mysqli_fetch_all($result, MYSQLI_ASSOC);


            echo json_encode(array(
                "success" => true,
                "message" => "Payments fetched successfully",
                "payments" => $payments
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to fetch payments"
            ));
        }
    } else if ($role == "operator") {
        $sql = "SELECT 
        cars.car_id, cars.name, cars.license_plate, cars.rate_per_hours,
        car_operators.operator_id, car_operators.operator_name, 
        users.user_id, users.full_name AS user_name, users.email AS user_email, users.phone_number AS user_phone_number,
        bookings.*, 
        payments.*
        FROM payments
        INNER JOIN bookings ON bookings.booking_id = payments.booking_id
        LEFT JOIN cars ON bookings.car_id = cars.car_id
        LEFT JOIN car_operators ON cars.operator_id = car_operators.operator_id
        LEFT JOIN users ON bookings.user_id = users.user_id
        WHERE cars.operator_id = '$operatorId'
        ORDER BY payments.payment_date DESC";



        $result = mysqli_query($connect, $sql);

        if ($result) {
            $payments = mysqli_fetch_all($result, MYSQLI_ASSOC);


            echo json_encode(array(
                "success" => true,
                "message" => "Payments fetched successfully",
                "payments" => $payments
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to fetch payments"
            ));
        }
    } else if ($role == "admin") {
        $sql = "SELECT 
        cars.car_id, cars.name, cars.license_plate, cars.rate_per_hours,
        car_operators.operator_id, car_operators.operator_name, 
        users.user_id, users.full_name AS user_name, users.email AS user_email, users.phone_number AS user_phone_number,
        bookings.*, 
        payments.*
        FROM payments
        INNER JOIN bookings ON bookings.booking_id = payments.booking_id
        LEFT JOIN cars ON bookings.car_id = cars.car_id
        LEFT JOIN car_operators ON cars.operator_id = car_operators.operator_id
        LEFT JOIN users ON bookings.user_id = users.user_id
        ORDER BY payments.payment_date DESC";



        $result = mysqli_query($connect, $sql);

        if ($result) {
            $payments = mysqli_fetch_all($result, MYSQLI_ASSOC);


            echo json_encode(array(
                "success" => true,
                "message" => "Payments fetched successfully",
                "payments" => $payments
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to fetch payments"
            ));
        }
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Role is required"
    ));
    die();
}
