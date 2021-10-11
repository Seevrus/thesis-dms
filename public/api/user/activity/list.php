<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/db/activity/listUserActivity.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    $requestBody = json_decode(file_get_contents("php://input"));
    $companyName = $requestBody->companyName ?? array();
    $userRealName = $requestBody->userRealName ?? array();
    $categoryName = $requestBody->categoryName ?? array();
    $documentName = $requestBody->documentName ?? array();
    $added = $requestBody->added ?? array();
    $validUntil = $requestBody->validUntil ?? array();
    $downloaded = $requestBody->downloaded ?? array();

    $pdo = connectToDb();
    $userActivityJSON = listUserActivity(
      $pdo,
      $companyName,
      $userRealName,
      $categoryName,
      $documentName,
      $added,
      $validUntil,
      $downloaded,
    );

    $userActivity = json_decode($userActivityJSON);
    if ($userActivity->outcome == 'failure') {
        http_response_code(401);
    }
    echo $userActivityJSON;

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
