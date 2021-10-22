<?php
require_once dirname(dirname(dirname(__FILE__))) . '/api_utils/statusEnums.php';

function updateEmail(PDO $pdo, string $taxNumber, string $email, bool $skipValidation): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $email = htmlspecialchars($email, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    if ($skipValidation) {
      $updateEmailQuery = 'UPDATE user SET user_email = :em, email_status = :st WHERE user_tax_number = :utn';
      $updateEmailStmt = $pdo->prepare($updateEmailQuery);
      $updateEmailStmt->execute(
        array(
          ':em' => $email,
          ':st' => mapEmailStatusToDb(EMAIL_STATUS::VALID_EMAIL),
          ':utn' => $taxNumber,
        )
      );
  
      return json_encode(
        array(
          'outcome' => 'success',
          'message' => 'Email of User successfully updated',
          'user_email' => $email,
        )
      );
    }

    // generate an email code for validation purposes
    $emailCode = rand(100000, 999999);
    $emailCodeHash = password_hash($emailCode, PASSWORD_DEFAULT);

    // TODO: for now, I assume that only a valid request can reach up to this point.
    // It would be nice to double-check this assumption
    $updateEmailQuery = 'UPDATE
        user
      SET
        user_email = :em,
        email_status = :st
      WHERE
        user_tax_number = :utn';
    $updateEmailStmt = $pdo->prepare($updateEmailQuery);
    $updateEmailStmt->execute(
      array(
        ':em' => $email,
        ':st' => mapEmailStatusToDb(EMAIL_STATUS::NOT_VALIDATED),
        ':utn' => $taxNumber,
      )
    );

    $updateEmailCodeQuery = 'INSERT
      INTO user_email_code (
        user_tax_number,
        email_code
      )
      VALUES (
        :utn,
        :ecode
      )';
    $updateEmailCodeStmt = $pdo->prepare($updateEmailCodeQuery);
    $updateEmailCodeStmt->execute(
      array(
        ':utn' => $taxNumber,
        ':ecode' => $emailCodeHash,
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Email successfully updated',
        'user_email' => $email,
        'email_status' => mapEmailStatusToDb(EMAIL_STATUS::NOT_VALIDATED),
        'email_code' => $emailCode,
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
