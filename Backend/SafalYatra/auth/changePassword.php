<?php
// Including database connection and authentication helper functions
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if the token is provided in the POST request
if (!isset($_POST['token'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping script execution if token is missing

}

// Getting the token from the request
$token = $_POST['token'];

// Extracting user IDs based on the token (for user, operator, driver, and admin)
$userId = getUserId($token);
$operatorId = getOperatorId($token);
$driverId = getDriverId($token);
$adminId = getAdminId($token);

// Verifying the token and confirming at least one user role is matched
if (!$userId && !$operatorId && !$driverId && !$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die(); // Exiting if no valid ID is found
}


// Checking if required fields are provided for password update
if (isset($_POST['old_password'], $_POST['new_password'], $_POST['confirm_password'], $_POST['role'])) {
    // Assigning variables from request
    $old_password = $_POST['old_password'];
    $new_password = $_POST['new_password'];
    $confirm_password = $_POST['confirm_password'];
    $role = $_POST['role'];

    // Checking if new password and confirm password match
    if ($new_password !== $confirm_password) {
        echo json_encode(array(
            "success" => false,
            "message" => "New password and confirm password do not match"
        ));
        die(); // Stopping execution if mismatch is found
    }

    $sql = ''; // Initializing SQL query

    // Handling password change for user role
    if ($role == 'user') {
        // Fetching current hashed password from database
        $sql = "SELECT password FROM users WHERE user_id = $userId";
        $result = mysqli_query($connect, $sql);

        // Checking if query was successful
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to fetch users data",

            ));
            die();
        }

        // Getting the user data from the result
        $user = mysqli_fetch_assoc($result);
        $hashed_password = $user['password'];

        // Verifying old password with hashed password
        $is_correct = password_verify($old_password, $hashed_password);

        // Checking if current password is incorrect
        if (!$is_correct) {
            echo json_encode(array(
                "success" => false,
                "message" => "Current password is incorrect"
            ));
            die();
        }

        // Preventing user from reusing the current password
        if (password_verify($new_password, $hashed_password)) {
            echo json_encode(array(
                "success" => false,
                "message" => "You cannot use your current password as the new password"
            ));
            die();
        }

        // Hashing the new password before updating
        $hashed_new_password = password_hash($new_password, PASSWORD_DEFAULT);

        // Updating the user's password in the database
        $sql = "UPDATE users SET password = '$hashed_new_password' WHERE user_id = $userId";
        $result = mysqli_query($connect, $sql);

        // Checking if update was successful
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to update password",

            ));
            die();
        }

        // Sending success response for password change
        echo json_encode(array(
            "success" => true,
            "message" => "Password changed successfully"
        ));

        // Handling password change for operator role
    } else if ($role == 'operator') {
        // Fetching current password hash from car_operators table
        $sql = "SELECT password FROM car_operators WHERE operator_id = $operatorId";
        $result = mysqli_query($connect, $sql);

        // Checking if query was successful
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to fetch users data",

            ));
            die();
        }

        // Getting the operator data
        $user = mysqli_fetch_assoc($result);
        $hashed_password = $user['password'];

        // Verifying old password
        $is_correct = password_verify($old_password, $hashed_password);

        // Rejecting if old password is wrong
        if (!$is_correct) {
            echo json_encode(array(
                "success" => false,
                "message" => "Current password is incorrect"
            ));
            die();
        }

        // Checking if new password is same as current
        if (password_verify($new_password, $hashed_password)) {
            echo json_encode(array(
                "success" => false,
                "message" => "You cannot use your current password as the new password"
            ));
            die();
        }

        // Hashing the new password before storing it in the database
        $hashed_new_password = password_hash($new_password, PASSWORD_DEFAULT);

        // Updating the operator's password with the newly hashed password
        $sql = "UPDATE car_operators SET password = '$hashed_new_password' WHERE operator_id = $operatorId";
        $result = mysqli_query($connect, $sql);

        // Sending response based on whether the password update was successful
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to update password",

            ));
            die();
        }

        // Returning success message if password was updated properly
        echo json_encode(array(
            "success" => true,
            "message" => "Password changed successfully"
        ));

        // Handling password change for driver role
    } else if ($role == 'driver') {
        // Selecting current password hash for the driver using the driver ID
        $sql = "SELECT password FROM drivers WHERE driver_id = $driverId";
        $result = mysqli_query($connect, $sql);

        // Checking if the query was successful, otherwise returning an error
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to fetch users data",

            ));
            die();
        }

        // Fetching the driver's password hash from the database result
        $user = mysqli_fetch_assoc($result);
        $hashed_password = $user['password'];

        // Verifying if the old password matches the stored hashed password
        $is_correct = password_verify($old_password, $hashed_password);


        // Rejecting the request if the old password is incorrect
        if (!$is_correct) {
            echo json_encode(array(
                "success" => false,
                "message" => "Current password is incorrect"
            ));
            die();
        }

        // Checking if the new password is the same as the old one
        // Preventing the user from setting the same password
        if (password_verify($new_password, $hashed_password)) {
            echo json_encode(array(
                "success" => false,
                "message" => "You cannot use your current password as the new password"
            ));
            die();
        }

        // Hashing the new password to store it securely
        $hashed_new_password = password_hash($new_password, PASSWORD_DEFAULT);

        // Updating the driver's password in the database with the newly hashed password
        $sql = "UPDATE drivers SET password = '$hashed_new_password' WHERE driver_id = $driverId";
        $result = mysqli_query($connect, $sql);

        // Checking if the password update was successful
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to update password",

            ));
            die();
        }

        // Returning a success message if the password was updated correctly
        echo json_encode(array(
            "success" => true,
            "message" => "Password changed successfully"
        ));
        // Handling password change for admin role
    } else if ($role == 'admin') {

        // Selecting current password hash for the admin using the admin ID
        $sql = "SELECT password FROM admins WHERE admin_id = $adminId";
        $result = mysqli_query($connect, $sql);

        // Checking if the query was successful, otherwise returning an error
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to fetch users data",

            ));
            die();
        }

        // Fetching the admin's password hash from the database result
        $user = mysqli_fetch_assoc($result);
        $hashed_password = $user['password'];

        // Verifying if the old password matches the stored hashed password
        $is_correct = password_verify($old_password, $hashed_password);

        // Rejecting the request if the old password is incorrect
        if (!$is_correct) {
            echo json_encode(array(
                "success" => false,
                "message" => "Current password is incorrect"
            ));
            die();
        }

        // Checking if the new password is the same as the old one
        // Preventing the user from setting the same password
        if (password_verify($new_password, $hashed_password)) {
            echo json_encode(array(
                "success" => false,
                "message" => "You cannot use your current password as the new password"
            ));
            die();
        }

        // Hashing the new password to store it securely
        $hashed_new_password = password_hash($new_password, PASSWORD_DEFAULT);

        // Updating the admin's password in the database with the newly hashed password
        $sql = "UPDATE admins SET password = '$hashed_new_password' WHERE admin_id = $adminId";
        $result = mysqli_query($connect, $sql);

        // Checking if the password update was successful
        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to update password",

            ));
            die();
        }

        // Returning a success message if the password was updated correctly
        echo json_encode(array(
            "success" => true,
            "message" => "Password changed successfully"
        ));
    } else {
        // Returning an error message if the role is invalid
        echo json_encode(array(
            "success" => false,
            "message" => "Invalid role"
        ));
        die(); // Exit the script
    }
} else {
    // Returning an error message if the required fields are missing
    echo json_encode(array(
        "success" => false,
        "message" => "Current password, new password and confirm password are required"
    ));
    die();
}
