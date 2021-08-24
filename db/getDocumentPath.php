<?php
function getDocumentPath(PDO $pdo, string $taxNumber, string $documentId) : string
{
    try {
        // do some clean-up
        $taxNumber = htmlentities($taxNumber);
        $documentId = htmlentities($documentId);

        $fetchQuery = 'SELECT utvonal FROM dokumentum WHERE azon = :az AND lathato = :lt AND dolgozo_adoazonosito = :ad';
        $fetchQueryStmt = $pdo->prepare($fetchQuery);
        $fetchQueryStmt->execute(
            array(
                ':ad' => $taxNumber,
                ':lt' => 1,
                ':az' => $documentId,
            )
        );
        $documentRow = $fetchQueryStmt->fetch(PDO::FETCH_ASSOC);

        if (!$documentRow) {
            return json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'Document cannot be found',
                )
            );
        }

        return json_encode(
            array(
                'outcome' => 'success',
                'documentPath' => $documentRow['utvonal'],
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
