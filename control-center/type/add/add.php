<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['typeName'])) {
    $dbConnection = new DbConnectionClass();
    $typeName = $dbConnection->escapeString($_POST['typeName'],'str');

    $dbAnswer = $dbConnection->writeData('INSERT INTO movie_type ' .
    '(name) ' .
    'VALUES ' .
    '('.$typeName.')');
}

echo json_encode(array('answer' =>$dbAnswer));
?>