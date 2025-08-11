<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 5) . '/wp_api_utils/statusEnums.php';
require_once dirname(__FILE__, 5) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 5) . '/wp_db/connectToDb.php';
require_once dirname(__FILE__, 5) . '/wp_db/activity/filter/updateFilter.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    $requestData = json_decode(file_get_contents("php://input"));
    if (!isset($requestData->filterId) || !isset($requestData->filter)) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Invalid request formation!',
        )
      );
      exit(1);
    }

    $pdo = connectToDb();
    $filterResponseJSON = updateFilter($pdo, $requestData->filterId, $requestData->filter);

    $filterResponse = json_decode($filterResponseJSON);
    if ($filterResponse->outcome == 'failure') {
        http_response_code(401);
    }
    echo $filterResponseJSON;

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
