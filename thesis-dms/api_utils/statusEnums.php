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

function mapDbEmailStatus($dbEmailStatus)
{
    switch ($dbEmailStatus) {
    case 0:
        return EMAIL_STATUS::NO_EMAIL;
    case 1:
        return EMAIL_STATUS::NOT_VALIDATED;
    case 2:
        return EMAIL_STATUS::VALID_EMAIL;
    }
}

function mapEmailStatusToDb($emailStatus)
{
    switch ($emailStatus) {
    case EMAIL_STATUS::NO_EMAIL:
        return 0;
    case EMAIL_STATUS::NOT_VALIDATED:
        return 1;
    case EMAIL_STATUS::VALID_EMAIL:
        return 2;
    }
}
?>