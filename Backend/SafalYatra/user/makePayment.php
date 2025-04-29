<?php
include "../config/connection.php";
include "../utils/authHelper.php";
require_once '../vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;

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
    // $_POST['email'],
    $_POST['other_details'],
    $_POST['amount'],


)) {
    $bookingId = $_POST['booking_id'];
    $otherDetails = $_POST['other_details'];
    $amount = $_POST['amount'];


    $sql = "SELECT * FROM bookings WHERE booking_id = $bookingId";
    $result = mysqli_query($connect, $sql);

    if (mysqli_num_rows($result) == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Booking not found"
        ));
    }

    $booking = mysqli_fetch_assoc($result);
    $status = $booking['status'];

    if ($status != "Pending") {

        echo json_encode(array(
            "success" => false,
            "message" => "Booking is already paid"
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

    $sql = "INSERT INTO payments (booking_id, other_details, payment_amount, user_id) VALUES ($bookingId, '$otherDetails', $amount, $userId)";
    $result = mysqli_query($connect, $sql);

    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Error saving payment"
        ));
        die();
    }



    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Error updating booking status"
        ));
        die();
    }


    $sql = "update bookings set status = 'Success' where booking_id = '$bookingId'";

    $result = mysqli_query($connect, $sql);

    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to update booking"
        ));
        die();
    }

    echo json_encode(array(
        "success" => true,
        "message" => "Payment saved successfully"
    ));



    $sql = "SELECT 
    b.*,
    c.license_plate, c.name, c.rate_per_hours,
    d.driver_id, d.driver_name, d.phone_number AS driver_phone_number, 
    co.operator_id, co.operator_name, co.phone_number AS operator_phone_number
    FROM bookings b
    JOIN cars c ON b.car_id = c.car_id
    JOIN drivers d ON b.driver_id = d.driver_id
    JOIN car_operators co ON c.operator_id = co.operator_id
    where b.booking_id = $bookingId AND b.status = 'Success'";

    $result = mysqli_query($connect, $sql);

    if ($result) {
        $bookingDetails = mysqli_fetch_assoc($result);

        // Convert start_date and end_date to proper format
        $startDate = date('Y-m-d', strtotime($bookingDetails['start_date']));
        $endDate = date('Y-m-d', strtotime($bookingDetails['end_date']));

        // Calculate total days correctly
        $totalDays = abs(ceil((strtotime($endDate) - strtotime($startDate)) / (60 * 60 * 24))) + 1;

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

        // Email Body with Styling
        $message_body = '<div style="font-family: Arial, sans-serif; border: 1px solid #ddd; padding: 20px; border-radius: 10px; width: 600px; margin: auto; background-color: #f9f9f9;">';
        $message_body .= '<h2 style="text-align: center; color: #27ae60;">Booking Confirmed!</h2>';
        $message_body .= '<p>Dear Customer,</p>';
        $message_body .= '<p>Your booking has been successfully confirmed. Here are your booking details:</p>';
        $message_body .= '<table style="width: 100%; border-collapse: collapse;">';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Booking ID:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['booking_id'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Operator Name:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['operator_name'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Operator Phone Number:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['operator_phone_number'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Car Number:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $bookingDetails['license_plate'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Start Date:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $startDate . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>End Date:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $endDate . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Price Per Day:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">Rs. ' . $bookingDetails['rate_per_hours'] . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Number of Days:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">' . $totalDays . '</td></tr>';
        $message_body .= '<tr><td style="padding: 8px; border-bottom: 1px solid #ddd;"><strong>Total Amount:</strong></td><td style="padding: 8px; border-bottom: 1px solid #ddd;">Rs. ' . $bookingDetails['total'] . '</td></tr>';
        $message_body .= '</table>';

        if (!empty($bookingDetails['driver_name'])) {
            $message_body .= '<h3 style="color: #2c3e50;">Driver Details</h3>';
            $message_body .= '<p><strong>Driver Name:</strong> ' . $bookingDetails['driver_name'] . '</p>';
            $message_body .= '<p><strong>Driver Contact:</strong> ' . $bookingDetails['driver_phone_number'] . '</p>';
        }

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






// include "helper/connection.php";
// include "helper/authHelper.php";

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
//     $_POST['other_details'],
//     $_POST['amount']
// )) {
//     $bookingId = $_POST['booking_id'];
//     $otherDetails = $_POST['other_details'];
//     $amount = $_POST['amount'];

//     $sql = "SELECT * FROM bookings WHERE booking_id = $bookingId";
//     $result = mysqli_query($connect, $sql);

//     if (mysqli_num_rows($result) == 0) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "Booking not found"
//         ));
//         die();
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

//     $sql = "SELECT * FROM users WHERE user_id = $userId";
//     $result = mysqli_query($connect, $sql);

//     if (mysqli_num_rows($result) == 0) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "User not found"
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

//     $sql = "UPDATE bookings SET status = 'Success' WHERE booking_id = '$bookingId'";
//     $result = mysqli_query($connect, $sql);

//     if (!$result) {
//         echo json_encode(array(
//             "success" => false,
//             "message" => "Failed to update booking"
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
