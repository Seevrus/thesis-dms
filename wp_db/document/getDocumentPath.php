<?php
function getDocumentPath(PDO $pdo, string $taxNumber, string $documentId) : string {
  try {
      // do some clean-up
      $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
      $documentId = htmlspecialchars($documentId, ENT_COMPAT | ENT_HTML401, 'UTF-8');

      $fetchQuery = 'SELECT
          document_path
        FROM wp_document 
        WHERE
          document_id = :did
          AND document_visible = :dvis
          AND user_tax_number = :utn';
      $fetchQueryStmt = $pdo->prepare($fetchQuery);
      $fetchQueryStmt->execute(
        array(
          ':utn' => $taxNumber,
          ':dvis' => 1,
          ':did' => $documentId,
        )
      );
      $documentRow = $fetchQueryStmt->fetch(PDO::FETCH_ASSOC);

      if (!$documentRow) {
        return json_encode(
          array(
            'outcome' => 'failure',
            'message' => 'Document cannot be found',
          )
        );
      }

      return json_encode(
        array(
          'outcome' => 'success',
          'message' => 'Document path has been found',
          'document_path' => $documentRow['document_path'],
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
