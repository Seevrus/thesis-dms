<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
date_default_timezone_set('Europe/Budapest');
header('Content-type: text/html; charset=utf-8');

function connectToDb(): PDO {
    $credentials = parse_ini_file(dirname(__FILE__, 3) . '/wp_db.ini');
    $options = [
      \PDO::ATTR_ERRMODE            => \PDO::ERRMODE_EXCEPTION,
      \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
      \PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    $dsn = 'mysql:host=' . $credentials['host'] .
           ';dbname=' . $credentials['db'] .
           ';charset=' . $credentials['charset'];
    try {
        $pdo = new PDO(
            $dsn,
            $credentials['user'],
            $credentials['password'],
            $options
        );
    } catch (PDOException $e) {
        throw new PDOException($e->getMessage(), (int)$e->getCode());
    }

    return $pdo;
}

// connect to database
$pdo = connectToDb();

// select all document ID-s
$selectDocumentIdsQuery = 'SELECT document_id, document_name FROM wp_document';
$selectDocumentIdsStmt = $pdo->query($selectDocumentIdsQuery);
$documentIds = $selectDocumentIdsStmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($documentIds as $row) {
	$document_id = $row["document_id"];
	$document_name = $row["document_name"];

	// based on the name
	if (str_contains($document_name, "2025. augusztus")) {
		// we generate a new date when it was added
		$added_stamp = 1756706400;
		$added = date("Y-m-d H:i:s", $added_stamp);
	} else if (str_contains($document_name, "2025. szeptember")) {
		$added_stamp = 1759298400;
		$added = date("Y-m-d H:i:s", $added_stamp);
	} else if (str_contains($document_name, "2025. október")) {
		$added_stamp = 1761980400;
		$added = date("Y-m-d H:i:s", $added_stamp);
	} else if (str_contains($document_name, "2025. november")) {
		$added_stamp = 1764572400;
		$added = date("Y-m-d H:i:s", $added_stamp);
	}

	// with 80% probability, we also generate a new date when it was downloaded
	if (mt_rand(1,100) > 20) {
		$downloadedAt = date("Y-m-d H:i:s", mt_rand($added_stamp, 1767164400));
	} else {
		$downloadedAt = NULL;
	}

	$decorateDocumentQuery = 'UPDATE wp_document SET document_added = :dad, document_downloaded = :ddn WHERE document_id = :did';
	$decorateDocumentStmt = $pdo->prepare($decorateDocumentQuery);
	$decorateDocumentStmt->execute(
		array(
			':dad' => $added,
			':ddn' => $downloadedAt,
			':did' => $document_id
		)
	);

	echo("Dokumentum módosítva: " . $document_name . ". Hozzáadva: " . $added . ", letöltve: " . $downloadedAt . "." . "\r\n");
}
