<?php
function updateDocumentVisibility(PDO $pdo, string $taxNumber, string $documentId)
{
    try {
        // do some clean-up
        $taxNumber = htmlentities($taxNumber);
        $documentId = htmlentities($documentId);

        // get document path to be able to remove it from the server
        $fetchQuery = 'SELECT utvonal FROM dokumentum WHERE azon = :az AND dolgozo_adoazonosito = :ad AND lathato = :lt';
        $fetchQueryStmt = $pdo->prepare($fetchQuery);
        $fetchQueryStmt->execute(
            array(
                ':ad' => $taxNumber,
                ':az' => $documentId,
                ':lt' => 1,
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

        $updateQuery = 'UPDATE dokumentum SET lathato = :lt, utvonal = :ut WHERE azon = :az AND dolgozo_adoazonosito = :ad';
        $updateQueryStmt = $pdo->prepare($updateQuery);
        $updateQueryStmt->execute(
            array(
                ':lt' => 0,
                ':ut' => null,
                ':ad' => $taxNumber,
                ':az' => $documentId,
            )
        );

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
