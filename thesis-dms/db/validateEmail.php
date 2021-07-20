<?php
require_once dirname(dirname(__FILE__)) . '/api_utils/statusEnums.php';

function validateEmail(PDO $pdo, string $taxNumber, string $emailCode)
{
    // do some clean-up
    $taxNumber = htmlentities($taxNumber);
    $emailCode = htmlentities($emailCode);

    // TODO: for now, I assume that only a valid request can reach up to this point.
    // It would be nice to double-check this assumption
    $checkHashQuery = 'SELECT email_kod FROM dolgozo WHERE adoazonosito = :ad';
    $checkHashStmt = $pdo->prepare($checkHashQuery);
    $checkHashStmt->execute(
        array(
            ':ad' => $taxNumber,
        )
    );
    $userRow = $checkHashStmt->fetch(PDO::FETCH_ASSOC);
    if (password_verify($emailCode, $userRow['email_kod'])) {
        $updateEmailQuery = 'UPDATE dolgozo SET email_statusz = :st, email_kod = NULL WHERE adoazonosito = :ad';
        $updateEmailStmt = $pdo->prepare($updateEmailQuery);
        $updateEmailStmt->execute(
            array(
                ':st' => mapEmailStatusToDb(EMAIL_STATUS::VALID_EMAIL),
                ':ad' => $taxNumber,
            )
        );

        if ($updateEmailStmt->rowCount() == 1) {
            return json_encode(
                array(
                    'outcome' => 'success',
                    'message' => 'Email successfully updated',
                    'emailStatus' => EMAIL_STATUS::VALID_EMAIL,
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