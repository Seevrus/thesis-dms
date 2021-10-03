<?php
// error_reporting(0);
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/db/activity/filter/saveFilter.php';
require_once dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json; charset=utf-8');

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

    $requestData = json_decode(file_get_contents("php://input"));
    if (!isset($requestData->filterName) || !isset($requestData->filter)) {
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
    $filterResponseJSON = saveFilter(
      $pdo, $decodedToken->taxNumber, $requestData->filterName, $requestData->filter
    );

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
