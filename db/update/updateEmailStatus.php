<?php
require_once dirname(__FILE__, 3) . '/api_utils/statusEnums.php';

function updateEmailStatus(PDO $pdo, string $taxNumber, string $emailStatus): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $emailStatus = htmlspecialchars($emailStatus, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $updateEmailStatusQuery = 'UPDATE wp_user SET email_status = :st WHERE user_tax_number = :utn';
    $updateEmailStatusStmt = $pdo->prepare($updateEmailStatusQuery);
    $updateEmailStatusStmt->execute(
      array(
        ':st' => mapEmailStatusToDb($emailStatus),
        ':utn' => $taxNumber,
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Email Status of User successfully updated',
        'email_status' => $emailStatus,
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
