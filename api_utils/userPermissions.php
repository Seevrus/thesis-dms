<?php
require_once dirname(__FILE__) . '/statusEnums.php';

function userHasPermission($userPermissionRows, string $permission)
{
    $dbPermission = mapUserPermissionToDb($permission);
    foreach ($userPermissionRows as $permissionRow) {
        if ($permissionRow['user_permission'] == $dbPermission) return true;
    }

    return false;
}
?>
