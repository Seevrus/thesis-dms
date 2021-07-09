<?php
require_once '../../../vendor/autoload.php';
use Firebase\JWT\JWT;

require_once '../../../csrf_protection/checkCsrfToken.php';
require_once '../../../db/connectToDb.php';
require_once '../../../db/selectUser.php';

session_start();

header('Content-Type: application/json');

function getUserIP()
{
    // Get real visitor IP behind CloudFlare network
    if (isset($_SERVER["HTTP_CF_CONNECTING_IP"])) {
        $_SERVER['REMOTE_ADDR'] = $_SERVER["HTTP_CF_CONNECTING_IP"];
        $_SERVER['HTTP_CLIENT_IP'] = $_SERVER["HTTP_CF_CONNECTING_IP"];
    }
    $client  = @$_SERVER['HTTP_CLIENT_IP'];
    $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
    $remote  = $_SERVER['REMOTE_ADDR'];

    if (filter_var($client, FILTER_VALIDATE_IP)) {
        $ip = $client;
    } elseif (filter_var($forward, FILTER_VALIDATE_IP)) {
        $ip = $forward;
    } else {
        $ip = $remote;
    }

    return $ip;
}

function getSecretKey()
{
    $keyFileContent = parse_ini_file('../../../key.ini');
    return $keyFileContent['secret_key'];
}

// CSRF Protection
if(!checkCsrfToken()) {
    http_response_code(403);
        echo json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'You do not have permission to access this page!'
            )
        );
} else {
    // case 1: not from Hungary
    // just a simple check for the sake of the idea
    // TODO: check it on not localhost
    $ip = getUserIP();
    $res = file_get_contents('https://www.iplocate.io/api/lookup/' . $ip);
    $res = json_decode($res);
    $country = $res->country_code;

    if (!is_null($country) && $country != 'HU') {
        http_response_code(403);
        echo json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Request must originate from Hungary!'
            )
        );
    }

    // Verify login
    $credentials = json_decode(file_get_contents("php://input"));
    $pdo = connectToDb();
    $fetchUserJSON = selectUser($pdo, $credentials->taxNumber, $credentials->password);
    $fetchUser = json_decode($fetchUserJSON);

    if ($fetchUser->outcome == 'success') {
        // Issue Token

        $issuedAt   = new DateTimeImmutable();
        $expire     = $issuedAt->modify('+15 minutes')->getTimestamp();
        $serverName = "localhost";
        $username   = $credentials->taxNumber;

        $payload = [
            'iat'  => $issuedAt->getTimestamp(),         // Issued at: time when the token was generated
            'iss'  => $serverName,                       // Issuer
            'nbf'  => $issuedAt->getTimestamp(),         // Not before
            'exp'  => $expire,                           // Expire
            'userName' => $username,                     // User name
        ];
        $key = getSecretKey();
        $jwt = JWT::encode($payload, $key);

        echo json_encode(
          array(
              'outcome' => 'success',
              'message' => 'User successfully logged in',
              'token' => $jwt
          )
      );
    } else {
        http_response_code(403);
        echo $fetchUserJSON;
    }
}
?>