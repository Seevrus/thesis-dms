<?php
function registerUploadedDocument(
  PDO $pdo,
  string $uploadToken,
  string $documentId,
  string $targetLocation
) : string {
  try {
    // do some clean-up
    $uploadToken = htmlspecialchars($uploadToken, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $documentId = htmlspecialchars($documentId, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $targetLocation = htmlspecialchars($targetLocation, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $documentCheckerQuery = 'SELECT
      *
      FROM wp_document_code
      WHERE
        document_id = :did
        AND upload_code = :dcode';
    $documentCheckerStmt = $pdo->prepare($documentCheckerQuery);
    $documentCheckerStmt->execute(
      array(
        ':did' => $documentId,
        ':dcode' => $uploadToken,
      )
    );
    $documentCheckerRow = $documentCheckerStmt->fetch(PDO::FETCH_ASSOC);

    // if uploadToken is not present
    if (!$documentCheckerRow) {
      return json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to upload this document',
        )
      );
    }

    // delete upload token from database
    $documentCheckerCleanUpQuery = 'DELETE
      FROM wp_document_code
      WHERE
        document_id = :did
        AND upload_code = :dcode';
    $documentCheckerCleanUpStmt = $pdo->prepare($documentCheckerCleanUpQuery);
    $documentCheckerCleanUpStmt->execute(
      array(
        ':did' => $documentId,
        ':dcode' => $uploadToken,
      )
    );

    // save path in database
    $documentQuery = 'UPDATE
        wp_document
      SET
        document_path = :dpath,
        document_visible = 1
      WHERE document_id = :did';
    $docuemntStmt = $pdo->prepare($documentQuery);
    $docuemntStmt->execute(
      array(
        ':did' => $documentId,
        ':dpath' => $targetLocation,
      )
    );

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Document successfully uploaded',
      )
    );
  } catch (PDOException $e) {
    return json_encode(
      array(
        'outcome' => 'failure',
        'message' => 'Unexpected database error',
      )
    );
  }
}
