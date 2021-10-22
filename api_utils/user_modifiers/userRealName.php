<?php
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updateUserRealName.php';

$protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);
if ($protectionProblem) {
  $userRealNameModifyResult = array(
    'value' => 'userRealName',
    'outcome' => 'failure',
    'message' => 'You do not have permission to modify this value',
  );
} else {
  $updateUserRealNameJson = updateUserRealName($pdo, $requestData->taxNumber, $requestData->userRealName);
  $updateUserRealName = json_decode($updateUserRealNameJson);
  if ($updateUserRealName->outcome == 'failure') {
    $userRealNameModifyResult = array(
      'value' => 'userRealName',
      'outcome' => 'failure',
      'message' => $updateUserRealName->message,
    );
  } else {
    $userRealNameModifyResult = array(
      'value' => 'userRealName',
      'outcome' => 'success',
      'message' => $updateUserRealName->message,
      'userRealName' => $updateUserRealName->user_real_name,
    );
  }
}
?>
