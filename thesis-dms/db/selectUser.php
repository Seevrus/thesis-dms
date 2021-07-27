<?php
date_default_timezone_set('Europe/Budapest');

function selectUser(PDO $pdo, string $taxNumber, string $password)
{
    $MAX_ATTEMPT_TIMESPAN_HOURS = 1;
    $MAX_ATTEMPTS_PER_TIMESPAN = 3;

    // do some clean-up
    $taxNumber = htmlentities($taxNumber);
    $password = htmlentities($password);

    // try to fetch the user
    $selectUserQuery = 'SELECT * FROM dolgozo WHERE adoazonosito = :ad';
    $selectUserStmt = $pdo->prepare($selectUserQuery);
    $selectUserStmt->execute(array( ':ad' => $taxNumber));
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
    if ($userRow['felhasznalo_statusz'] == 0) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'User is inactive',
            )
        );
    }

    // case 3.0: reset login attempts if they have occured long ago
    $updateTrialsQuery = 'UPDATE dolgozo SET probalkozas= :proba WHERE adoazonosito = :ad';
    $updateTrialsStmt = $pdo->prepare($updateTrialsQuery);

    $lastTrialTimestamp = strtotime($userRow['utolso_probalkozas']);
    $now = time();
    $hoursSinceLastTrial = abs($now - $lastTrialTimestamp)/(60*60);
    if ($hoursSinceLastTrial > $MAX_ATTEMPT_TIMESPAN_HOURS) {
        $updateTrialsStmt->execute(array( ':proba' => 0, ':ad' => $taxNumber ));
        $selectUserStmt->execute(array( ':ad' => $taxNumber));
        $userRow = $selectUserStmt->fetch(PDO::FETCH_ASSOC);
    }

    // case 3.5: too many login attempts
    $currentNumberOfAttempts = $userRow['probalkozas'];
    if ($currentNumberOfAttempts > $MAX_ATTEMPTS_PER_TIMESPAN && $hoursSinceLastTrial < $MAX_ATTEMPT_TIMESPAN_HOURS) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Too many failed login attempts',
            )
        );
    }

    // case 4: wrong password
    if (!password_verify($password, $userRow['jelszo'])) {
        // update number of trials
        $newTrials = $userRow['probalkozas'] + 1;
        $updateTrialsStmt->execute(array( ':proba' => $newTrials, ':ad' => $taxNumber ));

        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Invalid password',
            )
        );
    }

    // case 5: successful login
    $updateTrialsStmt->execute(array( ':proba' => 0, ':ad' => $taxNumber ));

    // obtain user permissions
    $checkUserPermissionsQuery = 'SELECT jogosultsag FROM dolgozo_jogosultsag WHERE dolgozo_azon = :ad';
    $checkUserPermissionsStmt = $pdo->prepare($checkUserPermissionsQuery);
    $checkUserPermissionsStmt->execute(
        array(
            ':ad' => $taxNumber,
        )
    );
    $userPermissionRows = $checkUserPermissionsStmt->fetchAll(PDO::FETCH_ASSOC);
    $userPermissions = array();
    foreach ($userPermissionRows as $row) {
        array_push($userPermissions, $row['jogosultsag']);
    }

    return json_encode(
        array(
            'outcome' => 'success',
            'message' => 'User found',
            'taxNumber' => $userRow['adoazonosito'],
            'userPermissions' => $userPermissions,
            'email' => $userRow['email'],
            'emailStatus' => $userRow['email_statusz'],
        )
    );
}
?>