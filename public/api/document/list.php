<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/protections.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/selectDocuments.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $DOCUMENTS_TO_FETCH = 10;
  
  try {
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::REGULAR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
      exit(1);
    }

    $pdo = connectToDb();
    $requestBody = file_get_contents("php://input");
    if ($requestBody) {
      $queryParams = json_decode($requestBody);
      $fetchFrom = property_exists($queryParams, 'fetchFrom')
        ? $queryParams->fetchFrom
        : 0;
      $category = property_exists($queryParams, 'category')
        ? $queryParams->category
        : null;
    } else {
      $fetchFrom = 0;
      $category = null;
    }
    
    $selectedDocumentsJSON = selectDocuments(
      $pdo,
      $_SESSION['taxNumber'],
      $category,
      $fetchFrom,
      $DOCUMENTS_TO_FETCH
    );

    $selectedDocuments = json_decode($selectedDocumentsJSON);
    if ($selectedDocuments->outcome == 'failure') {
      http_response_code(401);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Unexpected database error',
        )
      );
      exit(1);
    }

    echo $selectedDocumentsJSON;

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
