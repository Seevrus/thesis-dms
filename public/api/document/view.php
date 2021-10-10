<?php
// error_reporting(0);
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/getDocumentPath.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/document/registerDocumentDownload.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json; charset=utf-8');

if (in_array($_SERVER['REQUEST_METHOD'], array('GET', 'HEAD'))) {
    try {
        // check token validity
        $token = $_COOKIE['token'];
        $decodedToken = jwtDecode($token);
        // end of validation

        // check user permission
        if (!in_array(USER_PERMISSIONS::REGULAR, $decodedToken->userPermissions)) {
            http_response_code(403);
            echo json_encode(
                array(
                    'outcome' => 'failure',
                    'message' => 'You do not have permission to access this page!'
                )
            );
            exit(1);
        }

        $documentId = $_GET["documentId"];

        if (!isset($documentId)) {
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
        $documentPathJSON = getDocumentPath($pdo, $decodedToken->taxNumber, $documentId);
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

        $registerDocumentAnswerJSON = registerDocumentDownload($pdo, $decodedToken->taxNumber, $documentId);
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

        $document = file_get_contents($documentPath->document_path);
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

        header('Content-Type: application/pdf');
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
