<?php
header('Content-Type: application/json; charset=utf-8');

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (in_array($_SERVER['REQUEST_METHOD'], array('GET', 'HEAD'))) {
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
