<?php
require_once dirname(dirname(__FILE__)) . '/api_utils/generateRandomString.php';

function createDocumentStub(
    PDO $pdo,
    string $taxNumber,
    string $documentName,
    string $validUntil = null
)
{
    try {
        // do some clean-up
        $taxNumber = htmlentities($taxNumber);
        $documentName = htmlentities($documentName);
        $validUntil = htmlentities($validUntil);

        $documentQuery = 'INSERT INTO dokumentum (dolgozo_adoazonosito, dokumentum_nev, ervenyes) VALUES (:azon, :nev, :erv)';
        $docuemntStmt = $pdo->prepare($documentQuery);
        $docuemntStmt->execute(
            array(
                ':azon' => $taxNumber,
                ':nev' => $documentName,
                ':erv' => empty($validUntil) ? null : $validUntil,
            )
        );

        $documentId = $pdo->lastInsertId();

        // enable file upload to this record via a token
        $token = generateRandomString();
        $codeQuery = 'INSERT INTO dokumentum_feltoltokod (dokumentum_azon, feltoltokod) VALUES (:azon, :kod)';
        $codeStmt = $pdo->prepare($codeQuery);
        $codeStmt->execute(
            array(
                ':azon' => $documentId,
                ':kod' => $token,
            )
        );

        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'Document successfully created',
                'documentId' => $documentId,
                'token' => $token,
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
