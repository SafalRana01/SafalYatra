<?php
include "../config/connection.php";
include "../utils/authHelper.php";
require_once '../vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;

// if (!isset($_POST['token'])) {
//     echo json_encode(array(
//         "success" => false,
//         "message" => "Token is required"
//     ));
//     die();
// }

// $token = $_POST['token'];
// $userId = getUserId($token);

// if (!$userId) {
//     echo json_encode(array(
//         "success" => false,
//         "message" => "Invalid token"
//     ));
//     die();
// }


// if (isset(
//     $_POST['booking_id'],
//     // $_POST['email'],
//     $_POST['other_details'],
//     $_POST['amount'],
//     $_POST['number_of_people'],
//     $_POST['tour_capacity']


// )) {
//     $bookingId = $_POST['booking_id'];
//     // $emailTo = $_POST['email'];
//     $otherDetails = $_POST['other_details'];
//     $amount = $_POST['amount'];
//     // $numberOfPeople = $_POST['number_of_people'];
//     // $availableCapacity = $_POST['available_capacity'];

//     // $availableCapacity = $availableCapacity - $numberOfPeople;


//     $numberOfPeople = (int)$_POST['number_of_people'];
//     $tourCapacity = (int)$_POST['tour_capacity'];

//     $availableCapacity = $tourCapacity - $numberOfPeople;



//     $sql = "SELECT * FROM bookings WHERE booking_id = $bookingId";
//     $result = mysqli_query($connect, $sql);

//     if (mysqli_num_rows($result) == 0) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "Booking not found"
//         ));
//     }

//     $booking = mysqli_fetch_assoc($result);
//     $status = $booking['status'];

//     if ($status != "Pending") {

//         echo json_encode(array(
//             "success" => false,
//             "message" => "Booking is already paid"
//         ));

//         die();
//     }

//     $sql = "INSERT INTO payments (booking_id, other_details, payment_amount, user_id) VALUES ($bookingId, '$otherDetails', $amount, $userId)";
//     $result = mysqli_query($connect, $sql);

//     if (!$result) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "Error saving payment"
//         ));
//         die();
//     }



//     if (!$result) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "Error updating booking status"
//         ));
//         die();
//     }


//     $sql = "update bookings set status = 'Success' where booking_id = '$bookingId'";

//     $result = mysqli_query($connect, $sql);

//     if (!$result) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "Failed to update booking"
//         ));
//         die();
//     }

//     $sql = "update tour_packages set available_capacity = '$availableCapacity' where package_id = '" . $booking['package_id'] . "'";
//     $result = mysqli_query($connect, $sql);

//     if (!$result) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "Failed to update tour package"
//         ));
//         die();
//     }



//     echo json_encode(array(
//         "success" => true,
//         "message" => "Payment saved successfully"
//     ));
// } else {
//     echo json_encode(array(
//         "success" => false,
//         "message" => "booking_id, other_details, amount are required"
//     ));
// }






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

