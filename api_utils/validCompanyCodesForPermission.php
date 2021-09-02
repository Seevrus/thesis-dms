<?php
function validCompanyCodesForPermission($userPermissions, string $permission)
{
  $validCompanyCodes = array();
  foreach ($userPermissions as $companyCode => $userPermissionsForCompany) {
      if (in_array($permission, $userPermissionsForCompany)) {
          array_push($validCompanyCodes, $companyCode);
      }
  }

  return $validCompanyCodes;
}
?>
