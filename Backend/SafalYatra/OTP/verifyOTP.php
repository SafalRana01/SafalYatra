<?php
include "../config/connection.php";

if (isset($_POST['otp'], $_POST['email'], $_POST['role'])) {

    $otp = $_POST['otp'];
    $email = $_POST['email'];
    $role = $_POST['role'];

    $sql = '';

    if ($role == 'user') {
        $sql = "SELECT * FROM users WHERE email = '$email' AND otp = $otp";
        $result = mysqli_query($connect, $sql);

        if (mysqli_num_rows($result) > 0) {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP verified",
                "role" => "user"
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid OTP"
            ));
            die();
        }
    } else if ($role == 'operator') {
        $sql = "SELECT * FROM car_operators WHERE email = '$email' AND otp = $otp";
        $result = mysqli_query($connect, $sql);

        if (mysqli_num_rows($result) > 0) {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP verified",
                "role" => "operator"
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid OTP"
            ));
            die();
        }
    } else if ($role == 'driver') {
        $sql = "SELECT * FROM drivers WHERE email = '$email' AND otp = $otp";
        $result = mysqli_query($connect, $sql);

        if (mysqli_num_rows($result) > 0) {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP verified",
                "role" => "driver"
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid OTP"
            ));
            die();
        }
    } else {
        $sql = "SELECT * FROM admins WHERE email = '$email' AND otp = $otp";
        $result = mysqli_query($connect, $sql);

        if (mysqli_num_rows($result) > 0) {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP verified",
                "role" => "admin"
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid OTP"
            ));
            die();
        }
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "OTP, Email and Role is required"
    ));
    die();
}
