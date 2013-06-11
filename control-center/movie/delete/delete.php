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

$id = $dbConnection->escapeString((!empty($_POST['id'])) ? $_POST['id'] : -1);

$sqlString = 'DELETE FROM assignment_movie_genre WHERE movie_fk = '.$id.'; ';
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);
$sqlString = 'DELETE FROM assignment_movie_actor WHERE actor_fk = '.$id.'; ';
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);
$sqlString = 'DELETE FROM assignment_movie_director WHERE director_fk = '.$id.'; ';
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);
$sqlString = 'DELETE FROM movie WHERE id = '.$id.'; ';
$dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);
//echo $sqlString;
$dbAnswer = $dbConnection->writeData($sqlString);

echo json_encode($dbAnswer);
?>