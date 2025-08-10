<?php
function updatePassword(PDO $pdo, string $taxNumber, string $password): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $selectUserQuery = 'SELECT
        user_email, email_status, user_password
      FROM wp_user
      WHERE user_tax_number = :utn';
    $selectUserStmt = $pdo->prepare($selectUserQuery);
    $selectUserStmt->execute(array( ':utn' => $taxNumber ));
    $userRow = $selectUserStmt->fetch(PDO::FETCH_ASSOC);

    if (
      $userRow['email_status'] == mapEmailStatusToDb(EMAIL_STATUS::VALID_EMAIL)
      && password_verify($password, $userRow['user_password'])
    ) {
      return json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'New password cannot be the same as the old one',
        )
      );
    }

    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
    $updatePasswordQuery = 'UPDATE
        wp_user
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

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Password successfully updated',
        'userEmail' => $userRow['user_email'],
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
