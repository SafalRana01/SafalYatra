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


$totalCars;
$totalDrivers;
$totalTourPackages;
$totalBookings;
$totalRevenue;
$totalMonthlyRevenue;


$sql = "SELECT count(*) AS total_cars FROM cars WHERE operator_id = $operatorId";

$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalCars = $row['total_cars'];
}


$sql = "SELECT count(*) AS total_drivers FROM drivers WHERE operator_id = $operatorId";

$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalDrivers = $row['total_drivers'];
}

$sql = "SELECT count(*) AS total_tour_packages FROM tour_packages WHERE operator_id = $operatorId";

$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalTourPackages = $row['total_tour_packages'];
}


$sql = "SELECT COUNT(*) AS total_bookings FROM bookings 
JOIN cars ON bookings.car_id = cars.car_id WHERE cars.operator_id = $operatorId AND (bookings.status = 'Success' OR bookings.status = 'Cancelled')";

$result = mysqli_query($connect, $sql);
if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalBookings = $row['total_bookings'];
}

$sql = "SELECT ROUND(SUM(p.payment_amount/100), 2) AS total_revenue
FROM payments p
JOIN bookings b ON p.booking_id = b.booking_id
JOIN cars c ON b.car_id = c.car_id
WHERE c.operator_id = $operatorId";

$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalRevenue = $row['total_revenue'];
}

$month = date("m");
$year = date("Y");

if (isset($_POST['month'], $_POST['year'])) {
    $month = $_POST['month'];
    $year = $_POST['year'];
}

$sql = "SELECT ROUND(SUM(p.payment_amount/100), 2) AS total_income
        FROM payments p
        JOIN bookings b ON p.booking_id = b.booking_id
        JOIN cars c ON b.car_id = c.car_id
        WHERE MONTH(p.payment_date) = $month
        AND YEAR(p.payment_date) = $year
        AND c.operator_id = $operatorId";

$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalMonthlyRevenue = $row['total_income'];
}


$sql = "SELECT cars.car_id, cars.license_plate, cars.name, SUM(payment_amount) AS total_income
        FROM payments 
        JOIN bookings ON payments.booking_id = bookings.booking_id
        JOIN cars ON bookings.car_id = cars.car_id
        WHERE cars.operator_id = $operatorId
        GROUP BY cars.car_id
        ORDER BY total_income DESC
        LIMIT 3";

$result = mysqli_query($connect, $sql);

if (!$result) {
    echo json_encode(array(
        "success" => false,
        "message" => "Error fetching top 5 buses",
        "error" => mysqli_error($connect)
    ));
    die();
}

$top_cars = mysqli_fetch_all($result, MYSQLI_ASSOC);

$remainingAmount = $totalRevenue * 100;
$remainingPercent = 100;

foreach ($top_cars as $key => $car) {
    $top_cars[$key]['percentage'] = round(($car['total_income'] / ($totalRevenue * 100)) * 100, 2);
    $remainingPercent -= $top_cars[$key]['percentage'];
    $remainingAmount -= $top_cars[$key]['total_income'];
}

$top_cars[] = array(
    "car_id" => 0,
    "license_plate" => "Others",
    "total_income" => $remainingAmount,
    "percentage" => abs(round($remainingPercent))
);



// $sqlWeeklyBookings = "SELECT WEEK(bookings.created_at) AS week_number, COUNT(*) AS weekly_bookings
//                      FROM bookings
//                      JOIN schedules ON bookings.schedule_id = schedules.schedule_id
//                      WHERE schedules.operator_id = $operatorId
//                      AND YEAR(bookings.created_at) = $year
//                      GROUP BY week_number";

// $resultWeeklyBookings = mysqli_query($connect, $sqlWeeklyBookings);

// $weeklyBookingsData = array();
// while ($row = mysqli_fetch_assoc($resultWeeklyBookings)) {
//     $weeklyBookingsData[] = $row;
// }

// $sqlMonthlyBookings = "SELECT MONTH(bookings.created_at) AS month_number, COUNT(*) AS monthly_bookings
//                       FROM bookings
//                       JOIN schedules ON bookings.schedule_id = schedules.schedule_id
//                       WHERE schedules.operator_id = $operatorId
//                       AND YEAR(bookings.created_at) = $year
//                       GROUP BY month_number";


// $resultMonthlyBookings = mysqli_query($connect, $sqlMonthlyBookings);

// $monthlyBookingsData = array();
// while ($row = mysqli_fetch_assoc($resultMonthlyBookings)) {
//     $monthlyBookingsData[] = $row;
// }


echo json_encode(array(
    "success" => true,
    "message" => "Stats retrieved successfully",
    "statistics" => array(
        "total_cars" => $totalCars,
        "total_drivers" => $totalDrivers,
        "total_tour_packages" => $totalTourPackages,
        "total_bookings" => $totalBookings,
        "total_revenue" => $totalRevenue,
        "total_monthly_revenue" => $totalMonthlyRevenue ?? "0",
        "top_cars" => $top_cars
        // "weekly_bookings" => $weeklyBookingsData,
        // "monthly_bookings" => $monthlyBookingsData,

    )

));
