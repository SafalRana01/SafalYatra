<?php
// Including the database connection and email sending utility
include "../config/connection.php";
include "../utils/sendEmail.php";

// Generating a 6-digit OTP by shuffling numbers
$otp_str = str_shuffle("0123456789");
$otp = substr($otp_str, 0, 6);

// Generating an activation code using lowercase letters and numbers
$length = 10; // Length of the activation code
$characters = 'abcdefghijklmnopqrstuvwxyz0123456789'; // Characters to include in the activation code
$activation_code = substr(str_shuffle($characters), 0, $length);

// Checking if all required fields are sent in the POST request
if (isset(
    $_POST["name"],
    $_POST["phone"],
    $_POST['registration_number'],
    $_POST["email"],
    $_POST["password"],
    $_POST['location']
)) {
    // Retrieving form data from POST request
    $operatorName = $_POST["name"];
    $phone = $_POST["phone"];
    $registrationNumber = $_POST['registration_number'];
    $email = $_POST["email"];
    $password = $_POST["password"];
    $location = $_POST["location"];
    $currentDateTime = date("Y-m-d H:i:s"); // Getting the current date and time
    $hashed_password = password_hash($password, PASSWORD_DEFAULT); // Hashing the car operator's password

    // Checking if the provided email already exists in the car_operators table
    $emailQuery = "SELECT * FROM car_operators WHERE email = '$email'";
    $result = $connect->query($emailQuery); // Execute the query

    // If email is found in the database
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $status = $row['status'];
        // Checking if the email already belongs to an active or verified operator
        if ($status == 'active' || $status == 'Verified') {
            // Returning error if email is already used by verified user
            echo json_encode(array(
                "success" => false,
                "message" => "Email already registered!"
            ));
            die();
        } else {
            // Checking if the registration number is already used by a verified account
            $sql = "SELECT * FROM car_operators WHERE registration_number = '$registrationNumber' AND (status = 'active' OR status = 'Verified')";
            $result = $connect->query($sql);
            if ($result->num_rows > 0) {
                // Returning error if license number is already used
                echo json_encode(array(
                    "success" => false,
                    "message" => "License number already registered!"
                ));
                die();
            }
            // Updating details of the unverified user using submitted data
            $sqlUpdate = "UPDATE car_operators SET operator_name = '$operatorName', phone_number = '$phone', registration_number = '$registrationNumber',  password = '$hashed_password', otp = '$otp', 
              activation_code = '$activation_code', location = '$location', signup_time = '$currentDateTime' WHERE email = '$email'";
            $result = $connect->query($sqlUpdate);

            // If update is successful, sending email verification
            if ($result) {
                $result = sendVerificationEmail($email, $otp, $activation_code);
                if ($result === true) {
                    // Sending success response with activation details
                    echo json_encode(array(
                        "success" => true,
                        "message" => "please check your email for verification code",
                        "activation_code" => $activation_code,
                        "role" => "operator",
                        "email" => $email
                    ));

                    die();
                } else {
                    // Sending error response if email sending fails
                    echo json_encode(array(
                        "success" => false,
                        "message" => "Failed to send email: " . $sendEmailResult
                    ));
                }
            }
        }
    } else {
        // Checking if registration number is already used by verified users
        $sql = "SELECT * FROM car_operators WHERE registration_number = '$registrationNumber' AND (status = 'active' OR status = 'Verified')";
        $result = $connect->query($sql);
        if ($result->num_rows > 0) {
            // Returning error message for license number duplication
            echo json_encode(array(
                "success" => false,
                "message" => "License number already registered!"
            ));
            die();
        }
        // Sending verification email before inserting new record
        $result = sendVerificationEmail($email, $otp, $activation_code);
        if ($result === true) {
            // If email sent successfully, inserting the new operator record into the database
            $insertQuery = "INSERT INTO car_operators (operator_name, phone_number, registration_number, location,  email, password, otp, activation_code) VALUES ('" . $operatorName . "', '" . $phone . "', '" . $registrationNumber . "', '" . $location . "', '" . $email . "', '" . $hashed_password . "', '" . $otp . "', '" . $activation_code . "')";
            $result = $connect->query($insertQuery);

            // Returning success response if insertion is successful
            if ($result) {
                echo json_encode(array(
                    "success" => true,
                    "message" => "please check your email for verification code",
                    "activation_code" => $activation_code,
                    "role" => "operator",
                    "email" => $email

                ));
            } else {
                // Returning failure response if database insertion fails
                echo json_encode(array(
                    "success" => false,
                    "message" => "Registration failed, please try again later"
                ));
            }
        } else {
            // Sending error if email verification fails
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send email: " . $sendEmailResult
            ));
        }
    }
} else {
    // Returning error if any required field is missing
    echo json_encode(array(
        "success" => false,
        "message" => "All fields are required"
    ));
}
