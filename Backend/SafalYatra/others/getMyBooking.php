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
$driverId = getDriverId($token);
$adminId = getAdminId($token);

if (!$userId && !$operatorId && !$driverId && !$adminId) {
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
    d.driver_id, d.driver_name, d.phone_number, d.image_url AS driver_image_url, 
    d.gender, d.age, d.experience, d.email,
    co.operator_id, co.operator_name, co.email AS operator_email
    FROM bookings b
    JOIN cars c ON b.car_id = c.car_id
    JOIN drivers d ON b.driver_id = d.driver_id
    JOIN car_operators co ON c.operator_id = co.operator_id
    where b.user_id = $userId AND (b.status = 'Success' OR b.status = 'Cancelled')
    AND b.package_id IS NULL
    order by b.booking_date desc";
    } elseif ($role == 'operator') {

        $sql = "SELECT 
            b.*,
            c.*,
            u.user_id, u.full_name AS user_name, u.email AS user_email, u.phone_number AS user_phone_number, u.image_url AS user_image_url,
            d.driver_id, d.driver_name AS driver_name, d.phone_number AS driver_phone_number, d.email AS driver_email, d.image_url AS driver_image_url
            FROM bookings b
            JOIN cars c ON b.car_id = c.car_id
            JOIN drivers d ON b.driver_id = d.driver_id
            JOIN users u ON b.user_id = u.user_id
            where c.operator_id = $operatorId AND (b.status = 'Success' OR b.status = 'Cancelled')
             AND b.package_id IS NULL
            order by b.booking_date desc";
    } elseif ($role == 'driver') {

        $sql = "SELECT 
        b.*,
        c.*,
        u.user_id, u.full_name AS user_name, u.email AS user_email, u.phone_number AS user_phone_number, u.image_url AS user_image_url
        FROM bookings b
        JOIN cars c ON b.car_id = c.car_id
        JOIN drivers d ON b.driver_id = d.driver_id
        JOIN users u ON b.user_id = u.user_id
        where b.driver_id = $driverId AND b.status = 'Success' 
        order by b.booking_date desc";
    } elseif ($role == 'admin') {

        $sql = "SELECT 
            b.*,
            c.*,
            co.operator_id, co.operator_name AS operator_name, co.email AS operator_email,
            u.user_id, u.full_name AS user_name, u.email AS user_email, u.phone_number AS user_phone_number, u.image_url AS user_image_url,
            d.driver_id, d.driver_name AS driver_name, d.phone_number AS driver_phone_number, d.email AS driver_email, d.image_url AS driver_image_url
            FROM bookings b
            JOIN cars c ON b.car_id = c.car_id
            JOIN drivers d ON b.driver_id = d.driver_id
            JOIN car_operators co ON c.operator_id = co.operator_id
            JOIN users u ON b.user_id = u.user_id
            where ((b.status = 'Success' OR b.status = 'Cancelled')
            AND b.package_id IS NULL)
            order by b.booking_date desc";
    }



    $result = mysqli_query($connect, $sql);

    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Error fetching bookings"
        ));
        die();
    }


    $bookings = mysqli_fetch_all($result, MYSQLI_ASSOC);


    echo json_encode(array(
        "success" => true,
        "message" => "Bookings fetched successfully",
        "bookings" => $bookings
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Role is required"
    ));
    die();
}
