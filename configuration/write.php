<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}

if (!file_exists($_SESSION['baseDir'].'/config.inc')) {
    require($_SESSION['baseDir'].'/include/writeConfigFile.php');
}

echo json_encode('');
?>