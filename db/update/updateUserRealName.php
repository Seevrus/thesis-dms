<?php
function updateUserRealName(PDO $pdo, string $taxNumber, string $newName): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $newName = htmlspecialchars($newName, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $updateNameQuery = 'UPDATE
        user
      SET
        user_real_name = :urn
      WHERE
        user_tax_number = :utn';
    $updateNameStmt = $pdo->prepare($updateNameQuery);
    $updateNameStmt->execute(
      array(
        ':urn' => $newName,
        ':utn' => $taxNumber,
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Name of User successfully updated',
        'user_real_name' => $newName,
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
