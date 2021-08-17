<?php
error_reporting(0);
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/getDocumentPath.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/registerDocumentDownload.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

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

            // check user permission
            if (!in_array(USER_PERMISSIONS::USER, $decodedToken->userPermissions)) {
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

            if (!isset($documentIdentifiers->documentId)) {
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
            $documentPathJSON = getDocumentPath($pdo, $decodedToken->taxNumber, $documentIdentifiers->documentId);
            $documentPath = json_decode($documentPathJSON);

            if ($documentPath->outcome == 'failure') {
                http_response_code(404);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'Document cannot be found',
                    )
                );
                exit(1);
            }

            $registerDocumentAnswerJSON = registerDocumentDownload($pdo, $decodedToken->taxNumber, $documentIdentifiers->documentId);
            $registerDocumentAnswer = json_decode($registerDocumentAnswerJSON);

            if ($registerDocumentAnswer->outcome == 'failure') {
                http_response_code(401);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'Unexpected database issue',
                    )
                );
                exit(1);
            }

            $document = file_get_contents($documentPath->documentPath);
            if (!$document) {
                http_response_code(404);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'Document cannot be found',
                    )
                );
                exit(1);
            }

            echo($document);
            
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
