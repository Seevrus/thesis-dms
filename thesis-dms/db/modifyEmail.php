<?php
require_once dirname(dirname(__FILE__)) . '/api_utils/statusEnums.php';

function modifyEmail(PDO $pdo, string $taxNumber, string $email, string $passwordHash)
{
    // do some clean-up
    $taxNumber = htmlentities($taxNumber);
    $email = htmlentities($email);

    // TODO: for now, I assume that only a valid request can reach up to this point.
    // It would be nice to double-check this assumption
    $updateEmailQuery = 'UPDATE dolgozo SET email = :em, email_statusz = :st, jelszo = :pw WHERE adoazonosito = :ad';
    $updateEmailStmt = $pdo->prepare($updateEmailQuery);
    $updateEmailStmt->execute(
        array(
            ':em' => $email,
            ':st' => mapEmailStatusToDb(EMAIL_STATUS::NOT_VALIDATED),
            ':pw' => $passwordHash,
            ':ad' => $taxNumber,
        )
    );

    if ($updateEmailStmt->rowCount() == 1) {
        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'Email successfully updated',
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
}
?>