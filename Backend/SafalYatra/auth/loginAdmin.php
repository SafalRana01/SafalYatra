<?php
// Include the database connection file
include "../config/connection.php";


// Check if both email and password are provided in the POST request
if (isset(
    $_POST['email'],
    $_POST['password'],
)) {

    // Retrieve email and password from POST request
    $email = $_POST['email'];
    $password = $_POST['password'];

    // SQL query to find admin with matching email
    $sql = "select * from admins where email ='$email'";

    // Execute the query
    $result = mysqli_query($connect, $sql);

    // Get the number of rows returned (should be 1 if email exists)
    $count = mysqli_num_rows($result);

    // If no admin found with that email
    if ($count == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "User not found"
        ));
        die(); // Stop further script execution
    }

    // Fetch admin details from the result
    $admin = mysqli_fetch_assoc($result);

    // Get the hashed password from database
    $hashed_password = $admin['password'];

    // Verify if the entered password matches the hashed one
    $is_correct = password_verify($password, $hashed_password);

    // If password is incorrect
    if (!$is_correct) {
        echo json_encode(array(
            "success" => false,
            "message" => "Incorrect password"
        ));
        die();
    }

    // If credentials are correct, generate a secure random token
    $token = bin2hex(random_bytes(16));

    // Get the admin ID
    $admin_id = $admin['admin_id'];

    // Insert the token into the access_tokens table for session tracking
    $sql = "INSERT INTO access_tokens (token, admin_id) VALUES('$token', '$admin_id')";
    $result = mysqli_query($connect, $sql);

    // If token insertion fails
    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Login failed, please try again later"
        ));
        die();
    }

    // Define admin role
    $userRole = 'admin';

    // Return success response with token and role
    echo json_encode(array(
        "success" => true,
        "message" => "Login successful",
        "token" => $token,
        "role" => $userRole

    ));
} else {
    // If email or password was not provided in the POST request
    echo json_encode(array(
        "success" => false,
        "message" => "Email, password are required"
    ));
}
