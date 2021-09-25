<?php
require_once dirname(dirname(dirname(__FILE__))) . '/api_utils/generateRandomString.php';

function createDocument(
    PDO $pdo,
    string $taxNumber,
    string $documentName,
    int $category,
    string $targetLocation,
    int $validUntil = 0
) : string
{
    try {
        // do some clean-up
        $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $documentName = htmlspecialchars($documentName, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $targetLocation = htmlspecialchars($targetLocation, ENT_COMPAT | ENT_HTML401, 'UTF-8');

        $documentQuery = 'INSERT
            INTO document (
                user_tax_number,
                document_name,
                category_id,
                document_visible,
                document_valid,
                document_path
            )
            VALUES (
                :did,
                :dname,
                :dcateg,
                :dvis,
                :dvalid,
                :dpath
            )';
        $docuemntStmt = $pdo->prepare($documentQuery);
        $docuemntStmt->execute(
            array(
                ':did' => $taxNumber,
                ':dname' => $documentName,
                ':dcateg' => $category,
                ':dvis' => 1,
                ':dvalid' => $validUntil == 0 ? null : date("Y-m-d H:i:s", $validUntil),
                ':dpath' => $targetLocation,
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
