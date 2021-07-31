<?php
function revokeToken()
{
    if (isset($_COOKIE['token'])) {
        unset($_COOKIE['token']);
        setcookie(
            'token',
            '',
            time()-3600,
            '/',
        );
    }
}
?>