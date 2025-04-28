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

if (isset($_POST['driver_name'], $_POST['contact_number'], $_POST['email'], $_POST['password'], $_POST['license_number'], $_POST['gender'], $_POST['age'], $_POST['experience'])) {
    $driverName = $_POST['driver_name'];
    $driverContact = $_POST['contact_number'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $licenseNumber = $_POST['license_number'];
    $gender = $_POST['gender'];
    $age = $_POST['age'];
    $experience = $_POST['experience'];

    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $emailQuery = "SELECT * FROM drivers WHERE email = '$email' AND operator_id = $operatorId";
    $result = $connect->query($emailQuery);
    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Email already registered!"
        ));
        die();
    }

    $phoneQuery = "SELECT * FROM drivers WHERE phone_number = '$driverContact' AND operator_id = $operatorId";
    $result = $connect->query($phoneQuery);
    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Phone number already registered!"
        ));
        die();
    }

    $licenseQuery = "SELECT * FROM drivers WHERE license_number = '$licenseNumber' AND operator_id = $operatorId";
    $result = $connect->query($licenseQuery);
    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Driver with this license number already registered!"
        ));
        die();
    }

    $sql = "INSERT INTO drivers (operator_id, driver_name, phone_number, email, password, license_number, gender, age, experience) VALUES ($operatorId, '$driverName', '$driverContact', '$email', '$hashed_password', '$licenseNumber', '$gender', '$age', '$experience')";
    $result = mysqli_query($connect, $sql);

    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Driver registered successfully"
        ));
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to register driver"
        ));
        die();
    }
} else {

    echo json_encode(array(
        "success" => false,
        "message" => "Driver details are required"
    ));
    die();
}
