<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 5) . '/wp_api_utils/statusEnums.php';
require_once dirname(__FILE__, 5) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 5) . '/wp_db/connectToDb.php';
require_once dirname(__FILE__, 5) . '/wp_db/statistics/searchUsersSimple.php';
require_once dirname(__FILE__, 5) . '/wp_db/user/searchUsers.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    $requestBody = json_decode(file_get_contents("php://input"));

    if (!isset($requestBody->keyword) || !isset($requestBody->searchType)) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Invalid request formation!'
        )
      );
      exit(1);
    }

    $keyword = $requestBody->keyword;
    $searchType = $requestBody->searchType;

    // csrf and login protection
    if ($searchType == USER_SEARCH_TYPE::ALL) {
      $protectionProblem = protections(true, true, true, USER_PERMISSIONS::USER_ADMINISTRATOR);
      if ($protectionProblem) {
        http_response_code(403);
        echo $protectionProblem;
        exit(1);
      }
    } else if ($searchType == USER_SEARCH_TYPE::LAST_LOGIN) {
      $protectionProblem = protections(true, true, true, USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR);
      if ($protectionProblem) {
        http_response_code(403);
        echo $protectionProblem;
        exit(1);
      }
    }

    $pdo = connectToDb();

    if ($searchType == USER_SEARCH_TYPE::ALL) {
      $usersJSON = searchUsers($pdo, $keyword);
      $users = json_decode($usersJSON);
      if ($users->outcome == 'failure') {
        http_response_code(401);
      }
      echo $usersJSON;
    } else if ($searchType == USER_SEARCH_TYPE::LAST_LOGIN) {
      $usersJSON = searchUsersSimple($pdo, $keyword);
      $users = json_decode($usersJSON);
      if ($users->outcome == 'failure') {
        http_response_code(401);
      }
      echo $usersJSON;
    }

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
