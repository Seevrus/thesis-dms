<?php
require_once dirname(dirname(__FILE__)) . '/emailer.php';
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updateEmail.php';

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
      $message .= "Tisztelt Felhaszn??l??nk!" . $newLine . $newLine;
      $message .= "Ezt az e-mailt az??rt k??ldj??k, mert ezzel az e-mail c??mmel regisztr??ltak a Thesis-DMS dokumentumkezel?? rendszerbe. Amennyiben ??n ind??totta el a folyamatot, k??rem, hogy bejelentkez??s ut??n a megjelen?? ??rlapon ??rja be az al??bbi k??dot:" . $newLine;
      $message .= "$emailCode" . $newLine;
      $message .= "Amennyiben nem ??n ind??totta el a folyamatot, k??rem, sz??veskedjen a hib??t v??lasz??zenetben jelezni sz??munkra." . $newLine . $newLine;
      $message .= "Tisztelettel," . $newLine;
      $message .= "Dr. Till Zolt??n" . $newLine;
  
      emailer($requestData->userEmail, "Dokumentumkezel?? regisztr??ci??", $message);

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
?>
