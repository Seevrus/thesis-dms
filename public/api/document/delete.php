<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/getDocumentPath.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/removeDocumentVisibility.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::REGULAR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    $documentIdentifiers = json_decode(file_get_contents("php://input"));

    if (!isset($documentIdentifiers->documentId)) {
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
    $documentPathJSON = removeDocumentVisibility($pdo, $_SESSION['taxNumber'], $documentIdentifiers->documentId);
    $documentPath = json_decode($documentPathJSON);

    if ($documentPath->outcome == 'failure') {
      http_response_code(401);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => $documentPath->message,
        )
      );
      exit(1);
    }

    // remove file from server
    $isDeleteSuccessful = unlink($documentPath->documentPath);

    if (!$isDeleteSuccessful) {
      http_response_code(401);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Document could not be deleted',
        )
      );
    } else {
      echo json_encode(
        array(
          'outcome' => 'success',
          'message' => 'Document has been deleted',
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
