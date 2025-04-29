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

if (isset($_POST['start_date'], $_POST['end_date'], $_POST['operator_id'])) {
    $startDate = $_POST['start_date'];
    $endDate = $_POST['end_date'];
    $operatorId = $_POST['operator_id'];

    $sql = "SELECT d.driver_id, d.driver_name, d.phone_number, d.email, d.image_url, d.age, d.gender, d.experience
FROM drivers d
LEFT JOIN bookings b 
    ON d.driver_id = b.driver_id 
    AND ((b.start_date BETWEEN '$startDate' AND '$endDate') 
        OR (b.end_date BETWEEN '$startDate' AND '$endDate'))
    AND b.status = 'success'
LEFT JOIN tour_packages tp 
    ON d.driver_id = tp.driver_id
    AND ((tp.start_date BETWEEN '$startDate' AND '$endDate') 
        OR (tp.end_date BETWEEN '$startDate' AND '$endDate'))
WHERE d.operator_id = '$operatorId'
    AND d.status = 'Available'
    AND b.driver_id IS NULL 
    AND tp.driver_id IS NULL
";

    $result = mysqli_query($connect, $sql);

    if ($result->num_rows > 0) {
        $availableDrivers = array();
        while ($row = $result->fetch_assoc()) {
            $availableDrivers[] = $row;
        }

        echo json_encode(array(
            "success" => true,
            "message" => "Available drivers fetched successfully",
            "listDrivers" => $availableDrivers
        ));
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "No available drivers found"
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "start_date, end_date, and operator_id are required"
    ));
}
