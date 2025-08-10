<?php
function searchUsers(PDO $pdo, string $query): string {
  try {
    $USER_LIMIT = 10;

    // do some clean-up
    $query = htmlspecialchars($query, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $setQueryQuery = 'SET @searchString = :qry';
    $setQueryStmt = $pdo->prepare($setQueryQuery);
    $setQueryStmt->execute(array( ':qry' => "%$query%" ));

    $fetchUserQuery = 'SELECT
        u.user_tax_number AS taxNumber,
        c.company_name AS companyName,
        u.user_status AS userStatus,
        u.user_real_name AS userRealName,
        u.user_email AS userEmail,
        u.email_status AS emailStatus,
        u.user_login_attempt,
        u.user_last_login_attempt
      FROM wp_user u
      JOIN wp_company c ON u.company_code = c.company_id
      WHERE
        u.user_tax_number LIKE @searchString OR
        u.user_real_name LIKE @searchString OR
        u.user_email LIKE @searchString
      ORDER BY u.user_real_name
      LIMIT :lm';

    $fetchUserStmt = $pdo->prepare($fetchUserQuery);
    $fetchUserStmt->execute(array( ':lm' => $USER_LIMIT ));

    // obtain user permissions
    $userPermissionsQuery = 'SELECT
      *
    FROM wp_user_permissions
    WHERE user_tax_number = :utn';
    $userPermissionsStmt = $pdo->prepare($userPermissionsQuery);

    $usersResult = array();
    while ($user = $fetchUserStmt->fetch(PDO::FETCH_ASSOC)) {
      $userPermissionsStmt->execute(array( ':utn' => $user["taxNumber"]));
      $userPermissionRows = $userPermissionsStmt->fetchAll(PDO::FETCH_ASSOC);
      $userPermissions = array();
      foreach ($userPermissionRows as $row) {
        array_push($userPermissions, mapDbUserPermission($row['user_permission']));
      }

      $extendedUser = $user; // PHP copies the array by default
      $extendedUser["userStatus"] = mapDbUserStatus($user["userStatus"]);
      $extendedUser["emailStatus"] = mapDbEmailStatus($user["emailStatus"]);
      $extendedUser["userPermissions"] = $userPermissions;
      
      // is user locked out?
      $MAX_ATTEMPTS_PER_TIMESPAN = 3;
      if ($user["user_login_attempt"] <= $MAX_ATTEMPTS_PER_TIMESPAN) {
        $extendedUser["lockedOut"] = false;
      } else {
        $MAX_ATTEMPT_TIMESPAN_HOURS = 1;
        $lastTrialTimestamp = strtotime($user["user_last_login_attempt"]);
        $now = time();
        $hoursSinceLastTrial = abs($now - $lastTrialTimestamp)/(60*60);
        if ($hoursSinceLastTrial > $MAX_ATTEMPT_TIMESPAN_HOURS) {
          $extendedUser["lockedOut"] = false;
        } else {
          $extendedUser["lockedOut"] = true;
        }
      }
      unset($extendedUser["user_login_attempt"]);
      unset($extendedUser["user_last_login_attempt"]);

      $usersResult[] = $extendedUser;
    }

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Users successfully fetched',
        'users' => $usersResult,
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
