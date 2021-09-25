<?php
require_once dirname(dirname(dirname(__FILE__))) . '/api_utils/statusEnums.php';

function validateEmail(PDO $pdo, string $taxNumber, string $emailCode) : string
{
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $emailCode = htmlspecialchars($emailCode, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    // TODO: for now, I assume that only a valid request can reach up to this point.
    // It would be nice to double-check this assumption
    $checkHashQuery = 'SELECT
            email_code
        FROM user_email_code
        WHERE user_tax_number = :utn';
    $checkHashStmt = $pdo->prepare($checkHashQuery);
    $checkHashStmt->execute(
        array(
            ':utn' => $taxNumber,
        )
    );
    $userRow = $checkHashStmt->fetch(PDO::FETCH_ASSOC);
    
    if (password_verify($emailCode, $userRow['email_code'])) {
        $updateEmailQuery = 'UPDATE
                user
            SET email_status = :st
            WHERE user_tax_number = :utn';
        $updateEmailStmt = $pdo->prepare($updateEmailQuery);
        $updateEmailStmt->execute(
            array(
                ':st' => mapEmailStatusToDb(EMAIL_STATUS::VALID_EMAIL),
                ':utn' => $taxNumber,
            )
        );

        $deleteEmailCodeQuery = 'DELETE
            FROM user_email_code
            WHERE user_tax_number = :utn';
        $deleteEmailCodeStmt = $pdo->prepare($deleteEmailCodeQuery);
        $deleteEmailCodeStmt->execute(
            array(
                ':utn' => $taxNumber,
            )
        );

        if ($updateEmailStmt->rowCount() == 1) {
            return json_encode(
                array(
                    'outcome' => 'success',
                    'message' => 'Email successfully updated',
                    'email_status' => mapEmailStatusToDb(EMAIL_STATUS::VALID_EMAIL),
                )
            );
        } else {
            return json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'Unexpected database error while trying to modify email address',
                )
            );
        }
    } else {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Email code is invalid',
            )
        );
    }
}
?>