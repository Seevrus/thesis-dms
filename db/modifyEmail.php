<?php
require_once dirname(dirname(__FILE__)) . '/api_utils/statusEnums.php';

function modifyEmail(
    PDO $pdo,
    string $taxNumber,
    string $email,
    string $passwordHash
) : string
{
    try {
        // do some clean-up
        $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $email = htmlspecialchars($email, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $passwordHash = htmlspecialchars($passwordHash, ENT_COMPAT | ENT_HTML401, 'UTF-8');

        // generate an email code for validation purposes
        $emailCode = rand(100000, 999999);
        $emailCodeHash = password_hash($emailCode, PASSWORD_DEFAULT);

        // TODO: for now, I assume that only a valid request can reach up to this point.
        // It would be nice to double-check this assumption
        $updateEmailQuery = 'UPDATE
                user
            SET
                user_email = :uem,
                email_status = :est,
                user_password = :pw
            WHERE
                user_tax_number = :utn';
        $updateEmailStmt = $pdo->prepare($updateEmailQuery);
        $updateEmailStmt->execute(
            array(
                ':uem' => $email,
                ':est' => mapEmailStatusToDb(EMAIL_STATUS::NOT_VALIDATED),
                ':pw' => $passwordHash,
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