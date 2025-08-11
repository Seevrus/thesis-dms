<?php
function selectCompanies(PDO $pdo): string {
  try {
    $fetchCompanyQuery = 'SELECT 
        company_id AS id,
        company_name AS companyName
      FROM wp_company';

    $fetchCompanyStmt = $pdo->prepare($fetchCompanyQuery);
    $fetchCompanyStmt->execute();
    $companies = $fetchCompanyStmt->fetchAll(PDO::FETCH_OBJ);

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Companies successfully fetched',
        'companies' => $companies,
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
