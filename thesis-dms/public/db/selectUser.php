<?php
function selectUser(PDO $pdo, string $taxId, string $password)
{
    // do some clean-up
    $taxId = htmlentities($taxId);
    $password = htmlentities($password);
    $query = 'SELECT * FROM dolgozo WHERE adoazonosito = :ad';

    // try to fetch the user
    $stmt = $pdo->prepare("SELECT * FROM dolgozo WHERE adoazonosito = :ad");
    $stmt->execute(array( ':ad' => $taxId));
    $row = $stmt->fetch(PDO::FETCH_ASSOC);  // an array

    // case 1: user not found
    if (!$row) return false;

    // case 2: wrong password
    if (!password_verify($password, $row['jelszo'])) return false;

    return true;
}
?>