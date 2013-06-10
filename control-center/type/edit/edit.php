<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['typeName'])) {
    $dbConnection = new DbConnectionClass();
    $typeName = $dbConnection->escapeString($_POST['typeName'],'str');
    $id = $dbConnection->escapeString($_POST['id']);

    $sqlString = 'UPDATE movie_type SET '.
        'name = '.$typeName.' ';
    $sqlString .= 'WHERE id = '.$id;
    $dbAnswer = $dbConnection->writeData($sqlString);
}

echo json_encode(array('sql' => $sqlString, 'answer' =>$dbAnswer));
?>