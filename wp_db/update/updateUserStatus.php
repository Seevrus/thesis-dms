<?php
require_once dirname(__FILE__, 3) . '/wp_api_utils/statusEnums.php';

function updateUserStatus(PDO $pdo, string $taxNumber, string $userStatus): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $userStatus = htmlspecialchars($userStatus, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $updateUserStatusQuery = 'UPDATE wp_user SET user_status = :st WHERE user_tax_number = :utn';
    $updateUserStatusStmt = $pdo->prepare($updateUserStatusQuery);
    $updateUserStatusStmt->execute(
      array(
        ':st' => mapUserStatusToDb($userStatus),
        ':utn' => $taxNumber,
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Status of User successfully updated',
        'user_status' => $userStatus,
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
