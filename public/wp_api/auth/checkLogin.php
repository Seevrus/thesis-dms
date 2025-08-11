<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 4) . '/wp_api_utils/statusEnums.php';
require_once dirname(__FILE__, 4) . '/wp_auth_utils/isLoggedin.php';

header('Content-Type: application/json; charset=utf-8');

if (in_array($_SERVER['REQUEST_METHOD'], array('GET', 'HEAD'))) {
  $loggedIn = isLoggedin();

  if ($loggedIn) {
    echo json_encode(
      array(
        'outcome' => 'success',
        'loginStatus' => LOGIN_STATUS::LOGGED_IN,
        'userPermissions' => $_SESSION['userPermissions'],
        'userEmail' => $_SESSION['userEmail'],
        'emailStatus' => $_SESSION['emailStatus'],
        'message' => 'User is currently logged in',
        'taxNumber' => $_SESSION['taxNumber'],
        'userRealName' => $_SESSION['userRealName'],
        'companyName' => $_SESSION['companyName'],
        'expires' => $_SESSION['expires'],
      )
    );
  } else {
    echo json_encode(
      array(
        'outcome' => 'success',
        'loginStatus' => LOGIN_STATUS::NOT_LOGGED_IN,
        'message' => 'User is currently not logged in'
      )
    );
  }
} else {
  http_response_code(405);
  echo json_encode(
    array(
      'outcome' => 'failure',
      'message' => 'Method not allowed',
    )
  );
}
