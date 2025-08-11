<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(__FILE__, 4) . '/wp_api_utils/statusEnums.php';
require_once dirname(__FILE__, 4) . '/wp_auth_utils/protections.php';
require_once dirname(__FILE__, 4) . '/wp_db/connectToDb.php';
require_once dirname(__FILE__, 4) . '/wp_db/document/createDocumentStub.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    $protectionProblem = protections(true, true, true, USER_PERMISSIONS::DOCUMENT_CREATOR);
    if ($protectionProblem) {
      http_response_code(403);
      echo $protectionProblem;
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
