<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['languageName'])) {
    $dbConnection = new DbConnectionClass();
    $languageName = $dbConnection->escapeString($_POST['languageName'],'str');
    $acronym = $dbConnection->escapeString($_POST['acronym'],'str');
    $id = $dbConnection->escapeString($_POST['id']);

    $sqlString = 'UPDATE language SET '.
        'name = '.$languageName.', '.
        'acronym = '.$acronym.' ';
    $sqlString .= 'WHERE id = '.$id;
    $dbAnswer = $dbConnection->writeData($sqlString);
}

echo json_encode(array('sql' => $sqlString, 'answer' =>$dbAnswer));
?>