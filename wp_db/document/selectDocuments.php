<?php
date_default_timezone_set('Europe/Budapest');

function selectDocuments(
  PDO $pdo,
  string $taxNumber,
  int $category = null,
  int $fetchFrom = 0,
  int $limit = 10
) : string {
  try {
    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $category = htmlspecialchars($category, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $fetchFrom = htmlspecialchars($fetchFrom, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $limit = htmlspecialchars($limit, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    if (empty($category)) {
        $fetchQuery = 'SELECT
            d.document_id AS id,
            d.document_name AS title,
            c.category_name AS category,
            d.document_added AS added,
            d.document_downloaded AS downloadedAt,
            d.document_valid AS validUntil
          FROM wp_document d
          JOIN wp_document_category c ON d.category_id = c.category_id
          WHERE
            d.user_tax_number = :utn
            AND document_visible = :dvis
            AND (ISNULL(d.document_valid)
            OR d.document_valid > NOW())
          ORDER BY added DESC
          LIMIT :dfrom, :dto';
        $fetchQueryStmt = $pdo->prepare($fetchQuery);
        $fetchQueryStmt->execute(
          array(
            ':utn' => $taxNumber,
            ':dvis' => 1,
            ':dfrom' => $fetchFrom,
            ':dto' => $limit,
          )
        );
    } else {
      $fetchQuery = 'SELECT
          d.document_id AS id,
          d.document_name AS title,
          c.category_name AS category,
          d.document_added AS added,
          d.document_downloaded AS downloadedAt,
          d.document_valid AS validUntil
        FROM wp_document d
        JOIN wp_document_category c ON d.category_id = c.category_id
        WHERE
          d.user_tax_number = :utn
          AND d.category_id = cid
          AND document_visible = :dvis
          AND (ISNULL(d.document_valid)
          OR d.document_valid > NOW())
        ORDER BY added
        LIMIT :dfrom, :dto';
      $fetchQueryStmt = $pdo->prepare($fetchQuery);
      $fetchQueryStmt->execute(
        array(
          ':utn' => $taxNumber,
          ':cid' => $category,
          ':dvis' => 1,
          ':dfrom' => $fetchFrom,
          ':dto' => $limit,
        )
      );
    }

    $fetchedDocuments = $fetchQueryStmt->fetchAll(PDO::FETCH_OBJ);
    return json_encode(
      array(
        'outcome' => 'success',
        'documents' => $fetchedDocuments,
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
