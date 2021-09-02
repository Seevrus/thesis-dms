<?php
date_default_timezone_set('Europe/Budapest');

function selectDocuments(
    PDO $pdo,
    $validCompanyCodesForUser,
    string $taxNumber,
    int $category = null,
    int $fetchFrom = 0,
    int $limit = 10
) : string
{
    try {
        // do some clean-up
        $validCompanyCodesForUser = implode(', ', $validCompanyCodesForUser);
        $taxNumber = htmlentities($taxNumber);
        $category = htmlentities($category);
        $fetchFrom = htmlentities($fetchFrom);
        $limit = htmlentities($limit);

        if (empty($category)) {
            $fetchQuery = 'SELECT
                    d.azon AS id,
                    c.cegnev AS companyName,
                    d.dokumentum_nev AS documentName,
                    k.kategoria_nev AS documentCategory,
                    d.hozzaadva AS added,
                    d.letoltve AS downloadedAt,
                    d.ervenyes AS validUntil
                FROM dokumentum d
                JOIN dokumentum_kategoria k ON d.kategoria = k.azon
                JOIN ceg c ON d.ceg_cegkod = c.cegkod
                WHERE
                    d.ceg_cegkod IN(:ck)
                    AND d.dolgozo_adoazonosito = :ad
                    AND lathato = :lt 
                    AND (ISNULL(d.ervenyes) 
                    OR d.ervenyes > NOW())
                LIMIT :honnan, :hova';
            $fetchQueryStmt = $pdo->prepare($fetchQuery);
            $fetchQueryStmt->execute(
                array(
                    ':ck' => $validCompanyCodesForUser,
                    ':ad' => $taxNumber,
                    ':lt' => 1,
                    ':honnan' => $fetchFrom,
                    ':hova' => $limit,
                )
            );
        } else {
            $fetchQuery = 'SELECT
                    d.azon AS id,
                    c.cegnev AS companyName,
                    d.dokumentum_nev AS documentName,
                    k.kategoria_nev AS documentCategory,
                    d.hozzaadva AS added,
                    d.letoltve AS downloadedAt,
                    d.ervenyes AS validUntil
                FROM dokumentum d
                JOIN dokumentum_kategoria k ON d.kategoria = k.azon
                JOIN ceg c ON d.ceg_cegkod = c.cegkod
                WHERE
                    d.ceg_cegkod IN(:ck)
                    AND d.dolgozo_adoazonosito = :ad
                    AND lathato = :lt
                    AND (ISNULL(d.ervenyes)
                    OR d.ervenyes > NOW())
                    AND d.kategoria = :kat
                LIMIT :honnan, :hova';
            $fetchQueryStmt = $pdo->prepare($fetchQuery);
            $fetchQueryStmt->execute(
                array(
                    ':ck' => $validCompanyCodesForUser,
                    ':ad' => $taxNumber,
                    ':lt' => 1,
                    ':kat' => $category,
                    ':honnan' => $fetchFrom,
                    ':hova' => $limit,
                )
            );
        }

        $fetchedDocuments = $fetchQueryStmt->fetchAll(PDO::FETCH_OBJ);
        return json_encode(
            array(
                'outcome' => 'success',
                'documents' => $fetchedDocuments,
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
