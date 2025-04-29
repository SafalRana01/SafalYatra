<?php
include "../config/connection.php";

if (isset($_POST['code'], $_POST['otp'])) {
    $activation_code = $_POST['code'];
    $otp = $_POST['otp'];

    $sqlSelect = "SELECT * FROM users WHERE activation_code = '" . $activation_code . "'";
    $result = $connect->query($sqlSelect);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $rowOtp = $row['otp'];
        $rowSignUpTime = $row['signup_time'];

        $rowSignUpTime = date('d-m-Y h:i:s', strtotime($rowSignUpTime));
        $rowSignUpTime = date_create($rowSignUpTime);
        date_modify($rowSignUpTime, "+5 minutes");
        $timeUp = date_format($rowSignUpTime, 'd-m-Y h:i:s');

        if ($rowOtp !== $otp) {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid OTP"

            ));
            die();
        } else {
            if (date('d-m-Y h:i:s') >= $timeUp) {
                echo json_encode(array(
                    "success" => false,
                    "message" => "OTP expired, Resend OTP"
                ));
                die();
            } else {
                $sqlUpdate = "UPDATE users SET otp = '', status ='active' WHERE  otp = '" . $otp . "' AND activation_code = '" . $activation_code . "'";
                $result = $connect->query($sqlUpdate);
                if ($result) {
                    echo json_encode(array(
                        "success" => true,
                        "message" => "Account Activated successfully",
                        "role" => "user"
                    ));
                } else {
                    echo json_encode(array(
                        "success" => false,
                        "message" => "Failed to activate account"
                    ));
                    die();
                }
            }
        }
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Invalid Activation Code"
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Activation Code and OTP are required"
    ));
}
