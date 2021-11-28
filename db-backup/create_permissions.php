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

if (($handle = fopen("MockPermissions.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
        $user_tax_number = $data[0];
		$permission = $data[1];
		
		$insertUserQuery = 'INSERT
		  INTO user_permissions (
		    user_tax_number,
			user_permission
		  ) VALUES (
		    :utn,
			:up
		  )';
		$insertUserStmt = $pdo->prepare($insertUserQuery);
		$insertUserStmt->execute(
		  array(
		    ':utn' => $user_tax_number,
			':up' => $permission
		  )
		);
		
		echo("Jogosultság hozzáadva: " . $user_tax_number . ": " . $permission . "\r\n");
    }
    fclose($handle);
}
?>
