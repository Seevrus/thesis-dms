<?php
function lastLogin(PDO $pdo): string {
  try {
    $lastWeekQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE
        user_last_login_attempt BETWEEN (NOW() - INTERVAL 7 DAY) AND NOW()
        AND user_status = 1';
    $lastWeekStmt = $pdo->query($lastWeekQuery);
    $lastWeekCount = $lastWeekStmt->fetchColumn();
    
    $lastTwoWeeksQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE
        user_last_login_attempt BETWEEN (NOW() - INTERVAL 14 DAY) AND (NOW() - INTERVAL 7 DAY)
        AND user_status = 1';
    $lastTwoWeeksStmt = $pdo->query($lastTwoWeeksQuery);
    $lastTwoWeeksCount = $lastTwoWeeksStmt->fetchColumn();
    
    $lastMonthQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE
        user_last_login_attempt BETWEEN (NOW() - INTERVAL 1 MONTH) AND (NOW() - INTERVAL 14 DAY)
        AND user_status = 1';
    $lastMonthStmt = $pdo->query($lastMonthQuery);
    $lastMonthCount = $lastMonthStmt->fetchColumn();
    
    $lastTwoMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE
        user_last_login_attempt BETWEEN (NOW() - INTERVAL 2 MONTH) AND (NOW() - INTERVAL 1 MONTH)
        AND user_status = 1';
    $lastTwoMonthsStmt = $pdo->query($lastTwoMonthsQuery);
    $lastTwoMonthsCount = $lastTwoMonthsStmt->fetchColumn();

    $lastThreeMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE
        user_last_login_attempt BETWEEN (NOW() - INTERVAL 3 MONTH) AND (NOW() - INTERVAL 2 MONTH)
        AND user_status = 1';
    $lastThreeMonthsStmt = $pdo->query($lastThreeMonthsQuery);
    $lastThreeMonthsCount = $lastThreeMonthsStmt->fetchColumn();

    $lastSixMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE
        user_last_login_attempt BETWEEN (NOW() - INTERVAL 6 MONTH) AND (NOW() - INTERVAL 3 MONTH)
        AND user_status = 1';
    $lastSixMonthsStmt = $pdo->query($lastSixMonthsQuery);
    $lastSixMonthsCount = $lastSixMonthsStmt->fetchColumn();
    
    $moreThanSixMonthsQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE 
        user_last_login_attempt < (NOW() - INTERVAL 6 MONTH)
        AND user_status = 1';
    $moreThanSixMonthsStmt = $pdo->query($moreThanSixMonthsQuery);
    $moreThanSixMonthsCount = $moreThanSixMonthsStmt->fetchColumn();
    
    $allQuery = 'SELECT
      COUNT(user_tax_number)
      FROM user
      WHERE user_status = 1';
    $allStmt = $pdo->query($allQuery);
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
