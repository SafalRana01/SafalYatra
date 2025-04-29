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
    $_POST['location'],
    $_POST['start_date'],
    $_POST['end_date'],
)) {

    $location = $_POST['location'];
    $startDate = $_POST['start_date'];
    $endDate = $_POST['end_date'];



    $sql = "SELECT c.*, cat.category_name
    FROM cars c
    JOIN car_operators co ON c.operator_id = co.operator_id
    JOIN categories cat ON c.category_id = cat.category_id
    LEFT JOIN bookings b ON c.car_id = b.car_id 
        AND ((b.start_date BETWEEN '$startDate' AND '$endDate') 
            OR (b.end_date BETWEEN '$startDate' AND '$endDate'))
        AND b.status = 'success'
    LEFT JOIN tour_packages tp ON c.car_id = tp.car_id
        AND ((tp.start_date BETWEEN '$startDate' AND '$endDate') 
            OR (tp.end_date BETWEEN '$startDate' AND '$endDate'))
    WHERE co.location = '$location'
    AND b.car_id IS NULL
    AND tp.car_id IS NULL";


    $result = mysqli_query($connect, $sql);




    // Fetch the result as an associative array
    if ($result->num_rows > 0) {
        $availableCars = array();
        while ($row = $result->fetch_assoc()) {
            $availableCars[] = $row;
        }

        // Send the JSON response
        echo json_encode(array(
            "success" => true,
            "message" => "Available cars fetched successfully",
            "listCars" => $availableCars
        ));
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "No available cars found"
        ));
        die();
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "location, start_date, end_date are required"
    ));
    die();
}
