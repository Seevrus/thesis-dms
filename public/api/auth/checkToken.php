<?php
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/issueNewToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json; charset=utf-8');

if (in_array($_SERVER['REQUEST_METHOD'], array('GET', 'HEAD'))) {
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
        try {
            $decodedNewToken = issueNewToken($token);

            echo json_encode(
                array(
                    'outcome' => 'success',
                    'loginStatus' => LOGIN_STATUS::LOGGED_IN,
                    'userPermissions' => $decodedNewToken->userPermissions,
                    'emailStatus' => $decodedNewToken->emailStatus,
                    'message' => 'New token created',
                    'taxNumber' => $decodedNewToken->taxNumber,
                    'expires' => $decodedNewToken->exp,
                )
            );
        } catch (Exception $e) {
            http_response_code(403);
            echo json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'You do not have permission to access this page!'
                )
            );
        }
    }
}
?>