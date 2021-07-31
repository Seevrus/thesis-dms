<?php
function registerUploadedDocument(
    PDO $pdo,
    string $uploadToken,
    string $fileId,
    string $targetLocation
) {
    try {
        // do some clean-up
        $uploadToken = htmlentities($uploadToken);
        $fileId = htmlentities($fileId);
        $targetLocation = htmlentities($targetLocation);

        $documentCheckerQuery = 'SELECT * FROM dokumentum_feltoltokod WHERE dokumentum_azon = :azon AND feltoltokod = :kod';
        $documentCheckerStmt = $pdo->prepare($documentCheckerQuery);
        $documentCheckerStmt->execute(
            array(
                ':azon' => $fileId,
                ':kod' => $uploadToken,
            )
        );
        $documentCheckerRow = $documentCheckerStmt->fetch(PDO::FETCH_ASSOC);

        // if uploadToken is not present
        if (!$documentCheckerRow) {
            return json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'You do not have permission to upload this document',
                )
            );
        }

        // delete upload token from database
        $documentCheckerCleanUpQuery = 'DELETE FROM dokumentum_feltoltokod WHERE dokumentum_azon = :azon AND feltoltokod = :kod';
        $documentCheckerCleanUpStmt = $pdo->prepare($documentCheckerCleanUpQuery);
        $documentCheckerCleanUpStmt->execute(
            array(
                ':azon' => $fileId,
                ':kod' => $uploadToken,
            )
        );

        // save path in database
        $documentQuery = 'UPDATE dokumentum SET utvonal = :ut, lathato = 1 WHERE azon = :id';
        $docuemntStmt = $pdo->prepare($documentQuery);
        $docuemntStmt->execute(
            array(
                ':id' => $fileId,
                ':ut' => $targetLocation,
            )
        );

        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'Document successfully uploaded',
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
