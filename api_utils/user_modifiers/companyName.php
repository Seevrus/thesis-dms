<?php
require_once dirname(dirname(dirname(__FILE__))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(__FILE__))) . '/db/update/updateCompany.php';

$protectionProblem = protections(false, false, true, USER_PERMISSIONS::USER_ADMINISTRATOR);
if ($protectionProblem) {
  $companyModifyResult = array(
    'value' => 'companyName',
    'outcome' => 'failure',
    'message' => 'You do not have permission to modify this value',
  );
} else {
  $updateCompanyJson = updateCompany($pdo, $requestData->taxNumber, $requestData->companyName);
  $updateCompany = json_decode($updateCompanyJson);
  if ($updateCompany->outcome == 'failure') {
    $companyModifyResult = array(
      'value' => 'companyName',
      'outcome' => 'failure',
      'message' => $updateCompany->message,
    );
  } else {
    $companyModifyResult = array(
      'value' => 'companyName',
      'outcome' => 'success',
      'message' => $updateCompany->message,
    );
  }
}
?>
