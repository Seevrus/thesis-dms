<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
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

function str_contains($haystack, $needle): bool {
	return $needle !== '' && mb_strpos($haystack, $needle) !== false;
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
	if (str_contains($document_name, "2022. január")) {
		// we generate a new date when it was added
		$added_stamp = 1643612400;
		$added = date("Y-m-d H:i:s", $added_stamp);
	} else if (str_contains($document_name, "2022. február")) {
		$added_stamp = 1646031600;
		$added = date("Y-m-d H:i:s", $added_stamp);
	} else if (str_contains($document_name, "2022. március")) {
		$added_stamp = 1648706400;
		$added = date("Y-m-d H:i:s", $added_stamp);
	} else if (str_contains($document_name, "2022. április")) {
		$added_stamp = 1651298400;
		$added = date("Y-m-d H:i:s", $added_stamp);
	}
	
	// with 80% probability, we also generate a new date when it was downloaded
	if (mt_rand(1,100) > 20) {
		$downloadedAt = date("Y-m-d H:i:s", mt_rand($added_stamp, 1651644000));
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
