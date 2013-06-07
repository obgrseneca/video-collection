<?php
session_start();
if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator');
$allowedUserId = !empty($_GET['userId']) ? $_GET['userId'] : -1;
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$dbAnswer = false;


$id = $dbConnection->escapeString((!empty($_POST['id'])) ? $_POST['id'] : -1);

if ($id != $_SESSION['userId']) {
    $sqlString = 'DELETE FROM user WHERE id = '.$id;
    $dbAnswer = $dbConnection->writeData($sqlString);
}

echo json_encode($dbAnswer);
?>