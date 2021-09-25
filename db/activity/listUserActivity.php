<?php
function listUserActivity(
  PDO $pdo,
  $companyName,
  $userRealName,
  $categoryName,
  $documentName,
  $added,
  $validUntil,
  $downloaded
): string {
  try {
    $conditionStrings = array();
    if (!empty($companyName)) {
      array_push(
        $conditionStrings,
        htmlspecialchars(
          'c.company_name LIKE \'' . implode('\' OR c.company_name LIKE \'', $companyName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
        )
      );
    }
    if (!empty($userRealName)) {
      array_push(
        $conditionStrings,
        htmlspecialchars(
          'u.user_real_name LIKE \'' . implode('\' OR u.user_real_name LIKE \'', $userRealName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
        )
      );
    }
    if (!empty($categoryName)) {
      array_push(
        $conditionStrings,
        htmlspecialchars(
          'dc.category_name LIKE \'' . implode('\' OR dc.category_name LIKE \'', $categoryName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
        )
      );
    }
    if (!empty($documentName)) {
      array_push(
        $conditionStrings,
        htmlspecialchars(
          'd.document_name LIKE \'' . implode('\' OR d.document_name LIKE \'', $documentName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
        )
      );
    }
    if (!is_null($added)) {
      $added = htmlspecialchars($added, ENT_COMPAT | ENT_HTML401, 'UTF-8');
      array_push($conditionStrings, 'd.document_added' . ' > ' . $added);
    }
    if (!is_null($validUntil)) {
      $validUntil = htmlspecialchars($validUntil, ENT_COMPAT | ENT_HTML401, 'UTF-8');
      array_push($conditionStrings, '(ISNULL(d.document_valid) OR d.document_valid' . ' < ' . $validUntil);
    }
    if (!is_null($downloaded)) {
      $downloaded
        ? array_push($conditionStrings, 'd.document_downloaded' . ' IS NOT NULL ')
        : array_push($conditionStrings, 'd.document_downloaded' . ' IS NULL ');
    }

    !empty($conditionStrings)
      ? $conditionString = ' WHERE ' . implode(' AND ', $conditionStrings)
      : $conditionString = '';

    $activityQuery = 'SELECT
        d.document_id AS id,
        c.company_name AS companyName,
        u.user_real_name AS userRealName,
        dc.category_name AS categoryName,
        d.document_name AS documentName,
        d.document_added AS added,
        d.document_valid AS validUntil,
        d.document_downloaded AS downloadedAt
      FROM document d
      JOIN user u ON d.user_tax_number = u.user_tax_number
      JOIN company c ON u.company_code = c.company_id
      JOIN document_category dc ON d.category_id = dc.category_id' 
      . $conditionString . '
      LIMIT 3';
    
    $activityQueryStmt = $pdo->query($activityQuery);
    $fetchedActivity = $activityQueryStmt->fetchAll(PDO::FETCH_OBJ);
    return json_encode(
      array(
        'outcome' => 'success',
        'activities' => $fetchedActivity,
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
