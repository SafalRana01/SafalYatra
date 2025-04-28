<?php
// Including database connection file and authentication helper functions
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if token is provided in POST request
if (!isset($_POST['token'])) {
    // Sending error response if token is missing
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping script
}

$token = $_POST['token']; // Storing the token from POST request
$adminId = getAdminId($token); // Getting admin ID by validating token

// Checking if admin ID is valid
if (!$adminId) {
    // Sending error response if token is invalid
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Stopping script
}

// Initializing variables for storing statistics
$totalUsers;
$totalOperators;
$totalCars;
$totalDrivers;
$totalTourPackages;
$totalBookings;
$totalRevenue;
$totalMonthlyRevenue;

// Fetching total users count
$sql = "SELECT count(*) AS total_users FROM users"; // Preparing query to count total users
$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result); // Fetching result as associative array
    $totalUsers = $row['total_users']; // Storing total users count
}

// Fetching total car operators count
$sql = "SELECT count(*) AS total_operators FROM car_operators";
$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result); // Fetching result as associative array
    $totalOperators = $row['total_operators']; // Storing total cars count
}

// Fetching total cars count
$sql = "SELECT count(*) AS total_cars FROM cars"; // Preparing query to count total drivers
$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result); // Fetching result as associative array
    $totalCars = $row['total_cars'];
}

// Fetching total drivers count
$sql = "SELECT count(*) AS total_drivers FROM drivers"; // Preparing query to count total drivers
$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result); // Fetching result as associative array
    $totalDrivers = $row['total_drivers']; // Storing total drivers count
}

// Fetching total tour packages count
$sql = "SELECT count(*) AS total_tour_packages FROM tour_packages"; // Preparing query to count total tour packages
$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result); // Fetching result as associative array
    $totalTourPackages = $row['total_tour_packages']; // Storing total tour packages count
}

// Fetching total bookings with status 'Success' or 'Cancelled'
$sql = "SELECT COUNT(*) AS total_bookings 
        FROM bookings 
        WHERE status = 'Success' OR status = 'Cancelled'"; // Preparing query to count successful or cancelled bookings

$result = mysqli_query($connect, $sql);
if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalBookings = $row['total_bookings']; // Storing total bookings count
}

// Fetching total revenue by summing all payments
$sql = "SELECT ROUND(SUM(payment_amount/100), 2) AS total_revenue FROM payments"; // Preparing query to calculate total revenue (dividing by 100 to convert paisa to rupees)

$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalRevenue = $row['total_revenue']; // Storing total revenue
}

// Setting current month and year by default
$month = date("m"); // Getting current month
$year = date("Y"); // Getting current year

// Checking if month and year are provided in POST request
if (isset($_POST['month'], $_POST['year'])) {
    $month = $_POST['month']; // Overwriting month from POST data
    $year = $_POST['year']; // Overwriting year from POST data
}

// Fetching total monthly revenue based on month and year
$sql = "SELECT ROUND(SUM(payment_amount/100), 2) AS total_income
        FROM payments 
        WHERE MONTH(payment_date) = $month
        AND YEAR(payment_date) = $year"; // Preparing query to calculate monthly income

$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $totalMonthlyRevenue = $row['total_income']; // Storing total monthly revenue
}

// Fetching top 5 operators based on their income
$sql = "SELECT car_operators.operator_id, car_operators.operator_name, SUM(payment_amount) AS total_income
        FROM payments 
        JOIN bookings ON payments.booking_id = bookings.booking_id
        JOIN cars ON bookings.car_id = cars.car_id
        JOIN car_operators ON cars.operator_id = car_operators.operator_id
        GROUP BY car_operators.operator_id
        ORDER BY total_income DESC
        LIMIT 5";

$result = mysqli_query($connect, $sql);

// Checking if top 5 operators query failed
if (!$result) {
    echo json_encode(array(
        "success" => false,
        "message" => "Error fetching top 5 bus operators",
        "error" => mysqli_error($connect)
    ));
    die(); // Stopping script
}

// Storing top 5 operators result as associative array
$top_operators = mysqli_fetch_all($result, MYSQLI_ASSOC);

// Initializing remaining amount and percentage for "Others"
$remainingAmount = $totalRevenue * 100;
$remainingPercent = 100;

// Calculating each operator's percentage and updating remaining amount and percent
foreach ($top_operators as $key => $operator) {
    $top_operators[$key]['percentage'] = round(($operator['total_income'] / ($totalRevenue * 100)) * 100, 2); // Calculating operator's income percentage based on total revenue
    $remainingPercent -= $top_operators[$key]['percentage'];  // Reducing the remaining percentage
    $remainingAmount -= $top_operators[$key]['total_income']; // Reducing the remaining income amount
}

// Adding "Others" category with remaining income and percentage
$top_operators[] = array(
    "operator_id" => 0, // Setting ID as 0 for "Others" category
    "operator_name" => "Others", // Naming the category as "Others"
    "total_income" => $remainingAmount, // Storing the remaining income amount
    "percentage" => abs(round($remainingPercent))  // Storing the remaining percentage (ensuring positive value)
);

// Sending final success response with all statistics
echo json_encode(array(
    "success" => true,
    "message" => "Stats retrieved successfully",
    "statistics" => array(
        "total_users" => $totalUsers,
        "total_operators" => $totalOperators,
        "total_cars" => $totalCars,
        "total_drivers" => $totalDrivers,
        "total_tour_packages" => $totalTourPackages,
        "total_bookings" => $totalBookings,
        "total_revenue" => $totalRevenue,
        "total_monthly_revenue" => $totalMonthlyRevenue ?? '0',
        "top_operators" => $top_operators
    )
));
