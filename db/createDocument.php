<?php
require_once dirname(dirname(__FILE__)) . '/api_utils/generateRandomString.php';

function createDocument(
    PDO $pdo,
    string $taxNumber,
    string $documentName,
    string $targetLocation,
    string $validUntil = null
)
{
    try {
        // do some clean-up
        $taxNumber = htmlentities($taxNumber);
        $documentName = htmlentities($documentName);
        $targetLocation = htmlentities($targetLocation);
        $validUntil = htmlentities($validUntil);

        $documentQuery = 'INSERT INTO dokumentum (dolgozo_adoazonosito, dokumentum_nev, ervenyes, utvonal) VALUES (:azon, :nev, :erv, :ut)';
        $docuemntStmt = $pdo->prepare($documentQuery);
        $docuemntStmt->execute(
            array(
                ':azon' => $taxNumber,
                ':nev' => $documentName,
                ':erv' => empty($validUntil) ? null : $validUntil,
                ':ut' => $targetLocation,
            )
        );

        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'Document successfully created',
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
