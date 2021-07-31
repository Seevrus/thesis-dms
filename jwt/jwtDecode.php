<?php
require_once dirname(dirname(__FILE__)) . '/vendor/autoload.php';
use Firebase\JWT\JWT;

require_once dirname(__FILE__) . '/getSecretKey.php';

function jwtDecode($jwt)
{
    $key = getSecretKey();
    $alg = array('HS512');
    $decoded = JWT::decode($jwt, $key, $alg);

    return $decoded;
}
?>