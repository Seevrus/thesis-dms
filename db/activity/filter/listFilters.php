<?php
function listFilters(PDO $pdo, string $taxNumber): string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $listFilterQuery = 'SELECT
        filter_id as id,
        filter_name as filterName,
        ufilter as activityFilter
      FROM user_activity_filter
      WHERE user_tax_number = :utn';
    
    $listFilterStmt = $pdo->prepare($listFilterQuery);
    $listFilterStmt->execute(
      array(
        ':utn' => $taxNumber,
      )
    );

    $fetchedFilters = $listFilterStmt->fetchAll(PDO::FETCH_OBJ);
    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Filters have been successfully loaded',
        'filters' => $fetchedFilters,
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
