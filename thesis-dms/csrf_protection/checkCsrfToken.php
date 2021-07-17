<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function checkCsrfToken() {
    if (!empty($_SERVER['HTTP_X_CSRF_TOKEN'])) {
      if (hash_equals($_SESSION['X_CSRF_TOKEN'], $_SERVER['HTTP_X_CSRF_TOKEN'])) {
          return true;
      } else {
          return false;
      }
    }
}
?>