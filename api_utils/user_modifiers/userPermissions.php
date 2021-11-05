<?php
require_once dirname(dirname(__FILE__)) . '/emailer.php';
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updateUserPermissions.php';

$protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);

if ($protectionProblem) {
  $userPermissionsModifyResult = array(
    'value' => 'userPermissions',
    'outcome' => 'failure',
    'message' => 'You do not have permission to modify this value',
  );
} else {
  $updateUserPermissionsJSON = updateUserPermissions(
    $pdo, $requestData->taxNumber, $requestData->userPermissions
  );
  $updateUserPermissionsResult = json_decode($updateUserPermissionsJSON);
  if ($updateUserPermissionsResult->outcome == 'failure') {
    $userPermissionsModifyResult = array(
      'value' => 'userPermissions',
      'outcome' => 'failure',
      'message' => $updateUserPermissionsResult->message,
    );
  } else {
    $userPermissionsModifyResult = array(
      'value' => 'userPermissions',
      'outcome' => 'success',
      'message' => $updateUserPermissionsResult->message,
      'userPermissions' => $updateUserPermissionsResult->user_permissions,
    );
  }
}
?>
