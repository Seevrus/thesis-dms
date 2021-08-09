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

        $now = date('Y-m-d H:i:s');
        $fetchQuery = empty($category)
            ? 'SELECT azon, dokumentum_nev, kategoria, hozzaadva, ervenyes FROM dokumentum WHERE dolgozo_adoazonosito = :ad AND lathato = :lt AND ervenyes > :erv LIMIT :honnan, :hova'
            : 'SELECT azon, dokumentum_nev, kategoria, hozzaadva, ervenyes FROM dokumentum WHERE dolgozo_adoazonosito = :ad AND lathato = :lt AND ervenyes > :erv AND kategoria = :kat LIMIT :honnan, :hova';
        $fetchQueryStmt = $pdo->prepare($fetchQuery);
        $fetchQueryStmt->execute(
            array(
                ':ad' => $taxNumber,
                ':lt' => 1,
                ':erv' => $now,
                ':kat' => $category,
                ':honnan' => $fetchFrom,
                ':hova' => $limit,
            )
        );

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
