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

function mapDbUserPermissions($dbUserPermissions)
{
    $userPermissions = array();
    foreach ($dbUserPermissions as $companyCode => $dbUserPermissionsForCompany) {
        $userPermissionsForCompany = array();
        if ($dbUserPermissionsForCompany->active == 0) {
            array_push($userPermissionsForCompany, USER_PERMISSIONS::INACTIVE);
            break;
        }
        array_push($userPermissionsForCompany, USER_PERMISSIONS::USER);

        if ($dbUserPermissionsForCompany->activityAdministrator == 1) {
            array_push($userPermissionsForCompany, USER_PERMISSIONS::ACTIVITY_ADMINISTRATOR);
        }
        if ($dbUserPermissionsForCompany->userAdministrator == 1) {
            array_push($userPermissionsForCompany, USER_PERMISSIONS::USER_ADMINISTRATOR);
        }
        if ($dbUserPermissionsForCompany->documentCreator == 1) {
            array_push($userPermissionsForCompany, USER_PERMISSIONS::DOCUMENT_CREATOR);
        }

        $userPermissions[$companyCode] = $userPermissionsForCompany;
    }

    return $userPermissions;
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