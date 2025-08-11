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

// connect to database
$pdo = connectToDb();

if (($handle = fopen("MockUsers.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
        $user_tax_number = $data[0];
		$company_code = $data[1];
		$user_status = $data[2];
		$user_real_name = $data[3];
		$user_email = $data[4];
		$email_status = $data[5];
		$user_password = empty($data[6]) ? NULL : password_hash($data[6], PASSWORD_DEFAULT);
		$user_login_attempt = $data[7];
		$user_last_login_attempt = $data[8];
		
		$insertUserQuery = 'INSERT
		  INTO wp_user (
		    user_tax_number,
			company_code,
			user_status,
			user_real_name,
			user_email,
			email_status,
			user_password,
			user_login_attempt,
			user_last_login_attempt
		  ) VALUES (
		    :utn,
			:cc,
			:ust,
			:un,
			:uem,
			:est,
			:pwd,
			:ula,
			:ulla
		  )';

		$insertUserStmt = $pdo->prepare($insertUserQuery);

        try {
            $insertUserStmt->execute(
                array(
                    ':utn' => $user_tax_number,
                    ':cc' => $company_code,
                    ':ust' => $user_status,
                    ':un' => $user_real_name,
                    ':uem' => empty($user_email) ? NULL : $user_email,
                    ':est' => $email_status,
                    ':pwd' => $user_password,
                    ':ula' => $user_login_attempt,
                    ':ulla' => empty($user_last_login_attempt) ? NULL : $user_last_login_attempt
                )
            );

            echo("Felhasználó hozzáadva: " . $user_real_name . " (" . $user_tax_number . ")\r\n");
        } catch (PDOException $e) {
            echo $e->getMessage() . "<br>";
        }
    }
    fclose($handle);
} else {
    echo "Fájl nem található";
}
