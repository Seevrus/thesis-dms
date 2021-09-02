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

header('Content-Type: application/json');

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
            $validCompanyCodesForFileUpload = array();
            foreach ($decodedToken->userPermissions as $companyCode => $userPermissionsForCompany) {
                if (in_array(USER_PERMISSIONS::DOCUMENT_CREATOR, $userPermissionsForCompany)) {
                    array_push($validCompanyCodesForFileUpload, $companyCode);
                }
            }

            if (empty($validCompanyCodesForFileUpload)) {
                http_response_code(403);
                echo json_encode(
                    array(
                        'outcome' => 'failure',
                        'message' => 'You do not have permission to access this page!'
                    )
                );
                exit(1);
            }
            // end of user permissions check

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

                // reject for incomplete request
                if (!isset($document->companyCode)
                    || !isset($document->taxNumber)
                    || !isset($document->documentName)
                    || !isset($document->category)
                    || !isset($document->url)
                ) {
                    $fileResponse = array(
                        'companyCode' => $document->companyCode,
                        'taxNumber' => $document->taxNumber,
                        'documentName' => $document->documentName,
                        'category' => $document->category,
                        'url' => $document->url,
                        'outcome' => 'failure',
                        'message' => 'Missing data from request',
                    );
                    array_push($response, $fileResponse);
                    continue;
                }

                // if the user does not have permission to upload for the given company code, reject upload
                if (!in_array($document->companyCode, $validCompanyCodesForFileUpload)) {
                    $fileResponse = array(
                        'companyCode' => $document->companyCode,
                        'taxNumber' => $document->taxNumber,
                        'documentName' => $document->documentName,
                        'category' => $document->category,
                        'url' => $document->url,
                        'outcome' => 'failure',
                        'message' => 'You do not have permission to create documents for company code ' . $document->companyCode,
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
                        'companyCode' => $document->companyCode,
                        'taxNumber' => $document->taxNumber,
                        'documentName' => $document->documentName,
                        'category' => $document->category,
                        'url' => $document->url,
                        'outcome' => 'failure',
                        'message' => 'File type not allowed',
                    );
                    array_push($response, $fileResponse);
                    continue;
                }

                $createDocumentJSON = createDocument(
                    $pdo,
                    $document->companyCode,
                    $document->taxNumber,
                    $document->documentName,
                    $document->category,
                    $document->visible || 1,
                    $document->validUntil || null,
                    $targetLocation,
                );
                $createDocument = json_decode($createDocumentJSON);

                if ($createDocument->outcome == 'failure') {
                    unlink($targetLocation);
                    $fileResponse = array(
                        'companyCode' => $document->companyCode,
                        'taxNumber' => $document->taxNumber,
                        'documentName' => $document->documentName,
                        'category' => $document->category,
                        'url' => $document->url,
                        'outcome' => 'failure',
                        'message' => $createDocument->message,
                    );
                    array_push($response, $fileResponse);
                    continue;
                }

                $fileResponse = array(
                    'companyCode' => $document->companyCode,
                    'taxNumber' => $document->taxNumber,
                    'documentName' => $document->documentName,
                    'category' => $document->category,
                    'url' => $document->url,
                    'outcome' => 'success',
                    'message' => $createDocument->message,
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
