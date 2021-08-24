<?php
require_once dirname(dirname(__FILE__)) . '/api_utils/generateRandomString.php';

function createDocument(
    PDO $pdo,
    string $taxNumber,
    string $documentName,
    int $category,
    string $targetLocation,
    string $validUntil = null
) : string
{
    try {
        // do some clean-up
        $taxNumber = htmlentities($taxNumber);
        $documentName = htmlentities($documentName);
        $targetLocation = htmlentities($targetLocation);
        $validUntil = htmlentities($validUntil);

        $documentQuery = 'INSERT INTO dokumentum (dolgozo_adoazonosito, dokumentum_nev, kategoria, ervenyes, utvonal) VALUES (:azon, :nev, :kateg, :erv, :ut)';
        $docuemntStmt = $pdo->prepare($documentQuery);
        $docuemntStmt->execute(
            array(
                ':azon' => $taxNumber,
                ':nev' => $documentName,
                ':kateg' => $category,
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
