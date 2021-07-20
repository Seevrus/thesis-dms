<?php
require_once dirname(dirname(__FILE__)) . '/api_utils/statusEnums.php';

function modifyEmail(PDO $pdo, string $taxNumber, string $email, string $passwordHash)
{
    // do some clean-up
    $taxNumber = htmlentities($taxNumber);
    $email = htmlentities($email);
    $passwordHash = htmlentities($passwordHash);

    // generate an email code for validation purposes
    $emailCode = rand(100000, 999999);
    $emailCodeHash = password_hash($emailCode, PASSWORD_DEFAULT);

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

    $updateEmailCodeQuery = 'INSERT INTO dolgozo_emailkod (dolgozo_azon, emailkod) VALUES (:ad, :cod)';
    $updateEmailCodeStmt = $pdo->prepare($updateEmailCodeQuery);
    $updateEmailCodeStmt->execute(
        array(
            ':ad' => $taxNumber,
            ':cod' => $emailCodeHash,
        )
    );

    if ($updateEmailStmt->rowCount() == 1) {
        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'Email successfully updated',
                'emailStatus' => EMAIL_STATUS::NOT_VALIDATED,
                'emailCode' => $emailCode,
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