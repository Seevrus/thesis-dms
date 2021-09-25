<?php
error_reporting(0);

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/issueNewToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtEncode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/user/selectUser.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

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
            $userPermissions = array_map('mapDbUserPermission', $fetchUser->user_permissions);
            $emailStatus = $fetchUser->email_status;
            $jwt = jwtEncode($fetchUser->user_tax_number, $userPermissions, mapDbEmailStatus($emailStatus));
            $jwtDecoded = issueNewToken($jwt);

            if ($emailStatus == 0) {
                // case 1: no email address present, 
                // user should register one
                echo json_encode(
                    array(
                        'outcome' => 'pending',
                        'loginStatus' => LOGIN_STATUS::LOGGED_IN,
                        'emailStatus' => $jwtDecoded->emailStatus,
                        'message' => 'User should register an email address',
                        'taxNumber' => $jwtDecoded->taxNumber,
                        'userPermissions' => array(),
                        'expires' => $jwtDecoded->exp,
                    )
                );
            } elseif ($emailStatus == 1) {
                // case 2: email address is not yet validated, 
                // user should present the validation code
                echo json_encode(
                    array(
                        'outcome' => 'pending',
                        'loginStatus' => LOGIN_STATUS::LOGGED_IN,
                        'emailStatus' => $jwtDecoded->emailStatus,
                        'message' => 'User should validate their email address',
                        'taxNumber' => $jwtDecoded->taxNumber,
                        'userPermissions' => array(),
                        'expires' => $jwtDecoded->exp,
                    )
                );
            } else {
                // case 3: valid email address is present, 
                // user is considered to be logged in
                $authResponse = array(
                    'outcome' => 'success',
                    'loginStatus' => LOGIN_STATUS::LOGGED_IN,
                    'emailStatus' => $jwtDecoded->emailStatus,
                    'message' => 'User successfully logged in',
                    'taxNumber' => $jwtDecoded->taxNumber,
                    'userPermissions' => $jwtDecoded->userPermissions,
                    'expires' => $jwtDecoded->exp,
                );
                if ($credentials -> noBrowser) {
                    $authResponse['token'] = $jwt;
                }
                echo json_encode($authResponse);
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