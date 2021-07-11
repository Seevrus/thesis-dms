<?php
require_once '../../../csrf_protection/checkCsrfToken.php';
require_once '../../../db/connectToDb.php';
require_once '../../../db/selectUser.php';
require_once '../../../jwt/jwtEncode.php';
require_once '../../../jwt/jwtDecode.php';

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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // CSRF Protection
    if (!checkCsrfToken()) {
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

        // case 2: invalid form of request
        if (!isset($credentials->taxNumber) || !isset($credentials->password)) {
            http_response_code(403);
            echo json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'Invalid request formation!'
                )
            );
            exit(1);
        }

        $pdo = connectToDb();
        $fetchUserJSON
            = selectUser($pdo, $credentials->taxNumber, $credentials->password);
        $fetchUser = json_decode($fetchUserJSON);

        if ($fetchUser->outcome == 'success') {
            // Issue Token
            $emailStatus = $fetchUser->emailStatus;
            $jwt = jwtEncode($fetchUser->taxNumber, $emailStatus);

            // set jwt as a cookie
            $jwtDecoded = jwtDecode($jwt);
            // TODO: set $secure to true in production
            setcookie(
                'token',
                $jwt,
                $jwtDecoded->exp,
                '/',
                $jwtDecoded->iss,
                false,
                true
            );

            if ($emailStatus == 0) {
                // case 1: no email address present, 
                // user should register one
                echo json_encode(
                    array(
                        'outcome' => 'pending',
                        'status' => 0,
                        'message' => 'User should register an email address',
                        'taxNumber' => $jwtDecoded->taxNumber,
                        'expires' => $jwtDecoded->exp,
                    )
                );
            } elseif ($emailStatus == 1) {
                // case 2: email address is not yet validated, 
                // user should present the validation code
                echo json_encode(
                    array(
                        'outcome' => 'pending',
                        'status' => 1,
                        'message' => 'User should validate their email address',
                        'taxNumber' => $jwtDecoded->taxNumber,
                        'expires' => $jwtDecoded->exp,
                    )
                );
            } else {
                // case 3: valid email address is present, 
                // user is considered to be logged in
                echo json_encode(
                    array(
                        'outcome' => 'success',
                        'status' => 2,
                        'message' => 'User successfully logged in',
                        'taxNumber' => $jwtDecoded->taxNumber,
                        'expires' => $jwtDecoded->exp,
                    )
                );
            }
        } else {
            http_response_code(403);
            echo $fetchUserJSON;
        }
    }
} else {
    http_response_code(405);
    echo json_encode(
        array(
            'outcome' => 'error',
            'message' => 'Method not allowed',
        )
    );
}
?>