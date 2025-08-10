<?php
require_once dirname(__FILE__, 3) . '/api_utils/statusEnums.php';

function updateUserPermissions(PDO $pdo, string $taxNumber, $userPermissions): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $deleteOldPermissionsQuery = 'DELETE
      FROM wp_user_permissions
      WHERE user_tax_number = :utn';
    $deleteOldPermissionsStmt = $pdo->prepare($deleteOldPermissionsQuery);
    $deleteOldPermissionsStmt->execute(array( ':utn' => $taxNumber ));

    $rowsToInsert = array();
    foreach ($userPermissions as $permissionEnumValue) {
      $permissionEnumValue = htmlspecialchars($permissionEnumValue, ENT_COMPAT | ENT_HTML401, 'UTF-8');
      $row = array(
        ':utn' => $taxNumber,
        ':pm' => mapUserPermissionToDb($permissionEnumValue),
      );
      $rowsToInsert[] = $row;
    }

    $insertNewPermissionsQuery = 'INSERT
      INTO wp_user_permissions (user_tax_number, user_permission)
      VALUES (:utn, :pm)';
    $insertNewPermissionsStmt = $pdo->prepare($insertNewPermissionsQuery);

    foreach ($rowsToInsert as $row) {
      $insertNewPermissionsStmt->execute($row);
    }

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Permissions of User successfully updated',
        'user_permissions' => $userPermissions,
      )
    );
  } catch (PDOException $e) {
    return json_encode(
      array(
        'outcome' => 'failure',
        'message' => $e->getMessage(),
      )
    );
  }
}
