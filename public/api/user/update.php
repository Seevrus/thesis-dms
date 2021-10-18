<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    // csrf and login protection
    $protectionProblem = protections(true, true, false, USER_PERMISSIONS::REGULAR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    $requestData = json_decode(file_get_contents("php://input"));
    // possible update cases: user real name, company, email, password, reset login attempts, update user status

    // request body validation
    if (empty($requestData->taxNumber)) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Invalid request formation!',
        )
      );
      exit(1);
    }

    $requestAnswer = array();
    $pdo = connectToDb();

    if ($requestData->userRealName) {
      require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/user_modifiers/userRealName.php';
      array_push($requestAnswer, $userRealNameModifyResult);
    }

    if (!!$requestData->companyName) {
      require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/user_modifiers/companyName.php';
      array_push($requestAnswer, $companyModifyResult);
    }

    if (!!$requestData->email) {
      require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/user_modifiers/email.php';
      array_push($requestAnswer, $emailModifyResult);
    }

    if (!!$requestData->password) {
      require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/user_modifiers/password.php';
      array_push($requestAnswer, $passwordModifyResult);
    }

    if ($requestData->attempts) {
      require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/user_modifiers/attempts.php';
      array_push($requestAnswer, $attemptsModifyResult);
    }

    echo(json_encode($requestAnswer));
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
