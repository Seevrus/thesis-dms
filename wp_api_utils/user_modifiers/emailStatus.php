<?php
require_once dirname(__FILE__, 2) . '/emailer.php';
require_once dirname(__FILE__, 3) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 3) . '/wp_db/update/updateEmailStatus.php';

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
