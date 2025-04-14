<?php
// Include the database connection and email utility functions
include "../config/connection.php";
include "../utils/sendEmail.php";

// Generating a 6-digit OTP by shuffling numbers
$otp_str = str_shuffle("0123456789");
$otp = substr($otp_str, 0, 6);

// Generating a random 10-character activation code
$length = 10; // Length of the activation code
$characters = 'abcdefghijklmnopqrstuvwxyz0123456789'; // Characters to include in the activation code
$activation_code = substr(str_shuffle($characters), 0, $length);


// Checking if all required fields are sent in the POST request
if (isset(
    $_POST['fullName'],
    $_POST['address'],
    $_POST['phone'],
    $_POST['gender'],
    $_POST['email'],
    $_POST['password']
)) {

    // Retrieving form data from POST request
    $fullName = $_POST['fullName'];
    $address = $_POST['address'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $gender = $_POST['gender'];
    $currentDateTime = date("Y-m-d H:i:s"); // Getting the current date and time
    $hashed_password = password_hash($password, PASSWORD_DEFAULT); // Hashing the user's password

    // Preparing an SQL query to check if the email already exists in the database
    $sql = "select * from users where email ='$email'";
    // Execute the query
    $result = mysqli_query($connect, $sql);

    // Counting how many rows (users) found with the same email
    $count = mysqli_num_rows($result);

    // Checking if the email is already registered
    if ($count > 0) {
        $row = $result->fetch_assoc();
        $status = $row['status']; // Get the current status of the user 
        if ($status == 'active') {
            // If user is already active, reject registration
            echo json_encode(array(
                "success" => false,
                "message" => "Email already registered!"
            ));
            die(); // Stop further execution


        } else {
            // If user is inactive, updating their details and resend verification email
            $sql = "UPDATE users SET full_name = '$fullName', email = '$email', password = '$hashed_password',gender = '$gender', phone_number = '$phone', address = '$address', otp = '$otp', activation_code = '$activation_code', signup_time = '$currentDateTime' WHERE email = '$email'";
            $result = mysqli_query($connect, $sql);

            // Sending verification email after updating user details
            if ($result) {
                $result = sendVerificationEmail($email, $otp, $activation_code);
                if ($result === true) { // Checking if the email was sent successfully
                    echo json_encode(array(
                        "success" => true,
                        "message" => "Check your email for verification code",
                        "activation_code" => $activation_code,
                        "role" => "user",
                        "email" => $email
                    ));

                    die();
                } else {
                    // If email sending fails
                    echo json_encode(array(
                        "success" => false,
                        "message" => "Failed to send email: " . $sendEmailResult
                    ));
                    die();
                }
            }
        }
    }

    // Sending verification email for new user registration
    $result = sendVerificationEmail($email, $otp, $activation_code);
    if ($result === true) {
        // If email sent successfully, insert new user into database
        $insertQuery = "INSERT INTO users (full_name, address , phone_number, email, password, gender, otp, activation_code) VALUES ('" . $fullName . "', '" . $address . "', '" . $phone . "', '" . $email . "', '" . $hashed_password . "','" . $gender . "', '" . $otp . "', '" . $activation_code . "')";
        $result = $connect->query($insertQuery);
        if ($result) { // Responding with success when the user is registered successfully
            echo json_encode(array(
                "success" => true,
                "message" => "Check your email for verification code",
                "activation_code" => $activation_code,
                "role" => "user",
                "email" => $email
            ));
        } else {
            // If insertion fails
            echo json_encode(array(
                "success" => false,
                "message" => "Registration failed, please try again later"
            ));
            die();
        }
    } else {
        // If email sending fails
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to send email: " . $sendEmailResult
        ));
        die();
    }
} else {
    // If any required field is missing from POST request
    echo json_encode(array(
        "success" => false,
        "message" => "All fields are required"
    ));
}
