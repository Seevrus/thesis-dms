<?php
require_once dirname(__FILE__) . '/checkCsrfToken.php';
require_once dirname(__FILE__) . '/isLoggedin.php';

function protections(bool $csrf, bool $login, bool $permissions, $permissionRequirement) {
  if (
    ($csrf && !checkCsrfToken())
    || ($login && !isLoggedin())
    || ($permissions 
        && !in_array($permissionRequirement, $_SESSION['userPermissions']))
  ) {
    return json_encode(
      array(
        'outcome' => 'failure',
        'message' => 'You do not have permission to access this page!',
      )
    );
  }

  return false;
}
?>
