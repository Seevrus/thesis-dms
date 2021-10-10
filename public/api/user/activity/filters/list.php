<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/auth_utils/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/auth_utils/isLoggedin.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/db/activity/filter/listFilters.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
  try {
    // CSRF Protection
    if (!checkCsrfToken()) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to access this page!',
        )
      );
      exit(1);
    }

    // Verify login
    if (!isLoggedin()) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to access this page!',
        )
      );
      exit(1);
    }
  
    // check user permission
    if (!in_array(USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR, $_SESSION['userPermissions'])) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to access this page!'
        )
      );
      exit(1);
    }

    $pdo = connectToDb();
    $filtersJSON = listFilters($pdo, $_SESSION['taxNumber']);

    $filters = json_decode($filtersJSON);
    if ($filters->outcome == 'failure') {
        http_response_code(401);
    }
    echo $filtersJSON;

    } catch (Exception $e) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Service temporary unavailable'
        )
      );
    }
} else {
  http_response_code(405);
  echo json_encode(
    array(
      'outcome' => 'error',
      'message' => 'Method not allowed',
    )
  );
}
?>
