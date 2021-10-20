<?php
require_once dirname(dirname(__FILE__)) . '/emailer.php';
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updateEmail.php';

if ($_SESSION['taxNumber'] != $requestData->taxNumber) {
  $protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);

  // Modify email and skip email validation phase
  if ($protectionProblem) {
    $emailModifyResult = array(
      'value' => 'email',
      'outcome' => 'failure',
      'message' => 'You do not have permission to modify this value',
    );
  } else {
    $updateEmailJson = updateEmail($pdo, $requestData->taxNumber, $requestData->email, true);
    $updateEmail = json_decode($updateEmailJson);
    if ($updateEmail->outcome == 'failure') {
      $emailModifyResult = array(
        'value' => 'email',
        'outcome' => 'failure',
        'message' => $updateEmail->message,
      );
    } else {
      $emailModifyResult = array(
        'value' => 'email',
        'outcome' => 'success',
        'message' => $updateEmail->message,
      );
    }
  }
} else {
  $protectionProblem = protections(false, false, true, USER_PERMISSIONS::REGULAR);

  // Modify email and request email validation
  if ($protectionProblem) {
    $emailModifyResult = array(
      'value' => 'email',
      'outcome' => 'failure',
      'message' => 'You do not have permission to modify this value',
    );
  } else {
    $updateEmailJson = updateEmail($pdo, $_SESSION['taxNumber'], $requestData->email, false);
    $updateEmail = json_decode($updateEmailJson);
    if ($updateEmail->outcome == 'failure') {
      $emailModifyResult = array(
        'value' => 'email',
        'outcome' => 'failure',
        'message' => $updateEmail->message,
      );
    } else {
      $emailCode = $updateEmail->email_code;

      $newLine = "\r\n";
      $message = "";
      $message .= "Tisztelt Felhasználónk!" . $newLine . $newLine;
      $message .= "Ezt az e-mailt azért küldjük, mert ezzel az e-mail címmel regisztráltak a Thesis-DMS dokumentumkezelő rendszerbe. Amennyiben Ön indította el a folyamatot, kérem, hogy bejelentkezés után a megjelenő űrlapon írja be az alábbi kódot:" . $newLine;
      $message .= "$emailCode" . $newLine;
      $message .= "Amennyiben nem Ön indította el a folyamatot, kérem, szíveskedjen a hibát válaszüzenetben jelezni számunkra." . $newLine . $newLine;
      $message .= "Tisztelettel," . $newLine;
      $message .= "Dr. Till Zoltán" . $newLine;
  
      emailer($requestData->email, "Dokumentumkezelő regisztráció", $message);

      // Update email status
      $emailStatus = mapDbEmailStatus($updateEmail->email_status);
      $_SESSION['emailStatus'] = $emailStatus;

      $emailModifyResult = array(
        'value' => 'email',
        'outcome' => 'success',
        'message' => $updateEmail->message,
        'emailStatus' => $emailStatus,
      );
    }
  }
}
?>
