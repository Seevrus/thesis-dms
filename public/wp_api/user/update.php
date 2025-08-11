<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 4) . '/wp_api_utils/statusEnums.php';
require_once dirname(__FILE__, 4) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 4) . '/wp_db/connectToDb.php';

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
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/userRealName.php';
      $requestAnswer[] = $userRealNameModifyResult;
    }

    if (!!$requestData->companyName) {
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/companyName.php';
      $requestAnswer[] = $companyModifyResult;
    }

    if (!!$requestData->userStatus) {
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/userStatus.php';
      $requestAnswer[] = $userStatusModifyResult;
    }

    if (!!$requestData->userEmail) {
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/email.php';
      $requestAnswer[] = $emailModifyResult;
    }

    if (!!$requestData->emailStatus) {
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/emailStatus.php';
      $requestAnswer[] = $emailStatusModifyResult;
    }

    if (!!$requestData->password) {
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/password.php';
      $requestAnswer[] = $passwordModifyResult;
    }

    if ($requestData->attempts) {
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/attempts.php';
      array_push($requestAnswer, $attemptsModifyResult);
    }

    if (array_key_exists('userPermissions', $requestData)) {
      require_once dirname(__FILE__, 4) . '/wp_api_utils/user_modifiers/userPermissions.php';
      array_push($requestAnswer, $userPermissionsModifyResult);
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
