<?php
function mapColumnNameToTable(string $columnName) {
  switch ($columnName) {
    case 'companyName':
      return 'company';
    case 'userRealName':
      return 'user';
    case 'categoryName':
      return 'document_category';
    case 'documentName':
    case 'added':
    case 'validUntil':
    case 'downloaded':
      return 'document';
  }
}

function mapColumNameToDbcolumn(string $columnName) {
  switch ($columnName) {
    case 'companyName':
      return 'company_name';
    case 'userRealName':
      return 'user_real_name';
    case 'categoryName':
      return 'category_name';
    case 'documentName':
      return 'document_name';
    case 'added':
      return 'document_added';
    case 'validUntil':
      return 'document_valid';
    case 'downloaded':
      return 'document_downloaded';
  }
}

function selectColumnOptions(PDO $pdo, string $columnName): string {
  try {
    // do some clean-up
    $columnName = htmlspecialchars($columnName, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $optionsQuery = 'SELECT
      DISTINCT ' . mapColumNameToDbcolumn($columnName) . '
      FROM ' . mapColumnNameToTable($columnName);
    
    $optionsQueryStmt = $pdo->query($optionsQuery);
    $fetchedOptions = $optionsQueryStmt->fetchAll(PDO::FETCH_COLUMN);
    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Successful search',
        'options' => $fetchedOptions,
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
