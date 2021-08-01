<?php
abstract class USER_PERMISSIONS
{
    const INACTIVE = 'INACTIVE';
    const USER = 'USER';
    const ACTIVITY_ADMINISTRATOR = 'ACTIVITY_ADMINISTRATOR';
    const USER_ADMINISTRATOR = 'USER_ADMINISTRATOR';
    const DOCUMENT_CREATOR = 'DOCUMENT_CREATOR';
};

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

function mapDbUserPermission($dbUserPermission)
{
    switch ($dbUserPermission) {
    case 0:
        return USER_PERMISSIONS::INACTIVE;
    case 1:
        return USER_PERMISSIONS::USER;
    case 2:
        return USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR;
    case 3:
        return USER_PERMISSIONS::USER_ADMINISTRATOR;
    case 4:
        return USER_PERMISSIONS::DOCUMENT_CREATOR;
    }
}

function mapUserPermissionToDb($userPermission)
{
    switch ($userPermission) {
    case USER_PERMISSIONS::INACTIVE:
        return 0;
    case USER_PERMISSIONS::USER:
        return 1;
    case USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR:
        return 2;
    case USER_PERMISSIONS::USER_ADMINISTRATOR:
        return 3;
    case USER_PERMISSIONS::DOCUMENT_CREATOR:
        return 4;
    }
}

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