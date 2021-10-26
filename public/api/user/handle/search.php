<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/db/user/searchUsers.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
  try {
    // csrf and login protection
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::USER_ADMINISTRATOR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    $searchString = $_GET["keyword"];
    $pdo = connectToDb();

    $usersJSON = searchUsers($pdo, $searchString);
    $users = json_decode($usersJSON);
    if ($users->outcome == 'failure') {
      http_response_code(401);
    }
    echo $usersJSON;

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
