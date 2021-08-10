<?php
date_default_timezone_set('Europe/Budapest');

function selectDocuments(
    PDO $pdo,
    string $taxNumber,
    int $category = null,
    int $fetchFrom = 0,
    int $limit = 10
) {
    try {
        // do some clean-up
        $taxNumber = htmlentities($taxNumber);
        $category = htmlentities($category);
        $fetchFrom = htmlentities($fetchFrom);
        $limit = htmlentities($limit);

        if (empty($category)) {
            $fetchQuery = 'SELECT d.azon, d.dokumentum_nev, k.kategoria_nev, d.hozzaadva, d.ervenyes FROM dokumentum d JOIN dokumentum_kategoria k ON d.kategoria = k.azon WHERE d.dolgozo_adoazonosito = :ad AND lathato = :lt AND (ISNULL(d.ervenyes) OR d.ervenyes > NOW()) LIMIT :honnan, :hova';
            $fetchQueryStmt = $pdo->prepare($fetchQuery);
            $fetchQueryStmt->execute(
                array(
                    ':ad' => $taxNumber,
                    ':lt' => 1,
                    ':honnan' => $fetchFrom,
                    ':hova' => $limit,
                )
            );
        } else {
            $fetchQuery = 'SELECT d.azon, d.dokumentum_nev, k.kategoria_nev, d.hozzaadva, d.ervenyes FROM dokumentum d JOIN dokumentum_kategoria k ON d.kategoria = k.azon WHERE d.dolgozo_adoazonosito = :ad AND lathato = :lt AND (ISNULL(d.ervenyes) OR d.ervenyes > NOW()) AND d.kategoria = :kat LIMIT :honnan, :hova';
            $fetchQueryStmt = $pdo->prepare($fetchQuery);
            $fetchQueryStmt->execute(
                array(
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
