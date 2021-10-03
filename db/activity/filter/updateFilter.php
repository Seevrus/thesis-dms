<?php
function updateFilter(PDO $pdo, string $filterId, $filter): string {
  try {
    // do some clean-up
    $filterId = htmlspecialchars($filterId, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $updateFilterQuery = 'UPDATE user_activity_filter
      SET ufilter = :fr
      WHERE filter_id = :fid';
    
    $updateFilterStmt = $pdo->prepare($updateFilterQuery);
    $updateFilterStmt->execute(
      array(
        ':fid' => $filterId,
        ':fr' => json_encode($filter),
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Filter has been successfully updated',
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
