<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  setcookie(session_name(), "", time() - 3600); //send browser command remove session id from cookie
	session_unset();
	session_destroy(); //remove session id login from server storage
	session_write_close();

  echo json_encode(
    array(
      'outcome' => 'success',
      'message' => 'Successfully logged out.',
      'loginStatus' => LOGIN_STATUS::NOT_LOGGED_IN,
    )
  );
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
