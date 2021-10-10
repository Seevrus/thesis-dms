<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/user/validateEmail.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
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

    $credentials = json_decode(file_get_contents("php://input"));

    if (!isset($credentials->emailCode)) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Invalid request formation!'
        )
      );
      exit(1);
    }

    $pdo = connectToDb();
    $validateEmailJSON = validateEmail(
      $pdo,
      $_SESSION['taxNumber'],
      $credentials->emailCode,
    );

    $validateEmail = json_decode($validateEmailJSON);

    if ($validateEmail->outcome == 'failure') {
      http_response_code(401);
      echo $validateEmailJSON;
      exit(1);
    }

    // Register new email status
    $emailStatus = mapDbEmailStatus($validateEmail->email_status);
    $_SESSION['emailStatus'] = $emailStatus;

    echo json_encode(
      array(
        'outcome' => $validateEmail->outcome,
        'message' => $validateEmail->message,
        'emailStatus' => $emailStatus,
      )
    );

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
