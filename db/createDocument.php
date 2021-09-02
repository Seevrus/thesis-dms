<?php
require_once dirname(__FILE__) . '/isUserWorksAtCompany.php';

function createDocument(
    PDO $pdo,
    string $companyCode,
    string $taxNumber,
    string $documentName,
    int $category,
    int $visible,
    string $validUntil,
    string $targetLocation
) : string
{
    try {
        // do some clean-up
        $companyCode = htmlentities($companyCode);
        $taxNumber = htmlentities($taxNumber);
        $documentName = htmlentities($documentName);
        $category = htmlentities($category);
        $visible = htmlentities($visible);
        $targetLocation = htmlentities($targetLocation);
        $validUntil = htmlentities($validUntil);

        $isUserEligible = isUserWorksAtCompany($pdo, $companyCode, $taxNumber);
        if (!$isUserEligible) {
            return json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'User does not work at company with code ' . $companyCode,
                )
            );
        }

        $documentQuery = 'INSERT INTO dokumentum (ceg_cegkod, dolgozo_adoazonosito, dokumentum_nev, kategoria, lathato, ervenyes, utvonal) VALUES (:ceg, :azon, :nev, :kateg, :lat, :erv, :ut)';
        $docuemntStmt = $pdo->prepare($documentQuery);
        $docuemntStmt->execute(
            array(
                ':ceg' => $companyCode,
                ':azon' => $taxNumber,
                ':nev' => $documentName,
                ':kateg' => $category,
                ':lat' => $visible,
                ':erv' => empty($validUntil) ? null : $validUntil,
                ':ut' => $targetLocation,
            )
        );

        return json_encode(
            array(
                'outcome' => 'success',
                'message' => 'File uploaded successfully',
            )
        );
    } catch (PDOException $e) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Unexpected database error',
            )
        );
    }
}
?>
