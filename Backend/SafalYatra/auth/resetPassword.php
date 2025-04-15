<?php
// Including database connection
include "../config/connection.php";

// Checking if email, password, and role are set in the POST request
if (isset($_POST['email'], $_POST['password'], $_POST['role'])) {

    $email = $_POST['email']; // Getting the email
    $new_password = $_POST['password']; // Getting the new password
    $role = $_POST['role']; // Getting the user role

    // Hashing the new password before storing it in the database
    $hash_password = password_hash($new_password, PASSWORD_DEFAULT);

    $sql = '';
    // Checking the role and updating the password accordingly
    if ($role == 'user') {
        // SQL query to update the user's password
        $sql = "update users set password = '$hash_password' where email = '$email'";
        $result = mysqli_query($connect, $sql);

        // Checking if the password reset was successful
        if ($result) {
            // Sending a success response
            echo json_encode(array(
                "success" => true,
                "message" => "Password reset successfully",
                "role" => "user"
            ));

            // Clearing the OTP for the user
            $sql = "update users set otp = '' where email = '$email'";
            $result = mysqli_query($connect, $sql);
        } else {
            // If the password reset fails
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to reset password"
            ));
            die();
        }
    } else if ($role == 'operator') {
        // SQL query to update the operator's password
        $sql = "update car_operators set password = '$hash_password' where email = '$email'";
        $result = mysqli_query($connect, $sql);

        if ($result) {
            // Sending a success response
            echo json_encode(array(
                "success" => true,
                "message" => "Password reset successfully",
                "role" => "operator"
            ));

            // Clearing the OTP for the operator
            $sql = "update car_operators set otp = '' where email = '$email'";
            $result = mysqli_query($connect, $sql);
        } else {
            // If the password reset fails
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to reset password"
            ));
            die();
        }
    } else if ($role == 'driver') {
        // SQL query to update the driver's password
        $sql = "update drivers set password = '$hash_password' where email = '$email'";
        $result = mysqli_query($connect, $sql);

        if ($result) {
            // Sending a success response
            echo json_encode(array(
                "success" => true,
                "message" => "Password reset successfully",
                "role" => "driver"
            ));

            // Clearing the OTP for the driver
            $sql = "update drivers set otp = '' where email = '$email'";
            $result = mysqli_query($connect, $sql);
        } else {
            // If the password reset fails
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to reset password"
            ));
            die();
        }
    } else {
        // SQL query to update the admin's password
        $sql = "update admins set password = '$hash_password' where email = '$email'";
        $result = mysqli_query($connect, $sql);

        if ($result) {
            // Sending a success response
            echo json_encode(array(
                "success" => true,
                "message" => "Password reset successfully",
                "role" => "admin"
            ));

            // Clearing the OTP for the admin
            $sql = "update admins set otp = '' where email = '$email'";
            $result = mysqli_query($connect, $sql);
        } else {
            // If the password reset fails
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to reset password"
            ));
            die();
        }
    }
} else {
    // If email, password, or role are not provided
    echo json_encode(array(
        "success" => false,
        "message" => "Email, password and role are required"
    ));
    die();
}
