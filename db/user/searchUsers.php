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
        u.email_status AS emailStatus
      FROM user u
      JOIN company c ON u.company_code = c.company_id
      WHERE
        u.user_tax_number LIKE @searchString OR
        u.user_real_name LIKE @searchString OR
        u.user_email LIKE @searchString
      ORDER BY u.user_real_name
      LIMIT :lm';

    $fetchUserStmt = $pdo->prepare($fetchUserQuery);
    $fetchUserStmt->execute(array( ':lm' => $USER_LIMIT ));

    $fetchedUsers = $fetchUserStmt->fetchAll(PDO::FETCH_OBJ);
    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Users successfully fetched',
        'users' => $fetchedUsers,
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
