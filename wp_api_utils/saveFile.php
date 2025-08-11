<?php
function saveFile(string $url) {
  try {
    $document = file_get_contents($url);
    $fileName = 'doc_' . date('YmdHis') . '_' . generateRandomString(8) . '.pdf';
    $targetLocation = dirname(__FILE__, 2) . '/wp_doc/' . $fileName;
    file_put_contents($targetLocation, $document);

    return $targetLocation;
  } catch (Exception $e) {
    return false;
  }
}
