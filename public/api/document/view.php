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
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/registerDocumentDownload.php';

header('Content-Type: application/json; charset=utf-8');

if (in_array($_SERVER['REQUEST_METHOD'], array('GET', 'HEAD'))) {
  try {
    $protectionProblem = protections(false, true, true, USER_PERMISSIONS::REGULAR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

      $documentId = $_GET["documentId"];

      if (!isset($documentId)) {
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
      $documentPathJSON = getDocumentPath($pdo, $_SESSION['taxNumber'], $documentId);
      $documentPath = json_decode($documentPathJSON);

      if ($documentPath->outcome == 'failure') {
        http_response_code(404);
        echo json_encode(
          array(
            'outcome' => 'failure',
            'message' => 'Document cannot be found',
          )
        );
        exit(1);
      }

      if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $registerDocumentAnswerJSON = registerDocumentDownload($pdo, $_SESSION['taxNumber'], $documentId);
        $registerDocumentAnswer = json_decode($registerDocumentAnswerJSON);

        if ($registerDocumentAnswer->outcome == 'failure') {
          http_response_code(401);
          echo json_encode(
            array(
              'outcome' => 'failure',
              'message' => 'Unexpected database issue',
            )
          );
          exit(1);
        }
      }

      $document = file_get_contents($documentPath->document_path);
      if (!$document) {
        http_response_code(404);
        echo json_encode(
          array(
            'outcome' => 'failure',
            'message' => 'Document cannot be found',
          )
        );
        exit(1);
      }

      header('Content-Type: application/pdf');
      echo($document);
        
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
