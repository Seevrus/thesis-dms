<?php
date_default_timezone_set('Europe/Budapest');

function registerDocumentDownload(PDO $pdo, string $taxNumber, string $documentId) : string
{
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $documentId = htmlspecialchars($documentId, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    $fetchQuery = 'SELECT
        document_downloaded
      FROM document
      WHERE
        user_tax_number = :utn
        AND document_id = :did';
    $fetchQueryStmt = $pdo->prepare($fetchQuery);
    $fetchQueryStmt->execute(
      array(
        ':utn' => $taxNumber,
        ':did' => $documentId,
      )
    );
    $documentRow = $fetchQueryStmt->fetch(PDO::FETCH_ASSOC);

    // If not already registered, the register it
    if (is_null($documentRow['document_downloaded'])) {
      $registerQuery = 'UPDATE
          document
        SET
          document_downloaded = :dnow
        WHERE
          document_id = :did';
      $registerQueryStmt = $pdo->prepare($registerQuery);
      $registerQueryStmt->execute(
        array(
          ':dnow' => date("Y-m-d H:i:s"),
          ':did' => $documentId,
        )
      );
    }

    return json_encode(
      array(
        'outcome' => 'success',
        'message' => 'Registration successful',
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
?>