if (isset(
    $_POST['booking_id'],
    $_POST['other_details'],
    $_POST['amount'],
    $_POST['number_of_people']
)) {
    $bookingId = (int)$_POST['booking_id'];
    $otherDetails = $_POST['other_details'];
    $amount = (float)$_POST['amount'];
    $numberOfPeople = (int)$_POST['number_of_people'];

    // 1. Get booking info
    $sql = "SELECT * FROM bookings WHERE booking_id = $bookingId";
    $result = mysqli_query($connect, $sql);

    if (!$result || mysqli_num_rows($result) == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Booking not found"
        ));
        die();
    }

    $booking = mysqli_fetch_assoc($result);
    $status = $booking['status'];
    $packageId = $booking['package_id'];

    if ($status != "Pending") {
        echo json_encode(array(
            "success" => false,
            "message" => "Booking is already paid"
        ));
        die();
    }

    // 2. Get current available capacity
    $capacityQuery = "SELECT available_capacity FROM tour_packages WHERE package_id = $packageId";
    $capacityResult = mysqli_query($connect, $capacityQuery);

    if (!$capacityResult || mysqli_num_rows($capacityResult) == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Tour package not found"
        ));
        die();
    }

    $row = mysqli_fetch_assoc($capacityResult);
    $availableCapacity = (int)$row['available_capacity'];

    // 3. Check if enough seats are available
    if ($availableCapacity < $numberOfPeople) {
        echo json_encode(array(
            "success" => false,
            "message" => "Only $availableCapacity seat(s) available. Please reduce the number of people."
        ));
        die();
    }

    $sql = "SELECT * FROM users WHERE user_id = $userId";
    $result = mysqli_query($connect, $sql);

    if (mysqli_num_rows($result) == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "User not found"
        ));
    }

    $user = mysqli_fetch_assoc($result);
    $emailTo = $user['email'];

    // 4. Insert payment record
    $insertPaymentQuery = "INSERT INTO payments (booking_id, other_details, payment_amount, user_id) VALUES ($bookingId, '$otherDetails', $amount, $userId)";
    $paymentResult = mysqli_query($connect, $insertPaymentQuery);

    if (!$paymentResult) {
        echo json_encode(array(
            "success" => false,
            "message" => "Error saving payment"
        ));
        die();
    }

    // 5. Update booking status
    $updateBookingQuery = "UPDATE bookings SET status = 'Success' WHERE booking_id = $bookingId";
    $bookingUpdateResult = mysqli_query($connect, $updateBookingQuery);

    if (!$bookingUpdateResult) {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to update booking status"
        ));
        die();
    }

    // 6. Update available capacity
    $newAvailableCapacity = $availableCapacity - $numberOfPeople;
    $updateCapacityQuery = "UPDATE tour_packages SET available_capacity = $newAvailableCapacity WHERE package_id = $packageId";
    $capacityUpdateResult = mysqli_query($connect, $updateCapacityQuery);

    if (!$capacityUpdateResult) {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to update tour package capacity"
        ));
        die();
    }

    echo json_encode(array(
        "success" => true,
        "message" => "Payment saved and booking confirmed"
    ));

    $sql = "SELECT 
    b.*, 
    tp.package_name, tp.start_location, tp.destination, tp.price AS price_per_person, tp.start_date AS tour_start_date, tp.end_date AS tour_end_date,
    tp.duration, tp.car_id, tp.driver_id, 
    c.license_plate,
    d.driver_name, d.phone_number AS driver_phone_number,
    co.operator_name, co.phone_number AS operator_phone_number
    FROM bookings b
    JOIN tour_packages tp ON b.package_id = tp.package_id
    JOIN cars c ON tp.car_id = c.car_id
    JOIN drivers d ON tp.driver_id = d.driver_id
    JOIN car_operators co ON c.operator_id = co.operator_id
    WHERE b.booking_id = $bookingId AND b.status = 'Success'";

    $result = mysqli_query($connect, $sql);

    if ($result) {
        $bookingDetails = mysqli_fetch_assoc($result);

        // Format dates and calculate the total days
        $startDate = date('Y-m-d', strtotime($bookingDetails['tour_start_date']));
        $endDate = date('Y-m-d', strtotime($bookingDetails['tour_end_date']));
        $totalDays = abs(ceil((strtotime($endDate) - strtotime($startDate)) / (60 * 60 * 24))) + 1;
        $pricePerPerson = $bookingDetails['price_per_person'];
        $totalPersons = $numberOfPeople;
        $totalAmount = $bookingDetails['total'];

        $mail = new PHPMailer();
        $mail->IsSMTP();
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = 'tls';
        $mail->Host = "smtp.gmail.com";
        $mail->Port = 587;
        $mail->IsHTML(true);
        $mail->CharSet = 'UTF-8';
        $mail->Username = "magarsafal61@gmail.com";
        $mail->Password = "plij aorw avui paad";

        $mail->SetFrom("magarsafal61@gmail.com", "Safal Yatra");
        $mail->Subject = 'Booking Confirmation - Safal Yatra';

        // Constructing the email body in HTML format
        $message_body = '<div style="font-family: Arial, sans-serif; border: 1px solid #ddd; padding: 20px; border-radius: 10px; width: 600px; margin: auto; background-color: #f9f9f9;">';
        $message_body .= '<h2 style="text-align: center; color: #2980b9;">Tour Booking Confirmed!</h2>';
        $message_body .= '<p>Dear Customer,</p>';
        $message_body .= '<p>Your tour booking has been successfully confirmed. Below are the details:</p>';

        $message_body .= '<table style="width: 100%; border-collapse: collapse;">';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Booking ID:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['booking_id'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Tour Name:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['package_name'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Start Location:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['start_location'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Destination:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['destination'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Start Date:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $startDate . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>End Date:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $endDate . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Number of Days:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $totalDays . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Car Number:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['license_plate'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Price Per Person:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">Rs. ' . $pricePerPerson . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Number of Persons:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $totalPersons . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Total Amount:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">Rs. ' . $totalAmount . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Driver Name:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['driver_name'] . ' (' . $bookingDetails['driver_phone_number'] . ')</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Operator:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['operator_name'] . ' (' . $bookingDetails['operator_phone_number'] . ')</td></tr>';
        $message_body .= '</table>';

        $message_body .= '<p style="margin-top: 20px;">For any queries, feel free to contact us.</p>';
        $message_body .= '<p style="color: #27ae60;"><strong>Thank you for choosing Safal Yatra!</strong></p>';
        $message_body .= '</div>';

        $mail->Body = $message_body;
        $mail->AddAddress($emailTo);
        $mail->SMTPOptions = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => false
            )
        );

        $mail->Send();
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "booking_id, other_details, amount are required"
    ));
}

// Close the database connection
mysqli_close($connect);
