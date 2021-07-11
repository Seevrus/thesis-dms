<?php
require_once dirname(dirname(__FILE__)) . '/vendor/autoload.php';
use Firebase\JWT\JWT;

require_once dirname(__FILE__) . '/getSecretKey.php';

function jwtEncode($taxNumber, $emailStatus)
{
    $issuedAt   = new DateTimeImmutable();
    $serverName = "localhost";
    $expire     = $issuedAt->modify('+15 minutes')->getTimestamp();

    $key = getSecretKey();
    $alg = 'HS512';
    $payload = [
      'iat'  => $issuedAt->getTimestamp(),         // Issued at: time when the token was generated
      'iss'  => $serverName,                       // Issuer
      'nbf'  => $issuedAt->getTimestamp(),         // Not before
      'exp'  => $expire,                           // Expire
      'taxNumber' => $taxNumber,                   // User name
      'emailStatus' => $emailStatus,               // Email status
    ];

    $jwt = JWT::encode($payload, $key, $alg);
    return $jwt;
}
?>
