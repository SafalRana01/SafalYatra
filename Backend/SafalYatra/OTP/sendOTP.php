<?php
include "../config/connection.php";
require_once '../vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;

if (isset($_POST['email'], $_POST['role'])) {
    $email = $_POST['email'];
    $role = $_POST['role'];


    $sql = "";

    if ($role == 'user') {
        $sql = "SELECT * FROM users where email = '$email' AND status = 'active'";
        $result = mysqli_query($connect, $sql);
        if (mysqli_num_rows($result) == 0) {
            echo json_encode(array(
                "success" => false,
                "message" => "Email does not exists"
            ));
            die();
        }

        $user = mysqli_fetch_assoc($result);
        $user_id = $user['user_id'];
        $fullName = $user['full_name'];
        $otp = rand(111111, 999999);

        $sql = "UPDATE users SET otp = $otp WHERE user_id = $user_id";
        $result = mysqli_query($connect, $sql);

        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send code"
            ));
            die();
        }

        $mail = new PHPMailer();
        $to = $email;
        $subject = 'Verification code to verify your email address';
        $mail->IsSMTP();
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = 'tls';
        $mail->Host = "smtp.gmail.com";
        $mail->Port = 587;
        $mail->IsHTML(true);
        $mail->CharSet = 'UTF-8';
        //$mail->SMTPDebug = 2; 
        $mail->Username = "magarsafal61@gmail.com";
        $mail->Password = "plij aorw avui paad";
        $mail->SetFrom("magarsafal61@gmail.com", "Safal Yatra");
        $mail->Subject = 'Password Reset - Safal Yatra';


        $message_body = '<p>For reset your password, enter this verification code when prompted: <b>' . $otp . '</b>.</p>
   <p>Sincerely,</p>';
        $mail->Body = $message_body;
        $mail->AddAddress($to);
        $mail->SMTPOptions = array('ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => false
        ));
        if (!$mail->send()) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send OTP. $mail->ErrorInfo"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP sent to $email",
                "email" => $email,
                "role" => "user",
            ));
        }
    } else if ($role == 'operator') {
        $sql = "SELECT * FROM car_operators where email = '$email' AND status = 'Verified'";
        $result = mysqli_query($connect, $sql);
        if (mysqli_num_rows($result) == 0) {
            echo json_encode(array(
                "success" => false,
                "message" => "Email does not exists"
            ));
            die();
        }
        $user = mysqli_fetch_assoc($result);
        $operator_id = $user['operator_id'];
        $fullName = $user['operator_name'];
        $otp = rand(111111, 999999);

        $sql = "UPDATE car_operators SET otp = $otp WHERE operator_id = $operator_id";
        $result = mysqli_query($connect, $sql);

        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send code"
            ));
            die();
        }

        $mail = new PHPMailer();
        $to = $email;
        $subject = 'Verification code to verify your email address';
        $mail->IsSMTP();
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = 'tls';
        $mail->Host = "smtp.gmail.com";
        $mail->Port = 587;
        $mail->IsHTML(true);
        $mail->CharSet = 'UTF-8';
        //$mail->SMTPDebug = 2; 
        $mail->Username = "magarsafal61@gmail.com";
        $mail->Password = "plij aorw avui paad";
        $mail->SetFrom("magarsafal61@gmail.com", "Safal Yatra");
        $mail->Subject = 'Password Reset - Safal Yatra';

        $message_body = '<p>For reset your password, enter this verification code when prompted: <b>' . $otp . '</b>.</p>
   <p>Sincerely,</p>';
        $mail->Body = $message_body;
        $mail->AddAddress($to);
        $mail->SMTPOptions = array('ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => false
        ));
        if (!$mail->send()) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send OTP. $mail->ErrorInfo"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP sent to $email",
                "email" => $email,
                "role" => "operator",
            ));
        }
    } else if ($role == 'driver') {
        $sql = "SELECT * FROM drivers where email = '$email'";
        $result = mysqli_query($connect, $sql);
        if (mysqli_num_rows($result) == 0) {
            echo json_encode(array(
                "success" => false,
                "message" => "Email does not exists"
            ));
            die();
        }
        $user = mysqli_fetch_assoc($result);
        $driver_id = $user['driver_id'];

        $otp = rand(111111, 999999);

        $sql = "UPDATE drivers SET otp = $otp WHERE driver_id = $driver_id";
        $result = mysqli_query($connect, $sql);

        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send code"
            ));
            die();
        }

        $mail = new PHPMailer();
        $to = $email;
        $subject = 'Verification code to verify your email address';
        $mail->IsSMTP();
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = 'tls';
        $mail->Host = "smtp.gmail.com";
        $mail->Port = 587;
        $mail->IsHTML(true);
        $mail->CharSet = 'UTF-8';
        //$mail->SMTPDebug = 2; 
        $mail->Username = "magarsafal61@gmail.com";
        $mail->Password = "plij aorw avui paad";
        $mail->SetFrom("magarsafal61@gmail.com", "Safal Yatra");
        $mail->Subject = 'Password Reset - Safal Yatra';

        $message_body = '<p>For reset your password, enter this verification code when prompted: <b>' . $otp . '</b>.</p>
    <p>Sincerely,</p>';
        $mail->Body = $message_body;

        // Add the recipient's email address
        $mail->AddAddress($to);
        $mail->SMTPOptions = array('ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => false
        ));
        if (!$mail->send()) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send OTP. $mail->ErrorInfo"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP sent to $email",
                "email" => $email,
                "role" => "driver",
            ));
        }
    } else {
        $sql = "SELECT * FROM admins where email = '$email'";
        $result = mysqli_query($connect, $sql);
        if (mysqli_num_rows($result) == 0) {
            echo json_encode(array(
                "success" => false,
                "message" => "Email does not exists"
            ));
            die();
        }
        $user = mysqli_fetch_assoc($result);
        $admin_id = $user['admin_id'];

        $otp = rand(111111, 999999);

        $sql = "UPDATE admins SET otp = $otp WHERE admin_id = $admin_id";
        $result = mysqli_query($connect, $sql);

        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send code"
            ));
            die();
        }

        $mail = new PHPMailer();
        $to = $email;
        $subject = 'Verification code to verify your email address';
        $mail->IsSMTP();
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = 'tls';
        $mail->Host = "smtp.gmail.com";
        $mail->Port = 587;
        $mail->IsHTML(true);
        $mail->CharSet = 'UTF-8';
        //$mail->SMTPDebug = 2; 
        $mail->Username = "magarsafal61@gmail.com";
        $mail->Password = "plij aorw avui paad";
        $mail->SetFrom("magarsafal61@gmail.com", "Safal Yatra");
        $mail->Subject = 'Password Reset - Safal Yatra';

        $message_body = '<p>For reset your password, enter this verification code when prompted: <b>' . $otp . '</b>.</p>
    <p>Sincerely,</p>';
        $mail->Body = $message_body;

        // Add the recipient's email address
        $mail->AddAddress($to);
        $mail->SMTPOptions = array('ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => false
        ));
        if (!$mail->send()) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send OTP. $mail->ErrorInfo"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => true,
                "message" => "OTP sent to $email",
                "email" => $email,
                "role" => "admin",
            ));
        }
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Email and role are required"
    ));
    die();
}
