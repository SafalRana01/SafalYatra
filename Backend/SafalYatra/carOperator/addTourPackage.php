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

$sql = "SELECT status FROM car_operators WHERE operator_id = $operatorId";
$result = mysqli_query($connect, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    $status = $row['status'];
    if ($status != 'Verified') {
        echo json_encode(array(
            "success" => false,
            "message" => "Your account is not verified by the admin!"
        ));
        die();
    }
}

if (isset(
    $_POST['car_id'],
    $_POST['driver_id'],
    $_POST['package_name'],
    $_POST['description'],
    $_POST['price_per_person'],
    $_POST['start_date'],
    $_POST['end_date'],
    $_POST['start_location'],
    $_POST['destination'],
    $_FILES['image']


)) {

    $carId = $_POST['car_id'];
    $driverId = $_POST['driver_id'];
    $packageName = $_POST['package_name'];
    $description = $_POST['description'];
    $pricePerPerson = $_POST['price_per_person'];
    $startDate = $_POST['start_date'];
    $endDate = $_POST['end_date'];
    $startLocation = $_POST['start_location'];
    $endLocation = $_POST['destination'];

    $tourDuration = ceil((strtotime($endDate) - strtotime($startDate)) / (60 * 60 * 24)) + 1;


    $sql = "SELECT c.*
            FROM cars c
            JOIN car_operators co ON c.operator_id = co.operator_id
            LEFT JOIN bookings b ON c.car_id = b.car_id 
                AND ((start_date between '$startDate' and '$endDate') or (end_date between '$startDate' and '$endDate'))
                AND b.status = 'success'
            WHERE 
            b.car_id = $carId";

    $result = mysqli_query($connect, $sql);
    // Fetch the result as an associative array
    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Car is not available for the selected date range"
        ));
        die();
    }

    $sql = "SELECT d.driver_id, d.driver_name, d.phone_number, d.email, d.image_url, d.age, d.gender, d.experience
            FROM drivers d
            LEFT JOIN bookings b ON d.driver_id = b.driver_id 
                AND ((b.start_date BETWEEN '$startDate' AND '$endDate') OR (b.end_date BETWEEN '$startDate' AND '$endDate'))
                AND b.status = 'success'
            WHERE 
            d.status = 'Available'
            AND b.driver_id = $driverId";
    $result = mysqli_query($connect, $sql);
    // Fetch the result as an associative array
    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Driver is not available for the selected date range"
        ));
        die();
    }

    $sql = "SELECT * FROM tour_packages  
    WHERE 
    ((start_date BETWEEN '$startDate' AND '$endDate') OR (end_date BETWEEN '$startDate' AND '$endDate'))
    AND driver_id = $driverId";
    $result = mysqli_query($connect, $sql);
    // Fetch the result as an associative array
    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Driver is not available for the selected date range"
        ));
        die();
    }


    $sql = "SELECT * FROM tour_packages WHERE car_id = $carId AND  ((start_date BETWEEN '$startDate' AND '$endDate') OR (end_date BETWEEN '$startDate' AND '$endDate'))";

    $result = mysqli_query($connect, $sql);

    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Car is not available for the selected date range"
        ));
        die();
    }

    $imageUrl = null;



    $image = $_FILES['image'];

    $image_size = $image['size'];

    if ($image_size > 5 * 1024 * 1024) {
        echo json_encode(array(
            "success" => false,
            "message" => "Image size should be less than 5 MB"
        ));
        die();
    }

    $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

    $allowed = ["jpg", "jpeg", "png", "webp"];

    if (!in_array($ext, $allowed)) {
        echo json_encode(array(
            "success" => false,
            "message" => "Invalid image format"
        ));
    }

    // $new_name = uniqid() . "." . $ext;
    // $temp_location = $image['tmp_name'];
    // $new_location = "../images/" . $new_name;
    // $image_url = "images/" . $new_name;

    // Assuming you already have role and id from token
    $role = 'operator'; // Since this is a driver profile update
    $id = $operatorId;

    // Get file extension
    // $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

    // Create unique file name: role_id_timestamp.ext
    $new_name = $role . "_" . $id . "_" . time() . "." . $ext;

    // Temporary and final locations
    $temp_location = $image['tmp_name']; // Temporary location of the uploaded image
    $new_location = "../images/" . $new_name; // New location for saving the image
    $image_url = "images/" . $new_name; // URL to access the image in flutter


    if (!move_uploaded_file($temp_location, $new_location)) {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to upload image"
        ));
    }

    $imageUrl = $image_url;

    $sql = "SELECT seating_capacity FROM cars WHERE car_id = $carId";
    $result = mysqli_query($connect, $sql);

    $tourCapacity = 0;

    if ($result) {
        $row = mysqli_fetch_assoc($result);
        $tourCapacity = $row['seating_capacity'];
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed fetch car capacity"
        ));
        die();
    }


    $tourQuery = "INSERT INTO tour_packages (operator_id, car_id, driver_id, package_name, description, price, start_date, end_date, start_location, destination, tour_capacity, available_capacity , duration, image_url ) VALUES ('$operatorId', '$carId', '$driverId', '$packageName', '$description', '$pricePerPerson', '$startDate', '$endDate', '$startLocation', '$endLocation', '$tourCapacity', '$tourCapacity', '$tourDuration', '$imageUrl')";
    $result = mysqli_query($connect, $tourQuery);


    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Tour Package added successfully."
        ));
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to add tour package"
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "All fields are required."
    ));
}
