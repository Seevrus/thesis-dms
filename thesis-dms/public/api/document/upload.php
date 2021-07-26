<?php
error_reporting(0);
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/registerUploadedDocument.php';

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

            if (!isset($_SERVER['HTTP_X_FILE_ID'])
                || !isset($_SERVER['HTTP_X_UPLOAD_TOKEN'])
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
            $fileId = $_SERVER['HTTP_X_FILE_ID'];
            $uploadToken = $_SERVER['HTTP_X_UPLOAD_TOKEN'];

            // JSON url upload
            if ($_SERVER['CONTENT_TYPE'] == 'application/json') {
                $requestContent = json_decode(file_get_contents("php://input"));
                if (!isset($requestContent->url)) {
                    http_response_code(403);
                    echo json_encode(
                        array(
                            'outcome' => 'failure',
                            'message' => 'Invalid request formation!'
                        )
                    );
                    exit(1);
                }
                $document = file_get_contents($requestContent->url);
            // PDF upload
            } else if ($_SERVER['CONTENT_TYPE'] == 'application/pdf') {
                $document = file_get_contents('php://input');
            } else {
                http_response_code(403);
                    echo json_encode(
                        array(
                            'outcome' => 'failure',
                            'message' => 'File type not allowed'
                        )
                    );
                exit(1);
            }

            $pdo = connectToDb();
            $registerUploadedDocumentJSON = registerUploadedDocument($pdo, $uploadToken, $fileId, $targetLocation);
            $registerUploadedDocument = json_decode($registerUploadedDocumentJSON);

            if ($registerUploadedDocument->outcome == 'failure') {
                http_response_code(401);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => $registerUploadedDocument->message,
                    )
                );
            } else {
                // save file
                $fileName = 'doc_' . $fileId . '_' . date('YmdHis') . '.pdf';
                $targetLocation = dirname(dirname(dirname(dirname(__FILE__)))) . '/doc/' . $fileName;
                file_put_contents($targetLocation, $document);

                echo json_encode(
                    array(
                        'outcome' => 'success',
                        'message' => 'File uploaded successfully',
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
