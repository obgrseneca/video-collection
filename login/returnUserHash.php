<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
/*$allowedUserTypes = array('_ALL_');
require($_SESSION['baseDir'].'/include/user-control.php');*/

require $_SESSION['baseDir'] . '/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$userName = $dbConnection->escapeString($_GET['userName']);
$sqlString = 'SELECT salt FROM user WHERE name = \'' . $userName . '\';';
$queryResult = $dbConnection->readData($sqlString);

$data = array('userHash' => '');
if (count($queryResult) == 1) {
    $data = array('userHash' => $queryResult[0]['salt']);
}

echo json_encode($data);
?>