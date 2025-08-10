<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 4) . '/api_utils/statusEnums.php';
require_once dirname(__FILE__, 4) . '/auth_utils/protections.php';
require_once dirname(__FILE__, 4) . '/db/connectToDb.php';
require_once dirname(__FILE__, 4) . '/db/user/selectUser.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    $protectionProblem = protections(true, false, false, null);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    // Verify login
    $credentials = json_decode(file_get_contents("php://input"));

    // case 2: invalid form of request
    if (!isset($credentials->taxNumber) || !isset($credentials->password)) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Invalid request formation',
        )
      );
      exit(1);
    }

    $pdo = connectToDb();
    $fetchUserJSON
        = selectUser($pdo, $credentials->taxNumber, $credentials->password);
    $fetchUser = json_decode($fetchUserJSON);

    if ($fetchUser->outcome == 'success') {
      // Write login to server storage
      $_SESSION['taxNumber'] = $fetchUser->user_tax_number;
      $_SESSION['userRealName'] = $fetchUser->user_real_name;
      $userPermissions = array_map('mapDbUserPermission', $fetchUser->user_permissions);
      $_SESSION['userPermissions'] = $userPermissions;
      $dbEmailStatus = $fetchUser->email_status;
      $emailStatus = mapDbEmailStatus($dbEmailStatus);
      $_SESSION['userEmail'] = $fetchUser->user_email;
      $_SESSION['emailStatus'] = $emailStatus;
      $_SESSION['companyName'] = $fetchUser->company_name;
      $expires = time() + 900;
      $_SESSION['expires'] = $expires;

      if ($emailStatus == EMAIL_STATUS::NO_EMAIL) {
        // case 1: no email address present, 
        // user should register one
        echo json_encode(
          array(
            'outcome' => 'pending',
            'loginStatus' => LOGIN_STATUS::LOGGED_IN,
            'emailStatus' => EMAIL_STATUS::NO_EMAIL,
            'message' => 'User should register an email address',
            'taxNumber' => $fetchUser->user_tax_number,
            'userPermissions' => array(),
            'expires' => $expires,
          )
        );
      } elseif ($emailStatus == EMAIL_STATUS::NOT_VALIDATED) {
        // case 2: email address is not yet validated, 
        // user should present the validation code
        echo json_encode(
          array(
            'outcome' => 'pending',
            'loginStatus' => LOGIN_STATUS::LOGGED_IN,
            'emailStatus' => EMAIL_STATUS::NOT_VALIDATED,
            'message' => 'User should validate their email address',
            'taxNumber' => $fetchUser->user_tax_number,
            'userPermissions' => array(),
            'expires' => $expires,
          )
        );
      } else {
        // case 3: valid email address is present, 
        // user is considered to be logged in
        echo json_encode(
          array(
            'outcome' => 'success',
            'loginStatus' => LOGIN_STATUS::LOGGED_IN,
            'emailStatus' => EMAIL_STATUS::VALID_EMAIL,
            'message' => 'User successfully logged in',
            'taxNumber' => $fetchUser->user_tax_number,
            'userRealName' => $fetchUser->user_real_name,
            'userEmail' => $fetchUser->user_email,
            'userPermissions' => $userPermissions,
            'companyName' => $fetchUser->company_name,
            'expires' => $expires,
          )
        );
      }
    } else {
        http_response_code(403);
        echo $fetchUserJSON;
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(
      array(
        'outcome' => 'failure',
        'message' => 'Service temporary unavailable',
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
