<?php
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/issueNewToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/emailer.php';
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

            if (!isset($credentials->email) || !isset($credentials->password)) {
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
                $pdo,
                $decodedToken->taxNumber,
                $credentials->email,
                $passwordHash
            );

            $modifyEmail = json_decode($modifyEmailJSON);
            $emailCode = $modifyEmail->emailCode;

            $newLine = "\r\n";
            $message = "";
            $message .= "Tisztelt Felhasználónk!" . $newLine . $newLine;
            $message .= "Ezt az e-mailt azért küldjük, mert ezzel az e-mail címmel regisztráltak a Szentistváni Mezőgazdasági Zrt. dokumentumkezelő rendszerébe. Amennyiben Ön indította el a regisztrációs folyamatot, kérem, hogy bejelentkezés után a megjelenő űrlapon írja be az alábbi kódot:" . $newLine;
            $message .= "$emailCode" . $newLine;
            $message .= "Amennyiben nem Ön indította el a regisztrációs folyamatot, kérem, szíveskedjen a hibát válaszüzenetben jelezni számunkra." . $newLine . $newLine;
            $message .= "Tisztelettel," . $newLine;
            $message .= "Szentistváni Mezőgazdasági Zrt." . $newLine;

            emailer($credentials->email, "Dokumentumkezelő regisztráció", $message);

            // Issue new token with new email status inside
            issueNewToken($token, $modifyEmail->emailStatus);

            echo json_encode(
                array(
                    'outcome' => $modifyEmail->outcome,
                    'message' => $modifyEmail->message,
                    'emailStatus' => $modifyEmail->emailStatus,
                )
            );
        } catch (Exception $e) {
            http_response_code(403);
            echo json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'You do not have permission to access this page!',
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