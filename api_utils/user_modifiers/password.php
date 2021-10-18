<?php
require_once dirname(dirname(__FILE__)) . '/emailer.php';
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updatePassword.php';

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
  $passwordHash = password_hash($requestData->password, PASSWORD_DEFAULT);
  $updatePasswordJson = updatePassword($pdo, $taxNumber, $passwordHash);
  $updatePassword = json_decode($updatePasswordJson);
  if ($updatePassword->outcome == 'failure') {
    $passwordModifyResult = array(
      'value' => 'password',
      'outcome' => 'failure',
      'message' => $updatePassword->message,
    );
  } else {
    // $newLine = "\r\n";
    // $message = "";
    // $message .= "Tisztelt Felhasználónk!" . $newLine . $newLine;
    // $message .= "Ezt az e-mailt azért küldjük, mert észleltük, hogy az Ön jelszava módosításra került a rendszerünkben." . $newLine;
    // $message .= "Amennyiben nem Ön indította el a folyamatot, kérem, azonnal jelezze számunkra a hibát!" . $newLine . $newLine;
    // $message .= "Tisztelettel," . $newLine;
    // $message .= "Dr. Till Zoltán" . $newLine;
  
    // emailer($updatePassword->userEmail, "Jelszava módosult (Thesis-DMS)", $message);
  
    $passwordModifyResult = array(
      'value' => 'password',
      'outcome' => 'success',
      'message' => $updatePassword->message,
    );
  }
}
?>
