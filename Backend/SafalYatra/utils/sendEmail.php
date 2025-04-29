<?php
require_once '../vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;

// Function to send a verification email
function sendVerificationEmail($email, $otp, $activation_code)
{
    // Creating an instance of PHPMailer
    $mail = new PHPMailer();
    $to = $email;
    $subject = 'Verification code to verify your email address';

    // Configuring PHPMailer to use SMTP
    $mail->IsSMTP();  // Enable SMTP
    $mail->SMTPAuth = true;  // Enable SMTP authentication
    $mail->SMTPSecure = 'tls'; // Set encryption system (TLS)
    $mail->Host = "smtp.gmail.com";
    $mail->Port = 587;
    $mail->IsHTML(true);
    $mail->CharSet = 'UTF-8';
    //$mail->SMTPDebug = 2; 
    $mail->Username = "magarsafal61@gmail.com";
    $mail->Password = "plij aorw avui paad";

    $mail->SetFrom("magarsafal61@gmail.com", "Safal Yatra");
    $mail->Subject = 'Verification Code - Safal Yatra';



    // Creating the email body with the OTP
    $message_body = '<p>For verify your email address, enter this verification code when prompted: <b>' . $otp . '</b>.</p>
    <p>Sincerely,</p>';
    $mail->Body = $message_body;
    $mail->AddAddress($to);
    $mail->SMTPOptions = array('ssl' => array(
        'verify_peer' => false,
        'verify_peer_name' => false,
        'allow_self_signed' => false
    ));
    if ($mail->Send()) {
        return true;
    } else {
        return $mail->ErrorInfo;
    }
}
