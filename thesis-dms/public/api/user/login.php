<?php
function getSecretKey()
{
    $keyFileContent = parse_ini_file('../../../key.ini');
    return $keyFileContent['secret_key'];
}

header('Content-Type: application/json');

// Verify login
require_once '../../db/connectToDb.php';
require_once '../../db/selectUser.php';
$data = json_decode(file_get_contents("php://input"));
$pdo = connectToDb();
$isLoginValid = selectUser($pdo, $data->taxId, $data->password);

use Firebase\JWT\JWT;
if ($isLoginValid) {
    // Issue Token
    include_once '../../../vendor/autoload.php';

    $issuedAt   = new DateTimeImmutable();
    $expire     = $issuedAt->modify('+15 minutes')->getTimestamp();
    $serverName = "localhost";
    $username   = $data->taxId;

    $payload = [
        'iat'  => $issuedAt->getTimestamp(),         // Issued at: time when the token was generated
        'iss'  => $serverName,                       // Issuer
        'nbf'  => $issuedAt->getTimestamp(),         // Not before
        'exp'  => $expire,                           // Expire
        'userName' => $username,                     // User name
    ];
    $key = getSecretKey();
    $jwt = JWT::encode($payload, $key);

    echo($jwt);
} else {
    echo json_encode(
        array(
          'message' => 'User cannot log in'
        )
    );
}
?>