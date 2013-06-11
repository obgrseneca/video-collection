<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require($_SESSION['baseDir'].'/include/saveMovieAssignments.php');
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();

$movieName = $dbConnection->escapeString((!empty($_POST['movieName'])) ? $_POST['movieName'] : '', 'str');
$type = $dbConnection->escapeString((!empty($_POST['type'])) ? $_POST['type'] : -1);
$storage = $dbConnection->escapeString((!empty($_POST['storage'])) ? $_POST['storage'] : -1);
$genres = (!empty($_POST['genres'])) ? $_POST['genres'] : '';
$genres = explode(';', $genres);
$actors = (!empty($_POST['actors'])) ? $_POST['actors'] : '';
$actors = explode(';', $actors);
$directors = (!empty($_POST['directors'])) ? $_POST['directors'] : '';
$directors = explode(';', $directors);
$movieId = $dbConnection->escapeString((!empty($_POST['movieId'])) ? $_POST['movieId'] : -1);

$dbAnswer = true;
$sqlString = "UPDATE movie SET ".
    "name = ".$movieName.", ".
    "type_fk = ".$type.", ".
    "storage_fk = ".$storage." ".
    "WHERE id = ".$movieId."; ";

$dbResult = $dbConnection->writeData($sqlString);
$dbAnswer = ($dbResult) ? true : false;

$dbAnswer = $dbAnswer && saveMovieAssignments('genre', $dbConnection, $genres, $movieId, $dbAnswer);
$dbAnswer = $dbAnswer && saveMovieAssignments('actor', $dbConnection, $actors, $movieId, $dbAnswer);
$dbAnswer = $dbAnswer && saveMovieAssignments('director', $dbConnection, $directors, $movieId, $dbAnswer);

echo json_encode($dbAnswer);
?>