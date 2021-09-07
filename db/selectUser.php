<?php
date_default_timezone_set('Europe/Budapest');

require_once dirname(dirname(__FILE__)) . '/api_utils/statusEnums.php';
require_once dirname(dirname(__FILE__)) . '/api_utils/userPermissions.php';

function selectUser(PDO $pdo, string $taxNumber, string $password) : string
{
    $MAX_ATTEMPT_TIMESPAN_HOURS = 1;
    $MAX_ATTEMPTS_PER_TIMESPAN = 3;

    // do some clean-up
    $taxNumber = htmlspecialchars($taxNumber, ENT_COMPAT | ENT_HTML401, 'UTF-8');
    $password = htmlspecialchars($password, ENT_COMPAT | ENT_HTML401, 'UTF-8');

    // try to fetch the user
    $selectUserQuery = 'SELECT
            *
        FROM user
        WHERE user_tax_number = :utn';
    $selectUserStmt = $pdo->prepare($selectUserQuery);
    $selectUserStmt->execute(array( ':utn' => $taxNumber));
    $userRow = $selectUserStmt->fetch(PDO::FETCH_ASSOC);

    // case 1: user not found
    if (!$userRow) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'User cannot be found',
            )
        );
    }

    // case 2: inactive user
    $userPermissionsQuery = 'SELECT
            *
        FROM user_permissions
        WHERE user_tax_number = :utn';
    $userPermissionsStmt = $pdo->prepare($userPermissionsQuery);
    $userPermissionsStmt->execute(array( ':utn' => $taxNumber));
    $userPermissionRows = $userPermissionsStmt->fetchAll(PDO::FETCH_ASSOC);
    $isUserActive = userHasPermission($userPermissionRows, USER_PERMISSIONS::REGULAR);

    if (!$isUserActive) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'User is inactive',
            )
        );
    }

    // case 3.0: reset login attempts if they have occured long ago
    $updateTrialsQuery = 'UPDATE
            user
        SET user_login_attempt = :uatmpt
        WHERE user_tax_number = :utn';
    $updateTrialsStmt = $pdo->prepare($updateTrialsQuery);

    $lastTrialTimestamp = strtotime($userRow['user_last_login_attempt']);
    $now = time();
    $hoursSinceLastTrial = abs($now - $lastTrialTimestamp)/(60*60);
    if ($hoursSinceLastTrial > $MAX_ATTEMPT_TIMESPAN_HOURS) {
        $updateTrialsStmt->execute(array( ':uatmpt' => 0, ':utn' => $taxNumber ));
        $selectUserStmt->execute(array( ':utn' => $taxNumber));
        $userRow = $selectUserStmt->fetch(PDO::FETCH_ASSOC);
    }

    // case 3.5: too many login attempts
    $currentNumberOfAttempts = $userRow['user_last_login_attempt'];
    if ($currentNumberOfAttempts > $MAX_ATTEMPTS_PER_TIMESPAN && $hoursSinceLastTrial < $MAX_ATTEMPT_TIMESPAN_HOURS) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Too many failed login attempts',
            )
        );
    }

    // case 4: wrong password
    if (!password_verify($password, $userRow['user_password'])) {
        // update number of trials
        $newTrials = $userRow['user_login_attempt'] + 1;
        $updateTrialsStmt->execute(array( ':uatmpt' => $newTrials, ':utn' => $taxNumber ));

        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Invalid password',
            )
        );
    }

    // case 5: successful login
    $updateTrialsStmt->execute(array( ':uatmpt' => 0, ':utn' => $taxNumber ));

    // obtain user permissions
    $userPermissions = array();
    foreach ($userPermissionRows as $row) {
        array_push($userPermissions, $row['user_permission']);
    }

    return json_encode(
        array(
            'outcome' => 'success',
            'message' => 'User found',
            'user_tax_number' => $userRow['user_tax_number'],
            'user_permissions' => $userPermissions,
            'email' => $userRow['user_email'],
            'email_status' => $userRow['email_status'],
        )
    );
}
?>