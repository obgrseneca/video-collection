<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['directorName'])) {
    $dbConnection = new DbConnectionClass();
    $directorName = $dbConnection->escapeString($_POST['directorName'],'str');

    $dbAnswer = $dbConnection->writeData('INSERT INTO director ' .
    '(name) ' .
    'VALUES ' .
    '('.$directorName.')');
}

echo json_encode(array('answer' =>$dbAnswer));
?>