<?php
function getDocumentPath(
    PDO $pdo,
    $validCompanyCodesForUser,
    string $taxNumber,
    string $documentId
) : string
{
    try {
        // do some clean-up
        $validCompanyCodesForUser = implode(', ', $validCompanyCodesForUser);
        $taxNumber = htmlentities($taxNumber);
        $documentId = htmlentities($documentId);

        $fetchQuery = 'SELECT
                utvonal
            FROM dokumentum
            WHERE
                azon = :az 
                AND ceg_cegkod IN(:ck)
                AND lathato = :lt 
                AND dolgozo_adoazonosito = :ad';
        $fetchQueryStmt = $pdo->prepare($fetchQuery);
        $fetchQueryStmt->execute(
            array(
                ':ck' => $validCompanyCodesForUser,
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
