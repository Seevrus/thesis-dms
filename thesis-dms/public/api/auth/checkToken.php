<?php
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtEncode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (!isset($_COOKIE['token'])) {
        // JWT is not set
        echo json_encode(
            array(
                'outcome' => 'success',
                'loginStatus' => LOGIN_STATUS::NOT_LOGGED_IN,
                'message' => 'User is currently not logged in'
            )
        );
    } else {  // refresh token
        $token = $_COOKIE['token'];
        $decodedToken = jwtDecode($token);
        // TODO: what happens when JWT is invalid?
        $newToken = jwtEncode($decodedToken->taxNumber, $decodedToken->emailStatus);
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

        echo json_encode(
            array(
                'outcome' => 'success',
                'loginStatus' => LOGIN_STATUS::LOGGED_IN,
                'emailStatus' => $decodedNewToken->emailStatus,
                'message' => 'New token created',
                'taxNumber' => $decodedNewToken->taxNumber,
                'expires' => $decodedNewToken->exp,
            )
        );
    }
}
?>