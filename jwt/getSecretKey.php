<?php
function getSecretKey()
{
    $keyFileContent = parse_ini_file(dirname(dirname(__FILE__)) . '/key.ini');
    return $keyFileContent['secret_key'];
}
?>