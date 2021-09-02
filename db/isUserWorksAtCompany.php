<?php
function isUserWorksAtCompany(
    PDO $pdo,
    string $companyCode,
    string $taxNumber
) : bool
{
    try {
        // do some clean-up
        $companyCode = htmlentities($companyCode);
        $taxNumber = htmlentities($taxNumber);

        // TODO: ha a dolgozó nincs annál a cégnél, elutasítjuk
        $checkQuery = 'SELECT * FROM cegnel_dolgozik WHERE ceg_cegkod = :kod AND dolgozo_adoazonosito = :ad';
        $checkStmt = $pdo->prepare($checkQuery);
        $checkStmt->execute(
            array(
                ':kod' => $companyCode,
                ':ad' => $taxNumber,
            )
        );
        $userRow = $checkStmt->fetch(PDO::FETCH_ASSOC);

        if (!$userRow) {
            return false;
        }

        return true;
    } catch (PDOException $e) {
        return false;
    }
}
?>
