<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/isLoggedin.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/createDocumentStub.php';

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

    $documentIdentifiers = json_decode(file_get_contents("php://input"));

    if (!isset($documentIdentifiers->taxNumber)
      || !isset($documentIdentifiers->documentName)
      || !isset($documentIdentifiers->category)
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

    $pdo = connectToDb();
    $validUntil = $documentIdentifiers->validUntil ?? 0;

    $createDocumentJSON = createDocumentStub(
      $pdo,
      $documentIdentifiers->taxNumber,
      $documentIdentifiers->documentName,
      $documentIdentifiers->category,
      $validUntil,
    );
    $createDocument = json_decode($createDocumentJSON);

    if ($modifyEmail->outcome == 'failure') {
      http_response_code(401);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Unexpected database error',
        )
      );
      exit(1);
    }

    echo json_encode(
      array(
        'outcome' => $createDocument->outcome,
        'message' => $createDocument->message,
        'id' => $createDocument->document_id,
        'token' => $createDocument->upload_code,
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
