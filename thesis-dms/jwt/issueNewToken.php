<?php
require_once dirname(__FILE__) . '/jwtDecode.php';
require_once dirname(__FILE__) . '/jwtEncode.php';

function issueNewToken($oldToken, $emailStatus = false)
{
    $decodedToken = jwtDecode($oldToken);
    if (!$emailStatus) {
        $emailStatus = $decodedToken->emailStatus;
    }
    $newToken = jwtEncode($decodedToken->taxNumber, $emailStatus);
    $decodedNewToken = jwtDecode($newToken);
    // TODO: set $secure to true in production
    setcookie(
        'token',
        $newToken,
        $decodedNewToken->exp,
        '/',
        $decodedNewToken->iss,
        false,
        true
    );

    return $decodedNewToken;
}
?>