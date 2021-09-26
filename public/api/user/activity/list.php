<?php
error_reporting(0);
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/db/activity/listUserActivity.php';
require_once dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
// CSRF Protection
if (!checkCsrfToken()) {
  http_response_code(403);
    echo json_encode(
      array(
        'outcome' => 'failure',
        'message' => 'You do not have permission to access this page!'
      )
    );
} else {
  try {
    // check token validity
    $token = $_COOKIE['token'];
    $decodedToken = jwtDecode($token);
    // end of validation

    // check user permission
    if (!in_array(USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR, $decodedToken->userPermissions)) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to access this page!',
        )
      );
      exit(1);
  }
  // end of checking user permission

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
        'message' => 'You do not have permission to access this page!'
      )
    );
  }
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
