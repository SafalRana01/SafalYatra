<?php
// Including the database connection and email sending utility
include "../config/connection.php";
include "../utils/sendEmail.php";


// Checking if all required fields are being sent through POST request
if (isset(
    $_POST['fullName'],
    $_POST['phone'],
    $_POST['email'],
    $_POST['password'],
)) {

    // Retrieving values from the POST request
    $fullName = $_POST['fullName'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];
    $password = $_POST['password'];


    // Preparing SQL query for checking if the email already exists
    $sql = "SELECT * FROM admins WHERE email ='$email'";
    $result = mysqli_query($connect, $sql);

    // Counting existing records with the same email
    $count = mysqli_num_rows($result);

    // Handling the case where the email is already registered
    if ($count > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Email already exists"
        ));
        die(); // Stopping script execution
    }

    // Hashing the password securely before storing
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Creating an SQL query for inserting the new admin data
    $sql = "INSERT INTO admins(email, password, admin_name, phone_number) VALUES('$email', '$hashed_password', '$fullName', '$phone')";

    // Executing the insertion query
    $result = mysqli_query($connect, $sql);

    // Handling insertion failure
    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Registration failed, please try again later"
        ));
        die(); // Stopping further execution
    }

    // Returning a success message after registering the admin
    echo json_encode(array(
        "success" => true,
        "message" => "Admin registered successfully"
    ));
} else {
    // Handling the case where some required fields are missing
    echo json_encode(array(
        "success" => false,
        "message" => "All fields are required"
    ));
}
