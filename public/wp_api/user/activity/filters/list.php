<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 6) . '/wp_api_utils/statusEnums.php';
require_once dirname(__FILE__, 6) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 6) . '/wp_db/connectToDb.php';
require_once dirname(__FILE__, 6) . '/wp_db/activity/filter/listFilters.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
  try {
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
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
