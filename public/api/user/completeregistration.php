<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);

if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/emailer.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/api_utils/statusEnums.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/checkCsrfToken.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/auth_utils/isLoggedin.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/connectToDb.php';
require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/db/user/modifyEmail.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try {
    // CSRF Protection
    if (!checkCsrfToken()) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to access this page!',
        )
      );
      exit(1);
    }

    // Verify login
    if (!isLoggedin()) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'You do not have permission to access this page!',
        )
      );
      exit(1);
    }
  
    $credentials = json_decode(file_get_contents("php://input"));

    if (!isset($credentials->email) || !isset($credentials->password)) {
      http_response_code(403);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Invalid request formation!'
        )
      );
      exit(1);
    }

    $passwordHash = password_hash($credentials->password, PASSWORD_DEFAULT);

    $pdo = connectToDb();
    $modifyEmailJSON = modifyEmail(
      $pdo,
      $_SESSION['taxNumber'],
      $credentials->email,
      $passwordHash
    );

    $modifyEmail = json_decode($modifyEmailJSON);

    if ($modifyEmail->outcome == 'failure') {
      http_response_code(401);
      echo json_encode(
        array(
          'outcome' => 'failure',
          'message' => 'Unexpected database error',
        )
      );
      exit(1);
    }

    $emailCode = $modifyEmail->email_code;

    $newLine = "\r\n";
    $message = "";
    $message .= "Tisztelt Felhasználónk!" . $newLine . $newLine;
    $message .= "Ezt az e-mailt azért küldjük, mert ezzel az e-mail címmel regisztráltak a Szentistváni Mezőgazdasági Zrt. dokumentumkezelő rendszerébe. Amennyiben Ön indította el a regisztrációs folyamatot, kérem, hogy bejelentkezés után a megjelenő űrlapon írja be az alábbi kódot:" . $newLine;
    $message .= "$emailCode" . $newLine;
    $message .= "Amennyiben nem Ön indította el a regisztrációs folyamatot, kérem, szíveskedjen a hibát válaszüzenetben jelezni számunkra." . $newLine . $newLine;
    $message .= "Tisztelettel," . $newLine;
    $message .= "Szentistváni Mezőgazdasági Zrt." . $newLine;

    emailer($credentials->email, "Dokumentumkezelő regisztráció", $message);

    // Update email status
    $emailStatus = mapDbEmailStatus($modifyEmail->email_status);
    $_SESSION['emailStatus'] = $emailStatus;

    echo json_encode(
      array(
        'outcome' => $modifyEmail->outcome,
        'message' => $modifyEmail->message,
        'emailStatus' => $emailStatus,
      )
    );
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(
      array(
        'outcome' => 'failure',
        'message' => 'Service temporary unavailable',
      )
    );
  }
} else {
  http_response_code(405);
  echo json_encode(
    array(
      'outcome' => 'error',
      'message' => 'Method not allowed',
    )
  );
}
?>
