<?php
session_start();
if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}

$dbAnswer = false;
if (!file_exists($_SESSION['baseDir'].'/config.inc')) {
    require($_SESSION['baseDir'].'/include/writeConfigFile.php');
    require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

    $dbConnection = new DbConnectionClass();
    $dbAnswer = ($dbConnection->getDbConnection() != false);
    unlink($_SESSION['baseDir'].'/config.inc');
}

echo json_encode($dbAnswer);
?>