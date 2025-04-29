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
$operatorId = getOperatorId($token);
$adminId = getAdminId($token);

if (!$userId && !$operatorId && !$adminId) {
    echo json_encode(array(
        "success" => false,
        "message" => "Invalid token"
    ));
    die();
}

if (isset($_POST['role'])) {

    $role = $_POST['role'];

    $query = '';

    if ($role == 'user') {

        $query = "SELECT tour_packages.*, 
                 cars.name, cars.image_url AS car_image_url, 
                 cars.license_plate, cars.fuel_type, 
                 cars.luggage_capacity, cars.rating, 
                 categories.category_id, categories.category_name,  
                 car_operators.operator_name, car_operators.email, 
                 car_operators.phone_number AS operator_phone_number,
                 drivers.driver_id, drivers.driver_name, drivers.phone_number AS driver_phone_number

          FROM tour_packages
          JOIN cars ON tour_packages.car_id = cars.car_id
          JOIN categories ON cars.category_id = categories.category_id
          JOIN car_operators ON cars.operator_id = car_operators.operator_id
          JOIN drivers ON tour_packages.driver_id = drivers.driver_id
          WHERE tour_packages.start_date >= CURDATE();";
    } else if ($role == 'operator') {

        $query = "SELECT tour_packages.*, 
            cars.name, cars.image_url AS car_image_url, 
            cars.license_plate, cars.fuel_type, 
            cars.luggage_capacity, cars.rating, 
            categories.category_id, categories.category_name,  
            car_operators.operator_name, car_operators.email, 
            car_operators.phone_number AS operator_phone_number,
            drivers.driver_id, drivers.driver_name, drivers.phone_number AS driver_phone_number
     FROM tour_packages
     JOIN cars ON tour_packages.car_id = cars.car_id
     JOIN categories ON cars.category_id = categories.category_id
     JOIN car_operators ON cars.operator_id = car_operators.operator_id
     JOIN drivers ON tour_packages.driver_id = drivers.driver_id
     WHERE tour_packages.operator_id = '$operatorId' ORDER BY tour_packages.added_date DESC;";
    } else if ($role == 'admin') {

        $query = "SELECT tour_packages.*, 
            cars.name, cars.image_url AS car_image_url, 
            cars.license_plate, cars.fuel_type, 
            cars.luggage_capacity, cars.rating, 
            categories.category_id, categories.category_name,  
            car_operators.operator_name, car_operators.email, 
            car_operators.phone_number AS operator_phone_number,
            drivers.driver_id, drivers.driver_name, drivers.phone_number AS driver_phone_number
     FROM tour_packages
     JOIN cars ON tour_packages.car_id = cars.car_id
     JOIN categories ON cars.category_id = categories.category_id
     JOIN car_operators ON cars.operator_id = car_operators.operator_id
     JOIN drivers ON tour_packages.driver_id = drivers.driver_id
     
     ORDER BY tour_packages.added_date DESC;";
    }

    $result = $connect->query($query);

    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Database query failed: " . $connect->error
        ));
        die();
    }

    if ($result->num_rows > 0) {
        // Fetch the result as an associative array
        $AvailableTourPackages = array();
        while ($row = $result->fetch_assoc()) {
            $AvailableTourPackages[] = $row;
        }

        // Send the JSON response
        echo json_encode(array(
            "success" => true,
            "message" => "Available tour packages fetched successfully",
            "AvailableTourPackages" => $AvailableTourPackages
        ));
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Tour packages not available"  // ✅ Fixed message
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Role is required"
    ));
    die();
}





// Close the database connection
$connect->close();
