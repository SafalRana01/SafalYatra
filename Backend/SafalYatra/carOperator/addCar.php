<?php
// Including database connection and authentication helper
include "../config/connection.php";
include "../utils/authHelper.php";

// Checking if token is being sent in the request
if (!isset($_POST['token'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die(); // Stopping the script
}

$token = $_POST['token']; // Storing the token from POST request

$operatorId = getOperatorId($token); // Getting the operator ID by decoding the token

// Validating the token by checking if the operator exists
if (!$operatorId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();  // Stopping the script
}

// Verifying operator status by checking if it is 'Verified'
$sql = "SELECT status FROM car_operators WHERE operator_id = $operatorId";
$result = mysqli_query($connect, $sql);

// Checking if the query executed successfully
if ($result) {
    $row = mysqli_fetch_assoc($result); // Fetching the row
    $status = $row['status']; // Storing the status
    // Checking if the status is not 'Verified'
    if ($status != 'Verified') {
        // Returning error if the operator is not verified
        echo json_encode(array(
            "success" => false,
            "message" => "Your account is not verified by the admin!"
        ));
        die();  // Stopping the script
    }
}

// Checking if all required fields are set
if (isset(
    $_POST['license_plate'],
    $_POST['category_id'],
    $_POST['car_name'],
    $_POST['seat_capacity'],
    $_POST['rate_per_hours'],
    $_POST['baggage_capacity'],
    $_POST['door_count'],
    $_POST['fuel_type']

)) {
    // Storing car details from POST request

    $licensePlate = $_POST['license_plate'];
    $categoryId = $_POST['category_id'];
    $carName = $_POST['car_name'];
    $seatCapacity = $_POST['seat_capacity'];
    $ratePerHour = $_POST['rate_per_hours'];
    $baggageCapacity = $_POST['baggage_capacity'];
    $doorCount = $_POST['door_count'];
    $fuelType = $_POST['fuel_type'];

    $imageUrl = null;

    // Handling image upload if image is provided
    if (isset($_FILES['image'])) {

        $image = $_FILES['image']; // Storing image details

        $image_size = $image['size']; // Storing image size

        // Validating image size (5MB)
        if ($image_size > 5 * 1024 * 1024) {
            echo json_encode(array(
                "success" => false,
                "message" => "Image size should be less than 5 MB"
            ));
            die(); // Stopping the script
        }

        // Validating image format
        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        $allowed = ["jpg", "jpeg", "png", "webp"]; // Allowed image formats

        // Checking if image format is allowed
        if (!in_array($ext, $allowed)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid image format"
            ));
        }

        // Generating a unique name for the image
        $role = 'car - carOperator';
        $id = $operatorId; // Operator ID from token

        // Get file extension
        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        // Create unique file name: role_id_timestamp.ext
        $new_name = $role . "_" . $id . "_" . time() . "." . $ext;

        // Temporary and final locations
        $temp_location = $image['tmp_name']; // Temporary location of the uploaded image
        $new_location = "../images/" . $new_name; // New location for saving the image
        $image_url = "images/" . $new_name; // URL to access the image in flutter


        // Moving the uploaded image from the temporary location to the new location
        if (!move_uploaded_file($temp_location, $new_location)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to upload image"
            ));
        }

        $imageUrl = $image_url; // Storing the image URL
    }

    // Query to check if a car with the same license plate already exists
    $sql = "SELECT * FROM cars WHERE license_plate = '$licensePlate'";
    $result = mysqli_query($connect, $sql);

    // Checking if a car with the same license plate already exists
    if ($result->num_rows > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Car already exists."
        ));
        die(); // Stopping the script
    } else {


        // Use prepared statements to prevent SQL injection
        $carQuery = "INSERT INTO cars (license_plate, category_id, name, image_url, seating_capacity, rate_per_hours, operator_id, luggage_capacity, number_of_doors, fuel_type) VALUES ('$licensePlate', '$categoryId', '$carName', '$imageUrl', '$seatCapacity', '$ratePerHour', '$operatorId', '$baggageCapacity', '$doorCount', '$fuelType')";
        $result = mysqli_query($connect, $carQuery);

        // Checking if the query was successful
        if ($result) {
            echo json_encode(array(
                "success" => true,
                "message" => "Car added successfully."
            ));
        } else {
            // Returning error if the query fails
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to add car"
            ));
        }
    }
} else {
    // Returning error if any field is missing
    echo json_encode(array(
        "success" => false,
        "message" => "All fields are required."
    ));
}
