<?php
session_start();
if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator','Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$dbAnswer = true;
$dbQuery = '';

$id = $dbConnection->escapeString((!empty($_POST['id'])) ? $_POST['id'] : -1);

$sqlString = 'DELETE FROM assignment_movie_genre WHERE movie_fk = '.$id.'; ';
$dbQuery .= $sqlString;
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);

$sqlString = 'DELETE FROM assignment_movie_actor WHERE movie_fk = '.$id.'; ';
$dbQuery .= $sqlString;
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);

$sqlString = 'DELETE FROM assignment_movie_director WHERE movie_fk = '.$id.'; ';
$dbQuery .= $sqlString;
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);

$sqlString = 'DELETE FROM movie WHERE id = '.$id.'; ';
$dbQuery .= $sqlString;
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);

//echo $sqlString;
$dbAnswer = $dbConnection->writeData($sqlString);

echo json_encode(array('answer' => $dbAnswer, 'query' => $dbQuery));
?>