<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/generateRandomString.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/saveFile.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/isLoggedin.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/registerUploadedDocument.php';

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
  
    // check user permission
    if (!in_array(USER_PERMISSIONS::DOCUMENT_CREATOR, $_SESSION['userPermissions'])) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to access this page!'
        )
      );
      exit(1);
    }

    if (!isset($_SERVER['HTTP_X_DOCUMENT_ID'])
      || !isset($_SERVER['HTTP_X_UPLOAD_TOKEN'])
    ) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Invalid request formation!'
        )
      );
      exit(1);
    }
    $documentId = $_SERVER['HTTP_X_DOCUMENT_ID'];
    $uploadToken = $_SERVER['HTTP_X_UPLOAD_TOKEN'];

    if ($_SERVER['CONTENT_TYPE'] == 'application/pdf') {
      $fileType = 'application/pdf';
      $targetLocation = saveFile('php://input');
    } else {
      $fileType = 'NOT_ALLOWED';
    }

    if ($fileType != 'application/pdf') {
      unlink($targetLocation);
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'File type not allowed',
          'fileType' => $_SERVER['CONTENT_TYPE'],
        )
      );
      exit(1);
    }

    $pdo = connectToDb();
    $registerUploadedDocumentJSON = registerUploadedDocument($pdo, $uploadToken, $documentId, $targetLocation);
    $registerUploadedDocument = json_decode($registerUploadedDocumentJSON);

    if ($registerUploadedDocument->outcome == 'failure') {
      unlink($targetLocation);
      http_response_code(401);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => $registerUploadedDocument->message,
        )
      );
    } else {
      echo json_encode(
        array(
          'outcome' => 'success',
          'message' => 'File uploaded successfully',
        )
      );
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
?>
