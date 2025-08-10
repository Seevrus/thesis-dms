<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
require_once dirname(__FILE__, 2) . '/vendor/autoload.php';

function emailer(string $recipient, string $subject, string $message) : string {
  $credentials = parse_ini_file('../../../email.ini');

  $mail = new PHPMailer();
  $mail->isSMTP();
  $mail->SMTPDebug = SMTP::DEBUG_OFF;
  $mail->Host = 'smtp.gmail.com';
  $mail->Port = 587;
  $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
  $mail->SMTPAuth = true;
  $mail->Username = $credentials['username'];
  $mail->Password = $credentials['password'];
  $mail->CharSet = 'UTF-8';
  $mail->setFrom($credentials['from_email'], $credentials['from_name']);
  $mail->addAddress($recipient);
  $mail->Subject = $subject;
  $mail->Body = $message;

  if (!$mail->send()) {
    return 'Mailer Error: ' . $mail->ErrorInfo;
  } else {
    return 'Message sent!';
  }
}
