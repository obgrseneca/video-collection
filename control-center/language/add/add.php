<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['languageName']) && !empty($_POST['acronym'])) {
    $dbConnection = new DbConnectionClass();
    $languageName = $dbConnection->escapeString($_POST['languageName'],'str');
    $acronym = $dbConnection->escapeString($_POST['acronym'],'str');

    $dbAnswer = $dbConnection->writeData('INSERT INTO language ' .
    '(name, acronym) ' .
    'VALUES ' .
    '('.$languageName.', '.$acronym.')');
}

echo json_encode(array('answer' =>$dbAnswer));
?>