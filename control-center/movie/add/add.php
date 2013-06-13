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
$year = $dbConnection->escapeString((!empty($_POST['year'])) ? $_POST['year'] : 0);
$date = $dbConnection->escapeString((!empty($_POST['date'])) ? $_POST['date'] : '0000-00-00', 'str');
$language = $dbConnection->escapeString((!empty($_POST['language'])) ? $_POST['language'] : -1);
$type = $dbConnection->escapeString((!empty($_POST['type'])) ? $_POST['type'] : -1);
//$storage = $dbConnection->escapeString((!empty($_POST['storage'])) ? $_POST['storage'] : -1);
$storage = $dbConnection->escapeString((!empty($_POST['storage'])) ? $_POST['storage'] : '');
$genres = (!empty($_POST['genres'])) ? $_POST['genres'] : '';
$genres = explode(';', $genres);
$actors = (!empty($_POST['actors'])) ? $_POST['actors'] : '';
$actors = explode(';', $actors);
$directors = (!empty($_POST['directors'])) ? $_POST['directors'] : '';
$directors = explode(';', $directors);

$sqlString = "SELECT * FROM storage; ";
$storages = $dbConnection->readData($sqlString);
$storage_fk = -1;
foreach ($storages as $sRow) {
    if ($storage == $sRow['name']) {
        $storage_fk = $sRow['id'];
        break;
    }
}
//die($storage_fk);
if ($storage_fk == -1) {
    $sqlString = "INSERT INTO storage (name) VALUES ('".$storage."'); ";
    $storage_fk = $dbConnection->writeData($sqlString, true);
}

$dbAnswer = true;
$sqlString = "INSERT INTO movie ";
$sqlString .= "(name, date, language_fk, type_fk, storage_fk) ";
$sqlString .= "VALUES ";
$sqlString .= "(".$movieName.", ".$date.", ".$language.", ".$type.", ".$storage_fk."); ";
#echo $sqlString;
$movieId = $dbConnection->writeData($sqlString, true);
$movieId = ($movieId) ? $movieId : -1;
$dbAnswer = (($movieId != -1) ? true : false) && $dbAnswer;

$dbAnswer = $dbAnswer && saveMovieAssignments('genre', $dbConnection, $genres, $movieId, $dbAnswer);
$dbAnswer = $dbAnswer && saveMovieAssignments('actor', $dbConnection, $actors, $movieId, $dbAnswer);
$dbAnswer = $dbAnswer && saveMovieAssignments('director', $dbConnection, $directors, $movieId, $dbAnswer);

echo json_encode($dbAnswer);
?>