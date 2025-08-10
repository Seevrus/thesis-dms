<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 4) . '/api_utils/statusEnums.php';
require_once dirname(__FILE__, 4) . '/auth_utils/protections.php';
require_once dirname(__FILE__, 4) . '/db/connectToDb.php';
require_once dirname(__FILE__, 4) . '/db/statistics/averageDelivery.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    // csrf and login protection
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    $queryParams = json_decode(file_get_contents("php://input"));
    $companyName = $queryParams->companyName ?? '%';

    $pdo = connectToDb();
    $lastLoginJSON = averageDelivery($pdo, $companyName);
    $lastLogin = json_decode($lastLoginJSON);
    if ($lastLogin->outcome == 'failure') {
      http_response_code(401);
    }

    echo $lastLoginJSON;

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
