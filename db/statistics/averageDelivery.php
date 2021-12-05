<?php
function averageDelivery(PDO $pdo): string {
  try {
    $lastWeekQuery = 'SELECT
      COUNT(document_id)
      FROM document
      WHERE
        document_downloaded IS NOT NULL
        AND category_id = :cid
        AND document_downloaded BETWEEN (NOW() - INTERVAL 7 DAY) AND NOW()';
    $lastWeekStmt = $pdo->prepare($lastWeekQuery);
    $lastWeekStmt->execute(array( ':cid' => 1 ));
    $lastWeekPayrollCount = $lastWeekStmt->fetchColumn();
    $lastWeekStmt->execute(array( ':cid' => 2 ));
    $lastWeekInfoCount = $lastWeekStmt->fetchColumn();
    
    $lastMonthQuery = 'SELECT
      COUNT(document_id)
      FROM document
      WHERE
        document_downloaded IS NOT NULL
        AND category_id = :cid
        AND document_downloaded BETWEEN (NOW() - INTERVAL 1 MONTH) AND (NOW() - INTERVAL 7 DAY)';
    $lastMonthStmt = $pdo->prepare($lastMonthQuery);
    $lastMonthStmt->execute(array( ':cid' => 1 ));
    $lastMonthPayrollCount = $lastMonthStmt->fetchColumn();
    $lastMonthStmt->execute(array( ':cid' => 2 ));
    $lastMonthInfoCount = $lastMonthStmt->fetchColumn();
    
    $moreThanOneMonthQuery = 'SELECT
      COUNT(document_id)
      FROM document
      WHERE
        document_downloaded IS NOT NULL
        AND category_id = :cid
        AND document_downloaded < (NOW() - INTERVAL 1 MONTH)';
    $moreThanOneMonthStmt = $pdo->prepare($moreThanOneMonthQuery);
    $moreThanOneMonthStmt->execute(array( ':cid' => 1 ));
    $moreThanOneMonthPayrollCount = $moreThanOneMonthStmt->fetchColumn();
    $moreThanOneMonthStmt->execute(array( ':cid' => 2 ));
    $moreThanOneMonthInfoCount = $moreThanOneMonthStmt->fetchColumn();

    $notDownloadedQuery = 'SELECT
      COUNT(document_id)
      FROM document
      WHERE 
        document_downloaded IS NULL
        AND category_id = :cid';
    $notDownloadedStmt = $pdo->prepare($notDownloadedQuery);
    $notDownloadedStmt->execute(array( ':cid' => 1 ));
    $notDownloadedPayrollCount = $notDownloadedStmt->fetchColumn();
    $notDownloadedStmt->execute(array( ':cid' => 2 ));
    $notDownloadedInfoCount = $notDownloadedStmt->fetchColumn();
    
    $allQuery = 'SELECT
      COUNT(document_id)
      FROM document
      WHERE category_id = :cid';
    $allStmt = $pdo->prepare($allQuery);
    $allStmt->execute(array( ':cid' => 1 ));
    $allPayrollCount = $allStmt->fetchColumn();
    $allStmt->execute(array( ':cid' => 2 ));
    $allInfoCount = $allStmt->fetchColumn();
    
    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Delivery times have been calculated',
        'payroll' => array(
          'lastWeek' => $lastWeekPayrollCount / $allPayrollCount,
          'lastMonth' => $lastMonthPayrollCount / $allPayrollCount,
          'moreThanOneMonth' => $moreThanOneMonthPayrollCount / $allPayrollCount,
          'notDownloaded' => $notDownloadedPayrollCount / $allPayrollCount,
        ),
        'info' => array(
          'lastWeek' => $lastWeekInfoCount / $allInfoCount,
          'lastMonth' => $lastMonthInfoCount / $allInfoCount,
          'moreThanOneMonth' => $moreThanOneMonthInfoCount / $allInfoCount,
          'notDownloaded' => $notDownloadedInfoCount / $allInfoCount,
        )
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
