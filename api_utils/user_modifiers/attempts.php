<?php
require_once dirname(__FILE__, 3) . '/auth_utils/protections.php';
require_once dirname(__FILE__, 3) . '/db/update/updateAttempts.php';

$protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);
if ($protectionProblem) {
  $attemptsModifyResult = array(
    'value' => 'attempts',
    'outcome' => 'failure',
    'message' => 'You do not have permission to modify this value',
  );
} else {
  $updateAttemptsJson = updateAttempts($pdo, $requestData->taxNumber);
  $updateAttempts = json_decode($updateAttemptsJson);
  if ($updateAttempts->outcome == 'failure') {
    $attemptsModifyResult = array(
      'value' => 'attempts',
      'outcome' => 'failure',
      'message' => $updateAttempts->message,
    );
  } else {
    $attemptsModifyResult = array(
      'value' => 'attempts',
      'outcome' => 'success',
      'message' => $updateAttempts->message,
    );
  }
}
