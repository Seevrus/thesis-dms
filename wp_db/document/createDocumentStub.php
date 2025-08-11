<?php
require_once dirname(__FILE__, 3) . '/wp_api_utils/generateRandomString.php';

function createDocumentStub(
  PDO $pdo,
  string $taxNumber,
  string $documentName,
  int $category,
  int $validUntil = 0
) : string
{
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $documentName = htmlspecialchars($documentName, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $validUntil = htmlspecialchars($validUntil, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $documentQuery = 'INSERT
      INTO wp_document (
        user_tax_number,
        document_name,
        category_id,
        document_visible,
        document_valid
      )
      VALUES (
        :did,
        :dname,
        :dcateg,
        :dvis,
        :dvalid
      )';
    $documentStmt = $pdo->prepare($documentQuery);
    $documentStmt->execute(
      array(
        ':did' => $taxNumber,
        ':dname' => $documentName,
        ':dcateg' => $category,
        ':dvis' => 0,
        ':dvalid' => $validUntil == 0 ? null : date("Y-m-d H:i:s", $validUntil),
      )
    );

    $documentId = $pdo->lastInsertId();

    // enable file upload to this record via a token
    $documentUploadCode = generateRandomString();
    $codeQuery = 'INSERT
      INTO wp_document_code (
        document_id,
        upload_code
      )
      VALUES (
        :did,
        :dcode
      )';
    $codeStmt = $pdo->prepare($codeQuery);
    $codeStmt->execute(
      array(
        ':did' => $documentId,
        ':dcode' => $documentUploadCode,
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Document successfully created',
        'document_id' => $documentId,
        'upload_code' => $documentUploadCode,
      )
    );
  } catch (PDOException $e) {
    return json_encode(
      array(
        'outcome' => 'failure',
        'message' => $e->getMessage(),
      )
    );
  }
}
