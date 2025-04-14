<?php
// Including the database connection file
include "../config/connection.php";


// Checking if the email and password are set in the POST request
if (isset(
    $_POST['email'], // Check if 'email' key exists in POST
    $_POST['password'], // Check if 'password' key exists in POST
)) {

    // Retrieving email and password from the POST request
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Preparing an SQL query to find a user with the given email
    $sql = "select * from users where email ='$email'";

    // Executing the query
    $result = mysqli_query($connect, $sql);

    // Counting how many users matched the email
    $count = mysqli_num_rows($result);

    // If no user found with the given email
    if ($count == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "User not found"
        ));
        die(); // Stopping further execution
    }

    // Fetching the user data from the query result
    $user = mysqli_fetch_assoc($result);

    // Checking the user's account status
    $status = $user['status'];
    if ($status == 'active') {

        // Retrieving the hashed password from the database
        $hashed_password = $user['password'];

        // Verify entered password with hashed password from DB
        $is_correct = password_verify($password, $hashed_password);

        // If password does not match
        if (!$is_correct) {
            echo json_encode(array(
                "success" => false,
                "message" => "Incorrect password"
            ));
            die(); // Stop execution
        }

        // If password is correct, Generating a random token for the user session
        $token = bin2hex(random_bytes(16)); // 32-character token

        // Retrieving the user ID of the authenticated user
        $user_id = $user['user_id'];


        // Inserting the generated token into the access_tokens table
        $sql = "INSERT INTO access_tokens (token, user_id) VALUES('$token', '$user_id')";

        $result = mysqli_query($connect, $sql);


        // If token insertion fails
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Login failed, please try again later"
            ));
            die();
        }


        // Defining a default role for the user
        $userRole = 'user';

        // Returning success response with token and role
        echo json_encode(array(
            "success" => true,
            "message" => "Login successful",
            "token" => $token,
            "role" => $userRole // Include the default user role in the response
        ));
    } else {
        // If user's account is not verified/active
        echo json_encode(array(
            "success" => false,
            "message" => "Your account is not verified"
        ));
    }
} else {
    // If email or password was not sent in the request
    echo json_encode(array(
        "success" => false,
        "message" => "Email, password are required"
    ));
}
