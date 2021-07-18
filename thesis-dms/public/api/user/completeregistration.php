<?php
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/modifyEmail.php';

header('Content-Type: application/json');

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
        try {
            // check token validity
            $token = $_COOKIE['token'];
            $decodedToken = jwtDecode($token);
            // end of validation

            $credentials = json_decode(file_get_contents("php://input"));

            if (!isset($credentials->taxNumber) 
                || !isset($credentials->email)
                || !isset($credentials->password)
            ) {
                http_response_code(403);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'Invalid request formation!'
                    )
                );
                exit(1);
            }

            $passwordHash = password_hash($credentials->password, PASSWORD_DEFAULT);

            $pdo = connectToDb();
            $modifyEmailJSON = modifyEmail(
                $pdo, $credentials->taxNumber,
                $credentials->email,
                $passwordHash
            );
            $modifyEmail = json_decode($modifyEmailJSON);

            echo json_encode(
                array(
                    'outcome' => 'success',
                    'message' => 'Email successfully updated',
                    'emailStatus' => EMAIL_STATUS::NOT_VALIDATED,
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