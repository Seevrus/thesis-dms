<?php
error_reporting(0);

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/createDocumentStub.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

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
            if (isset($_COOKIE['token'])) {
                $token = $_COOKIE['token'];
            } else {
                $tokenHeader = $_SERVER['Authorization'];
                $token = explode(' ', $tokenHeader)[1];
            }
            $decodedToken = jwtDecode($token);
            // end of validation

            // check user permission
            if (!in_array(USER_PERMISSIONS::DOCUMENT_CREATOR, $decodedToken->userPermissions)) {
                http_response_code(403);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'You do not have permission to access this page!'
                    )
                );
                exit(1);
            }

            $documentIdentifiers = json_decode(file_get_contents("php://input"));

            if (!isset($documentIdentifiers->taxNumber)
                || !isset($documentIdentifiers->documentName)
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

            $pdo = connectToDb();
            if (property_exists($documentIdentifiers, 'validUntil')) {
                $createDocumentJSON = createDocumentStub(
                    $pdo,
                    $documentIdentifiers->taxNumber,
                    $documentIdentifiers->documentName,
                    $documentIdentifiers->validUntil,
                );
            } else {
                $createDocumentJSON = createDocumentStub(
                    $pdo,
                    $documentIdentifiers->taxNumber,
                    $documentIdentifiers->documentName,
                );
            }

            $createDocument = json_decode($createDocumentJSON);

            if ($createDocument->outcome === 'failure') {
                http_response_code(401);
            }
            echo $createDocumentJSON;

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
