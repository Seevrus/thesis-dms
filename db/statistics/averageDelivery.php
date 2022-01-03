<?php
function averageDelivery(PDO $pdo, string $companyName): string {
  try {
    $lastWeekQuery = 'SELECT
        COUNT(document_id)
      FROM document d
      JOIN user u ON d.user_tax_number = u.user_tax_number
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND d.document_downloaded IS NOT NULL
        AND d.category_id = :cid
        AND d.document_downloaded BETWEEN (NOW() - INTERVAL 7 DAY) AND NOW()';
    $lastWeekStmt = $pdo->prepare($lastWeekQuery);
    $lastWeekStmt->execute(
      array(
        ':cid' => 1,
        ':cn' => $companyName,
      )
    );
    $lastWeekPayrollCount = $lastWeekStmt->fetchColumn();
    $lastWeekStmt->execute(
      array(
        ':cid' => 2,
        ':cn' => $companyName,
      )
    );
    $lastWeekInfoCount = $lastWeekStmt->fetchColumn();
    
    $lastMonthQuery = 'SELECT
        COUNT(document_id)
      FROM document d
      JOIN user u ON d.user_tax_number = u.user_tax_number
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND d.document_downloaded IS NOT NULL
        AND d.category_id = :cid
        AND d.document_downloaded BETWEEN (NOW() - INTERVAL 1 MONTH) AND (NOW() - INTERVAL 7 DAY)';
    $lastMonthStmt = $pdo->prepare($lastMonthQuery);
    $lastMonthStmt->execute(
      array(
        ':cid' => 1,
        ':cn' => $companyName,
      )
    );
    $lastMonthPayrollCount = $lastMonthStmt->fetchColumn();
    $lastMonthStmt->execute(
      array(
        ':cid' => 2,
        ':cn' => $companyName,
      )
    );
    $lastMonthInfoCount = $lastMonthStmt->fetchColumn();
    
    $moreThanOneMonthQuery = 'SELECT
        COUNT(document_id)
      FROM document d
      JOIN user u ON d.user_tax_number = u.user_tax_number
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND d.document_downloaded IS NOT NULL
        AND d.category_id = :cid
        AND d.document_downloaded < (NOW() - INTERVAL 1 MONTH)';
    $moreThanOneMonthStmt = $pdo->prepare($moreThanOneMonthQuery);
    $moreThanOneMonthStmt->execute(
      array(
        ':cid' => 1,
        ':cn' => $companyName,
      )
    );
    $moreThanOneMonthPayrollCount = $moreThanOneMonthStmt->fetchColumn();
    $moreThanOneMonthStmt->execute(
      array(
        ':cid' => 2,
        ':cn' => $companyName,
      )
    );
    $moreThanOneMonthInfoCount = $moreThanOneMonthStmt->fetchColumn();

    $notDownloadedQuery = 'SELECT
        COUNT(document_id)
      FROM document d
      JOIN user u ON d.user_tax_number = u.user_tax_number
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND d.document_downloaded IS NULL
        AND d.category_id = :cid';
    $notDownloadedStmt = $pdo->prepare($notDownloadedQuery);
    $notDownloadedStmt->execute(
      array(
        ':cid' => 1,
        ':cn' => $companyName,
      )
    );
    $notDownloadedPayrollCount = $notDownloadedStmt->fetchColumn();
    $notDownloadedStmt->execute(
      array(
        ':cid' => 2,
        ':cn' => $companyName,
      )
    );
    $notDownloadedInfoCount = $notDownloadedStmt->fetchColumn();
    
    $allQuery = 'SELECT
        COUNT(document_id)
      FROM document d
      JOIN user u ON d.user_tax_number = u.user_tax_number
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND d.category_id = :cid';
    $allStmt = $pdo->prepare($allQuery);
    $allStmt->execute(
      array(
        ':cid' => 1,
        ':cn' => $companyName,
      )
    );
    $allPayrollCount = $allStmt->fetchColumn();
    $allStmt->execute(
      array(
        ':cid' => 2,
        ':cn' => $companyName,
      )
    );
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
