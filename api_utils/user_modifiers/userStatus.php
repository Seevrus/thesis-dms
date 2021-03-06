<?php
require_once dirname(dirname(__FILE__)) . '/emailer.php';
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updateUserStatus.php';

$protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);

if ($protectionProblem) {
  $userStatusModifyResult = array(
    'value' => 'userStatus',
    'outcome' => 'failure',
    'message' => 'You do not have permission to modify this value',
  );
} else {
  $updateUserStatusJson = updateUserStatus(
    $pdo, $requestData->taxNumber, $requestData->userStatus
  );
  $updateUserStatusResult = json_decode($updateUserStatusJson);
  if ($updateUserStatusResult->outcome == 'failure') {
    $userStatusModifyResult = array(
      'value' => 'userStatus',
      'outcome' => 'failure',
      'message' => $updateUserStatusResult->message,
    );
  } else {
    $userStatusModifyResult = array(
      'value' => 'userStatus',
      'outcome' => 'success',
      'message' => $updateUserStatusResult->message,
      'userStatus' => $updateUserStatusResult->user_status,
    );
  }
}
?>
