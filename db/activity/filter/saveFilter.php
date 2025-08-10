<?php
function saveFilter(PDO $pdo, string $taxNumber, string $filterName, $filter): string {
  try {
    // do some clean-up
    $filterName = htmlspecialchars($filterName, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $saveQuery = 'INSERT
      INTO wp_user_activity_filter (
        user_tax_number,
        filter_name,
        ufilter
      )
      VALUES (
        :utn,
        :fn,
        :uf
      )';
    
    $saveStmt = $pdo->prepare($saveQuery);
    $saveStmt->execute(
      array(
        ':utn' => $taxNumber,
        ':fn' => $filterName,
        ':uf' => json_encode($filter),
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Filter has been successfully saved',
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
