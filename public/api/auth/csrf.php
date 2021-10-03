<?php
header('Content-Type: application/json; charset=utf-8');

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (empty($_SERVER['HTTP_X_CSRF_TOKEN'])) {
        if (empty($_SESSION['X_CSRF_TOKEN'])) {
            $token = bin2hex(random_bytes(32));
            $_SESSION['X_CSRF_TOKEN'] = $token;
        }
        
        echo json_encode(
            array(
                'csrfToken' => $_SESSION['X_CSRF_TOKEN']
            )
        );
    } else {
        echo json_encode(
            array(
                'csrfToken' => $_SERVER['HTTP_X_CSRF_TOKEN']
            )
        );
    }
}
?>
