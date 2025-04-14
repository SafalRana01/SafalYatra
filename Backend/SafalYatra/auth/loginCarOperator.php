<?php
// Include the database connection file
include "../config/connection.php";


// Check if both 'email' and 'password' are set in the POST request
if (isset(
    $_POST['email'],
    $_POST['password'],
)) {

    // Retrieve email and password from POST request
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Prepare SQL query to check if a car operator with the provided email exists
    $sql = "select * from car_operators where email ='$email'";

    // Execute the query
    $result = mysqli_query($connect, $sql);

    // Count how many rows were returned
    $count = mysqli_num_rows($result);

    // If no operator found with that email
    if ($count == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "User not found"
        ));
        die(); // Stop further execution
    }

    // Fetch operator data
    $operator = mysqli_fetch_assoc($result);

    // Check account status (should be 'active' or 'Verified')
    $status = $operator['status'];

    if ($status == 'active' || $status == 'Verified') {

        // Get the hashed password stored in the database
        $hashed_password = $operator['password'];

        // Verify that the input password matches the hashed password
        $is_correct = password_verify($password, $hashed_password);

        // If password doesn't match
        if (!$is_correct) {
            echo json_encode(array(
                "success" => false,
                "message" => "Incorrect password"
            ));
            die();
        }

        // Generate a random token for session management
        $token = bin2hex(random_bytes(16)); // 32-character session token

        // Get the operator ID from the fetched data
        $operator_id = $operator['operator_id'];


        // Insert the token into the access_tokens table with reference to the operator
        $sql = "INSERT INTO access_tokens (token, operator_id) VALUES('$token', '$operator_id')";
        $result = mysqli_query($connect, $sql);

        // If insertion fails, send error response
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Login failed, please try again later"
            ));
            die();
        }

        // Define operator role
        $userRole = 'operator';

        // Return a successful login response with the token and role
        echo json_encode(array(
            "success" => true,
            "message" => "Login successful",
            "token" => $token,
            "role" => $userRole // Include the default user role in the response
        ));
    } else {
        // If account is not verified or active
        echo json_encode(array(
            "success" => false,
            "message" => "Your account is not verified."
        ));
    }
} else {
    // If email or password is not provided in the request
    echo json_encode(array(
        "success" => false,
        "message" => "Email and password are required"
    ));
}
