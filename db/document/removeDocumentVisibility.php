<?php
function removeDocumentVisibility(PDO $pdo, string $taxNumber, string $documentId) : string
{
    try {
        // do some clean-up
        $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $documentId = htmlspecialchars($documentId, ENT_COMPAT | ENT_HTML401, 'UTF-8');

        // get document path to be able to remove it from the server
        $fetchQuery = 'SELECT
                document_downloaded,
                document_path
            FROM document
            WHERE
                document_id = :did
                AND user_tax_number = :utn
                AND document_visible = :dvis';
        $fetchQueryStmt = $pdo->prepare($fetchQuery);
        $fetchQueryStmt->execute(
            array(
                ':did' => $documentId,
                ':utn' => $taxNumber,
                ':dvis' => 1,
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

        if (is_null($documentRow['document_downloaded'])) {
            return json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'Document not yet downloaded by user',
                )
            );
        }

        $updateQuery = 'UPDATE
                document
            SET
                document_visible = :dvis,
                document_path = :dpath
            WHERE
                document_id = :did';
        $updateQueryStmt = $pdo->prepare($updateQuery);
        $updateQueryStmt->execute(
            array(
                ':dvis' => 0,
                ':dpath' => null,
                ':did' => $documentId,
            )
        );

        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'Document removed from database',
                'document_path' => $documentRow['document_path'],
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
