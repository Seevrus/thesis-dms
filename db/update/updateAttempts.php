<?php
function updateAttempts(PDO $pdo, string $taxNumber): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $updateAttemptsQuery = 'UPDATE wp_user SET user_login_attempt = 0 WHERE user_tax_number = :utn';
    $updateAttemptsStmt = $pdo->prepare($updateAttemptsQuery);
    $updateAttemptsStmt->execute(array( ':utn' => $taxNumber ));

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Number of attempts reset',
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
