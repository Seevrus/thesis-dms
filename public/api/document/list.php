<?php
// error_reporting(0);

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/csrf_protection/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/jwt/jwtDecode.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/selectDocuments.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $DOCUMENTS_TO_FETCH = 10;

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
                        'message' => 'You do not have permission to access this page!',
                    )
                );
                exit(1);
            }
            // end of checking user permission

            $pdo = connectToDb();
            $requestBody = file_get_contents("php://input");
            if ($requestBody) {
                $queryParams = json_decode(file_get_contents("php://input"));
                $fetchFrom = property_exists($queryParams, 'fetchFrom')
                    ? $queryParams->fetchFrom
                    : 0;
                $category = property_exists($queryParams, 'category')
                    ? $queryParams->category
                    : null;
            } else {
                $fetchFrom = 0;
                $category = null;
            }
            
            $selectedDocumentsJSON = selectDocuments(
                $pdo,
                $decodedToken->taxNumber,
                $category,
                $fetchFrom,
                $DOCUMENTS_TO_FETCH
            );

            $selectedDocuments = json_decode($selectedDocumentsJSON);
            if ($selectedDocuments->outcome == 'failure') {
                http_response_code(401);
            }
            echo $selectedDocumentsJSON;

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
