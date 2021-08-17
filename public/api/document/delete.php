<?php
error_reporting(0);
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/getDocumentPath.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/updateDocumentVisibility.php';

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
            $documentPathJSON = updateDocumentVisibility($pdo, $decodedToken->taxNumber, $documentIdentifiers->documentId);
            $documentPath = json_decode($documentPathJSON);

            if ($documentPath->outcome == 'failure') {
                http_response_code(401);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => $documentPath->message,
                    )
                );
                exit(1);
            }

            // remove file from server
            $isDeleteSuccessful = unlink($documentPath->documentPath);

            if (!$isDeleteSuccessful) {
                http_response_code(401);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'Document could not be deleted',
                    )
                );
            } else {
                echo json_encode(
                    array(
                        'outcome' => 'success',
                        'message' => 'Document has been deleted',
                    )
                );
            }
            
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
