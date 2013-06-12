<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['actorName'])) {
    $dbConnection = new DbConnectionClass();
    $actorName = $dbConnection->escapeString($_POST['actorName'],'str');

    $dbAnswer = $dbConnection->writeData('INSERT INTO actor ' .
    '(name) ' .
    'VALUES ' .
    '('.$actorName.')');
}

echo json_encode(array('answer' =>$dbAnswer));
?>