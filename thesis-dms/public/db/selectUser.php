<?php
function selectUser(PDO $pdo, string $taxNumber, string $password)
{
    // do some clean-up
    $taxNumber = htmlentities($taxNumber);
    $password = htmlentities($password);
    $query = 'SELECT * FROM dolgozo WHERE adoazonosito = :ad';

    // try to fetch the user
    $stmt = $pdo->prepare("SELECT * FROM dolgozo WHERE adoazonosito = :ad");
    $stmt->execute(array( ':ad' => $taxNumber));
    $row = $stmt->fetch(PDO::FETCH_ASSOC);  // an array

    // case 2: user not found
    if (!$row) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'User cannot be found'
            )
        );
    }

    // case 3: inactive user

    // case 4: wrong password

    // case 5: wrong password, third attempt

    // case 6: successful login

    // case 2: wrong password
    if (!password_verify($password, $row['jelszo'])) {
        return json_encode(
            array(
                'outcome' => 'failure',
                'message' => 'Invalid credentials'
            )
        );
    }

    return json_encode(
        array(
            'outcome' => 'success',
            'message' => 'User found',
            'taxNumber' => $row['adoazonosito'],
            'email' => $row['email'],
            'emailStatus' => $row['email_statusz']
        )
    );
}
?>