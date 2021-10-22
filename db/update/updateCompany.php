<?php
function updateCompany(PDO $pdo, string $taxNumber, string $companyName): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $companyName = htmlspecialchars($companyName, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $selectCompanyCodeQuery = 'SELECT company_id FROM company WHERE company_name = :cn';
    $selectCompanyCodeStmt = $pdo->prepare($selectCompanyCodeQuery);
    $selectCompanyCodeStmt->execute(array( ':cn' => $companyName ));
    $companyRow = $selectCompanyCodeStmt->fetch(PDO::FETCH_ASSOC);

    $updateNameQuery = 'UPDATE user SET company_code = :cc WHERE user_tax_number = :utn';
    $updateNameStmt = $pdo->prepare($updateNameQuery);
    $updateNameStmt->execute(
      array(
        ':cc' => $companyRow->company_id,
        ':utn' => $taxNumber,
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Company of User successfully updated',
        'company_name' => $companyName,
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
