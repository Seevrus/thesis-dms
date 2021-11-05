<?php
require_once dirname(dirname(__FILE__)) . '/emailer.php';
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updateEmailStatus.php';

$protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);

if ($protectionProblem) {
  $emailStatusModifyResult = array(
    'value' => 'emailStatus',
    'outcome' => 'failure',
    'message' => 'You do not have permission to modify this value',
  );
} else {
  $updateEmailStatusJson = updateEmailStatus(
    $pdo, $requestData->taxNumber, $requestData->emailStatus
  );
  $updateEmailStatus = json_decode($updateEmailStatusJson);
  if ($updateEmailStatus->outcome == 'failure') {
    $emailStatusModifyResult = array(
      'value' => 'emailStatus',
      'outcome' => 'failure',
      'message' => $updateEmailStatus->message,
    );
  } else {
    $emailStatusModifyResult = array(
      'value' => 'emailStatus',
      'outcome' => 'success',
      'message' => $updateEmailStatus->message,
      'emailStatus' => $updateEmailStatus->email_status,
    );
  }
}
?>
