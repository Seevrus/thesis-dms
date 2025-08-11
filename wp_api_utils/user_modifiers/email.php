<?php
require_once dirname(__FILE__, 2) . '/emailer.php';
require_once dirname(__FILE__, 3) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 3) . '/wp_db/update/updateEmail.php';

if ($_SESSION['taxNumber'] != $requestData->taxNumber) {
  $protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);

  // Modify email and skip email validation phase
  if ($protectionProblem) {
    $emailModifyResult = array(
      'value' => 'userEmail',
      'outcome' => 'failure',
      'message' => 'You do not have permission to modify this value',
    );
  } else {
    $updateEmailJson = updateEmail(
      $pdo, $requestData->taxNumber, $requestData->userEmail, true
    );
    $updateEmail = json_decode($updateEmailJson);
    if ($updateEmail->outcome == 'failure') {
      $emailModifyResult = array(
        'value' => 'userEmail',
        'outcome' => 'failure',
        'message' => $updateEmail->message,
      );
    } else {
      $emailModifyResult = array(
        'value' => 'userEmail',
        'outcome' => 'success',
        'message' => $updateEmail->message,
        'userEmail' => $updateEmail->user_email,
        'ownEmail' => $requestData->ownEmail,
      );
    }
  }
} else {
  $protectionProblem = protections(false, false, true, USER_PERMISSIONS::REGULAR);

  // Modify email and request email validation
  if ($protectionProblem) {
    $emailModifyResult = array(
      'value' => 'userEmail',
      'outcome' => 'failure',
      'message' => 'You do not have permission to modify this value',
    );
  } else {
    $updateEmailJson = updateEmail(
      $pdo, $_SESSION['taxNumber'], $requestData->userEmail, false
    );
    $updateEmail = json_decode($updateEmailJson);
    if ($updateEmail->outcome == 'failure') {
      $emailModifyResult = array(
        'value' => 'userEmail',
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
  
      emailer($requestData->userEmail, "Dokumentumkezelő regisztráció", $message);

      // Update email status
      $emailStatus = mapDbEmailStatus($updateEmail->email_status);
      $_SESSION['emailStatus'] = $emailStatus;
      $_SESSION['userEmail'] = $updateEmail->user_email;

      $emailModifyResult = array(
        'value' => 'userEmail',
        'outcome' => 'success',
        'message' => $updateEmail->message,
        'emailStatus' => $emailStatus,
        'userEmail' => $updateEmail->user_email,
        'ownEmail' => $requestData->ownEmail,
      );
    }
  }
}
