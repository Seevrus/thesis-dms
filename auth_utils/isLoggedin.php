<?php
function isLoggedin (): bool {
  if (
    isset($_SESSION['taxNumber'])
    && isset($_SESSION['userPermissions'])
    && isset($_SESSION['emailStatus'])
    && isset($_SESSION['expires'])
  ) {
    $now = time();

    if ($now > $_SESSION['expires']) {
      // this session has worn out its welcome; kill it and start a brand new one
      session_unset();
      session_destroy();
      session_start();

      return false;
    } else {
      $_SESSION['expires'] = $now + 900;
      return true;
    }
  } else {
    return false;
  }
}
?>
