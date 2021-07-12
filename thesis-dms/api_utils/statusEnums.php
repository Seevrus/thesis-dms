<?php
abstract class EMAIL_STATUS
{
    const NO_EMAIL = 'NO_EMAIL';
    const NOT_VALIDATED = 'NOT_VALIDATED';
    const VALID_EMAIL = 'VALID_EMAIL';
};

abstract class LOGIN_STATUS
{
    const NOT_LOGGED_IN = 'NOT_LOGGED_IN';
    const LOGGED_IN = 'LOGGED_IN';
};
?>