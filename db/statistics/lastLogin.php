<?php
function lastLogin(PDO $pdo, string $companyName): string {
  try {
    $lastWeekQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND u.user_last_login_attempt BETWEEN (NOW() - INTERVAL 7 DAY) AND NOW()
        AND u.user_status = 1';
    $lastWeekStmt = $pdo->prepare($lastWeekQuery);
    $lastWeekStmt->execute(array( ':cn' => $companyName ));
    $lastWeekCount = $lastWeekStmt->fetchColumn();
    
    $lastTwoWeeksQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND u.user_last_login_attempt BETWEEN (NOW() - INTERVAL 14 DAY) AND (NOW() - INTERVAL 7 DAY)
        AND u.user_status = 1';
    $lastTwoWeeksStmt = $pdo->prepare($lastTwoWeeksQuery);
    $lastTwoWeeksStmt->execute(array( ':cn' => $companyName ));
    $lastTwoWeeksCount = $lastTwoWeeksStmt->fetchColumn();
    
    $lastMonthQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND u.user_last_login_attempt BETWEEN (NOW() - INTERVAL 1 MONTH) AND (NOW() - INTERVAL 14 DAY)
        AND u.user_status = 1';
    $lastMonthStmt = $pdo->prepare($lastMonthQuery);
    $lastMonthStmt->execute(array( ':cn' => $companyName ));
    $lastMonthCount = $lastMonthStmt->fetchColumn();
    
    $lastTwoMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND u.user_last_login_attempt BETWEEN (NOW() - INTERVAL 2 MONTH) AND (NOW() - INTERVAL 1 MONTH)
        AND u.user_status = 1';
    $lastTwoMonthsStmt = $pdo->prepare($lastTwoMonthsQuery);
    $lastTwoMonthsStmt->execute(array( ':cn' => $companyName ));
    $lastTwoMonthsCount = $lastTwoMonthsStmt->fetchColumn();

    $lastThreeMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND u.user_last_login_attempt BETWEEN (NOW() - INTERVAL 3 MONTH) AND (NOW() - INTERVAL 2 MONTH)
        AND u.user_status = 1';
    $lastThreeMonthsStmt = $pdo->prepare($lastThreeMonthsQuery);
    $lastThreeMonthsStmt->execute(array( ':cn' => $companyName ));
    $lastThreeMonthsCount = $lastThreeMonthsStmt->fetchColumn();

    $lastSixMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE
        c.company_name LIKE :cn
        AND u.user_last_login_attempt BETWEEN (NOW() - INTERVAL 6 MONTH) AND (NOW() - INTERVAL 3 MONTH)
        AND u.user_status = 1';
    $lastSixMonthsStmt = $pdo->prepare($lastSixMonthsQuery);
    $lastSixMonthsStmt->execute(array( ':cn' => $companyName ));
    $lastSixMonthsCount = $lastSixMonthsStmt->fetchColumn();
    
    $moreThanSixMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE 
        c.company_name LIKE :cn
        AND u.user_last_login_attempt < (NOW() - INTERVAL 6 MONTH)
        AND u.user_status = 1';
    $moreThanSixMonthsStmt = $pdo->prepare($moreThanSixMonthsQuery);
    $moreThanSixMonthsStmt->execute(array( ':cn' => $companyName ));
    $moreThanSixMonthsCount = $moreThanSixMonthsStmt->fetchColumn();
    
    $allQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE 
        c.company_name LIKE :cn
        AND u.user_status = 1';
    $allStmt = $pdo->prepare($allQuery);
    $allStmt->execute(array( ':cn' => $companyName ));
    $allCount = $allStmt->fetchColumn();
    
    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Last login times have been calculated',
        'statistics' => array(
          'lastWeek' => $lastWeekCount / $allCount,
          'lastTwoWeeks' => $lastTwoWeeksCount / $allCount,
          'lastMonth' => $lastMonthCount / $allCount,
          'lastTwoMonths' => $lastTwoMonthsCount / $allCount,
          'lastThreeMonths' => $lastThreeMonthsCount / $allCount,
          'lastSixMonths' => $lastSixMonthsCount / $allCount,
          'moreThanSixMonths' => $moreThanSixMonthsCount / $allCount,
        ),
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
