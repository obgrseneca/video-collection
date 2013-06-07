<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['genreName'])) {
    $dbConnection = new DbConnectionClass();
    $genreName = $dbConnection->escapeString($_POST['genreName'],'str');

    $dbAnswer = $dbConnection->writeData('INSERT INTO genre ' .
    '(name) ' .
    'VALUES ' .
    '('.$genreName.')');
}

echo json_encode(array('answer' =>$dbAnswer));
?>