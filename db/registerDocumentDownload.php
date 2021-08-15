<?php
date_default_timezone_set('Europe/Budapest');

function registerDocumentDownload(PDO $pdo, string $taxNumber, string $documentId)
{
    try {
        // do some clean-up
        $taxNumber = htmlentities($taxNumber);
        $documentId = htmlentities($documentId);

        $fetchQuery = 'SELECT letoltve FROM dokumentum WHERE dolgozo_adoazonosito = :ad AND azon = :az';
        $fetchQueryStmt = $pdo->prepare($fetchQuery);
        $fetchQueryStmt->execute(
            array(
                ':ad' => $taxNumber,
                ':az' => $documentId,
            )
        );
        $documentRow = $fetchQueryStmt->fetch(PDO::FETCH_ASSOC);

        // If not already registered, the register it
        if (is_null($documentRow['letoltve'])) {
            $registerQuery = 'UPDATE dokumentum SET letoltve = :most WHERE azon = :az';
            $registerQueryStmt = $pdo->prepare($registerQuery);
            $registerQueryStmt->execute(
                array(
                    ':most' => date("Y-m-d H:i:s"),
                    ':az' => $documentId,
                )
            );
        }

        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'Registration successful',
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
