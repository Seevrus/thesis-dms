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
      $conditionStrings[] = htmlspecialchars(
          'c.company_name LIKE \'' . implode('\' OR c.company_name LIKE \'', $companyName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
      );
    }
    if (!empty($userRealName)) {
      $conditionStrings[] = htmlspecialchars(
          'u.user_real_name LIKE \'' . implode('\' OR u.user_real_name LIKE \'', $userRealName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
      );
    }
    if (!empty($categoryName)) {
      $conditionStrings[] = htmlspecialchars(
          'dc.category_name LIKE \'' . implode('\' OR dc.category_name LIKE \'', $categoryName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
      );
    }
    if (!empty($documentName)) {
      $conditionStrings[] = htmlspecialchars(
          'd.document_name LIKE \'' . implode('\' OR d.document_name LIKE \'', $documentName) . '\'',
          ENT_COMPAT | ENT_HTML401, 'UTF-8'
      );
    }
    if (!empty($added)) {
      if (isset($added->from) && !isset($added->to)) {
        $from = htmlspecialchars($added->from, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $conditionStrings[] = 'd.document_added' . ' >= \'' . $from . '\'';
      } else if (!isset($added->from) && isset($added->to)) {
        $to = htmlspecialchars($added->to, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $conditionStrings[] = 'd.document_added' . ' <= \'' . $to . '\'';
      } else if (isset($added->from) && isset($added->to)) {
        $from = htmlspecialchars($added->from, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $to = htmlspecialchars($added->to, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $conditionStrings[] = 'd.document_added' . ' >= \'' . $from . '\' AND d.document_added' . ' <= \'' . $to . '\'';
      }
    }
    if (!empty($validUntil)) {
      if (isset($validUntil->from) && !isset($validUntil->to)) {
        $from = htmlspecialchars($validUntil->from, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $validUntilCondition = ' d.document_valid' . ' >= \'' . $from . '\' ';
      } else if (!isset($validUntil->from) && isset($validUntil->to)) {
        $to = htmlspecialchars($validUntil->to, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $validUntilCondition = ' d.document_valid' . ' <= \'' . $to . '\' ';
      } else if (isset($validUntil->from) && isset($validUntil->to)) {
        $from = htmlspecialchars($validUntil->from, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $to = htmlspecialchars($validUntil->to, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $validUntilCondition = ' d.document_valid' . ' >= \'' . $from . '\' AND d.document_valid' . ' <= \'' . $to . '\' ';
      }

      if (isset($validUntilCondition) && $validUntil->checked) {
        $finalCondition = $validUntilCondition . ' OR d.document_valid IS NULL ';
      } else if (isset($validUntilCondition) && !$validUntil->checked) {
        $finalCondition = $validUntilCondition . ' AND d.document_valid IS NOT NULL ';
      } else if (!isset($validUntilCondition) && !$validUntil->checked) {
        $finalCondition = ' d.document_valid IS NOT NULL ';
      }

      if (isset($finalCondition)) {
        $conditionStrings[] = $finalCondition;
        unset($finalCondition);
      }
    }
    if (!empty($downloaded)) {
      if (isset($downloaded->from) && !isset($downloaded->to)) {
        $from = htmlspecialchars($downloaded->from, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $downloadedCondition = ' d.document_downloaded' . ' >= \'' . $from . '\' ';
      } else if (!isset($downloaded->from) && isset($downloaded->to)) {
        $to = htmlspecialchars($downloaded->to, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $downloadedCondition = ' d.document_downloaded' . ' <= \'' . $to . '\' ';
      } else if (isset($downloaded->from) && isset($downloaded->to)) {
        $from = htmlspecialchars($downloaded->from, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $to = htmlspecialchars($downloaded->to, ENT_COMPAT | ENT_HTML401, 'UTF-8');
        $downloadedCondition = ' d.document_downloaded' . ' >= \'' . $from . '\' AND d.document_downloaded' . ' <= \'' . $to . '\' ';
      }

      if (isset($downloadedCondition) && $downloaded->checked) {
        $finalCondition = $downloadedCondition . ' OR d.document_downloaded IS NULL ';
      } else if (isset($downloadedCondition) && !$downloaded->checked) {
        $finalCondition = $downloadedCondition . ' AND d.document_downloaded IS NOT NULL ';
      } else if (!isset($downloadedCondition) && $downloaded->checked) {
        $finalCondition = ' d.document_downloaded IS NULL ';
      }

      if (isset($finalCondition)) {
        $conditionStrings[] = $finalCondition;
      }
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
      FROM wp_document d
      JOIN wp_user u ON d.user_tax_number = u.user_tax_number
      JOIN wp_company c ON u.company_code = c.company_id
      JOIN wp_document_category dc ON d.category_id = dc.category_id'
      . $conditionString . '
      ORDER BY d.document_added DESC 
      LIMIT 50';
    
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
