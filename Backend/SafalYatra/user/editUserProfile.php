<?php
include "../config/connection.php";
include "../utils/authHelper.php";


if (!isset($_POST['token'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required"
    ));
    die();
}

$token = $_POST['token']; // Storing the token from POST request

$userId = getUserId($token);

if (!$userId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}


if (isset($_POST['full_name'], $_POST['contact'], $_POST['address'])) {

    $full_name = $_POST['full_name'];
    $contact = $_POST['contact'];
    $address = $_POST['address'];
    $imageUrl = null;

    if (isset($_FILES['image'])) {

        $image = $_FILES['image'];

        $image_size = $image['size'];

        if ($image_size > 5 * 1024 * 1024) {
            echo json_encode(array(
                "success" => false,
                "message" => "Image size should be less than 5 MB"
            ));
            die();
        }

        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        $allowed = ["jpg", "jpeg", "png", "webp"];

        if (!in_array($ext, $allowed)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid image format"
            ));
        }

        // $new_name = uniqid() . "." . $ext;
        // $temp_location = $image['tmp_name']; // Temporary location of the uploaded image
        // $new_location = "../images/" . $new_name; // New location for saving the image
        // $image_url = "images/" . $new_name; // URL to access the image

        // Assuming you already have role and id from token
        $role = 'user'; // Since this is a driver profile update
        $id = $userId;

        // Get file extension
        $ext = pathinfo($image['name'], PATHINFO_EXTENSION);

        // Create unique file name: role_id_timestamp.ext
        $new_name = $role . "_" . $id . "_" . time() . "." . $ext;

        // Temporary and final locations
        $temp_location = $image['tmp_name']; // Temporary location of the uploaded image
        $new_location = "../images/" . $new_name; // New location for saving the image
        $image_url = "images/" . $new_name; // URL to access the image in flutter


        if (!move_uploaded_file($temp_location, $new_location)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to upload image"
            ));
        }

        $imageUrl = $image_url;
    }

    $sql = '';

    if ($imageUrl == null) {
        $sql = "UPDATE users SET full_name = '$full_name', phone_number = '$contact', address = '$address' WHERE user_id = $userId";
    } else {
        $sql = "UPDATE users SET full_name = '$full_name', image_url='$imageUrl', phone_number = '$contact', address = '$address' WHERE user_id = $userId";
    }

    $result = mysqli_query($connect, $sql);


    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Profile updated successfully"
        ));

        die();
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Profile updated failed"
        ));

        die();
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "full_name,contact and address is required",
    ));
    die();
}
