<?php
function updatePassword(PDO $pdo, string $taxNumber, string $passwordHash): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $updatePasswordQuery = 'UPDATE
        user
      SET
        user_password = :pw,
        user_login_attempt = 0
      WHERE
        user_tax_number = :utn';
    $updatePasswordStmt = $pdo->prepare($updatePasswordQuery);
    $updatePasswordStmt->execute(
      array(
        ':pw' => $passwordHash,
        ':utn' => $taxNumber,
      )
    );

    // we also need the email of the user to send feedback
    $selectEmailQuery = 'SELECT user_email FROM user WHERE user_tax_number = :utn';
    $selectEmailStmt = $pdo->prepare($selectEmailQuery);
    $selectEmailStmt->execute(array( ':utn' => $taxNumber ));
    $emailRow = $selectEmailStmt->fetch(PDO::FETCH_ASSOC);

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Password successfully updated',
        'userEmail' => $emailRow['user_email'],
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
?>
