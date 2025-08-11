<?php
require_once dirname(__FILE__, 2) . '/emailer.php';
require_once dirname(__FILE__, 3) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 3) . '/wp_db/update/updatePassword.php';

if ($_SESSION['taxNumber'] != $requestData->taxNumber) {
  $protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);
  $taxNumber = $requestData->taxNumber; // Modify password of anyone
} else {
  $protectionProblem = protections(false, false, true, USER_PERMISSIONS::REGULAR);
  $taxNumber = $_SESSION['taxNumber']; // Modify password of the current user
}

if ($protectionProblem) {
  $passwordModifyResult = array(
    'value' => 'password',
    'outcome' => 'failure',
    'message' => 'You do not have permission to modify this value',
  );
} else {
  $updatePasswordJson = updatePassword($pdo, $taxNumber, $requestData->password);
  $updatePassword = json_decode($updatePasswordJson);
  if ($updatePassword->outcome == 'failure') {
    $passwordModifyResult = array(
      'value' => 'password',
      'outcome' => 'failure',
      'message' => $updatePassword->message,
    );
  } else {
    $newLine = "\r\n";
    $message = "";
    $message .= "Tisztelt Felhasználónk!" . $newLine . $newLine;
    $message .= "Ezt az e-mailt azért küldjük, mert észleltük, hogy az Ön jelszava módosításra került a rendszerünkben." . $newLine;
    $message .= "Amennyiben nem Ön indította el a folyamatot, kérem, azonnal jelezze számunkra a hibát!" . $newLine . $newLine;
    $message .= "Tisztelettel," . $newLine;
    $message .= "Dr. Till Zoltán" . $newLine;
  
    emailer($updatePassword->userEmail, "Jelszava módosult (Thesis-DMS)", $message);
  
    $passwordModifyResult = array(
      'value' => 'password',
      'outcome' => 'success',
      'message' => $updatePassword->message,
    );
  }
}
