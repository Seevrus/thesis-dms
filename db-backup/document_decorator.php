<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);
date_default_timezone_set('Europe/Budapest');
header('Content-type: text/html; charset=utf-8');

function connectToDb(): PDO
{
    $credentials = parse_ini_file(dirname(dirname(__FILE__)) . '/db.ini');
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
$selectDocumentIdsQuery = 'SELECT document_id, document_name FROM documents';
$selectDocumentIdsStmt = $pdo->query($selectDocumentIdsQuery);
$documentIds = $selectDocumentIdsStmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($documentIds as $row) {
	$document_id = $row["document_id"];
	$document_name = $row["document_name"];
	
	// based on the name
	if (str_contains("2021. augusztus", $document_name)) {
		// we generate a new date when it was added
		$added = date("Y-m-d H:i:s", 1630807200);
	} else if (str_contains("2021. szeptember", $document_name)) {
		$added = date("Y-m-d H:i:s", 1633399200);
	} else if (str_contains("2021. október", $document_name)) {
		$added = date("Y-m-d H:i:s", 1636081200);
	} else if (str_contains("2021. november", $document_name)) {
		$added = date("Y-m-d H:i:s", 1638327600);
	}
	
	// with 70% probability, we also generate a new date when it was downloaded
	if (mt_rand(1,100) > 70) {
		$downloadedAt = date("Y-m-d H:i:s", mt_rand($added, 1639155600));
	} else {
		$downloadedAt = NULL;
	}
	
	$decorateDocumentQuery = 'UPDATE documents SET document_added = :dad, document_downloaded = :ddn WHERE document_id = :did';
	$decorateDocumentStmt = $pdo->prepare($decorateDocumentQuery);
	$decorateDocumentStmt->execute(
		array(
			':dad' => $added,
			':ddn' => $downloadedAt,
			':did' => $document_id
		)
	);
	
	echo("Dokumentum módosítva: " . $document_name . ". Hozzáadva: " . $added . ", letöltve: " . $downloadedAt . ".\r\n");
}
?>
