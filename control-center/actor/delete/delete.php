<?php
session_start();
if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$dbAnswer = false;


$id = $dbConnection->escapeString((!empty($_POST['id'])) ? $_POST['id'] : -1);


$sqlString = 'DELETE FROM actor WHERE id = '.$id;
$dbAnswer = $dbConnection->writeData($sqlString);

echo json_encode($dbAnswer);
?>