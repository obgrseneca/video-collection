<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['storageName'])) {
    $dbConnection = new DbConnectionClass();
    $storageName = $dbConnection->escapeString($_POST['storageName'],'str');

    $dbAnswer = $dbConnection->writeData('INSERT INTO storage ' .
    '(name) ' .
    'VALUES ' .
    '('.$storageName.')');
}

echo json_encode(array('answer' =>$dbAnswer));
?>