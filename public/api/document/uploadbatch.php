<?php
error_reporting(0);
set_time_limit(1800);
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/createDocument.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/saveFile.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json;charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $MAX_ALLOWED_DOCUMENTS = 100;

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
            // end of token validation

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

            $documents = json_decode(file_get_contents("php://input"));

            // request body validation
            if (!is_array($documents)) {
                http_response_code(403);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'Invalid request formation!',
                    )
                );
                exit(1);
            }

            $pdo = connectToDb();
            $numberOfDocuments = count($documents);

            if ($numberOfDocuments > $MAX_ALLOWED_DOCUMENTS) {
                http_response_code(406);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'Maximum allowed number of files per request exceeded'
                    )
                );
                exit(1);
            }

            $response = array();

            foreach ($documents as $document) {
                $validUntil = $document->validUntil ?? 0;

                if (!isset($document->taxNumber)
                    || !isset($document->documentName)
                    || !isset($document->category)
                    || !isset($document->url)
                ) {
                    $fileResponse = array(
                        'outcome' => 'failure',
                        'message' => 'Missing data from request',
                        'taxNumber' => $document->taxNumber,
                        'documentName' => $document->documentName,
                        'category' => $document->category,
                        'url' => $document->url,
                        'validUntil' => $validUntil == 0 ? null : date("Y-m-d H:i:s", $validUntil),
                    );
                    array_push($response, $fileResponse);
                    continue;
                }

                // We need to save file locally to get the filetype. If it is not a pdf, we should delete it. TODO: is it really the case?
                $url = $document->url;
                $targetLocation = saveFile($url);
                $fileType = mime_content_type($targetLocation);
                if ($fileType != 'application/pdf') {
                    unlink($targetLocation);
                    $fileResponse = array(
                        'outcome' => 'failure',
                        'message' => 'File type not allowed',
                        'taxNumber' => $document->taxNumber,
                        'documentName' => $document->documentName,
                        'category' => $document->category,
                        'url' => $document->url,
                        'validUntil' => $validUntil == 0 ? null : date("Y-m-d H:i:s", $validUntil),
                    );
                    array_push($response, $fileResponse);
                    continue;
                }

                $createDocumentJSON = createDocument(
                    $pdo,
                    $document->taxNumber,
                    $document->documentName,
                    $document->category,
                    $targetLocation,
                    $validUntil,
                );
                $createDocument = json_decode($createDocumentJSON);

                if ($createDocument->outcome == 'failure') {
                    unlink($targetLocation);
                    $fileResponse = array(
                        'outcome' => 'failure',
                        'message' => 'Unexpected database error',
                        'taxNumber' => $document->taxNumber,
                        'documentName' => $document->documentName,
                        'category' => $document->category,
                        'url' => $document->url,
                        'validUntil' => $validUntil == 0 ? null : date("Y-m-d H:i:s", $validUntil),
                    );
                    array_push($response, $fileResponse);
                    continue;
                }

                $fileResponse = array(
                    'outcome' => 'success',
                    'message' => 'File uploaded successfully',
                    'taxNumber' => $document->taxNumber,
                    'documentName' => $document->documentName,
                    'category' => $document->category,
                    'url' => $document->url,
                    'validUntil' => $validUntil == 0 ? null : date("Y-m-d H:i:s", $validUntil),
                );
                array_push($response, $fileResponse);
            }

            echo json_encode($response);
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
