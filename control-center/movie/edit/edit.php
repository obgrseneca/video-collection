<?php

/*
 * Copyright (c) 2013 Oliver Burger obgr_seneca@mageia.org
 *
 * This file is part of video-collection.
 *
 * video-collection is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * video-collection is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with video-collection.  If not, see <http://www.gnu.org/licenses/>.
 */

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
$language = $dbConnection->escapeString((!empty($_POST['language'])) ? $_POST['language'] : -1);
$date = $dbConnection->escapeString((!empty($_POST['date'])) ? $_POST['date'] : -1, 'str');
//$storage = $dbConnection->escapeString((!empty($_POST['storage'])) ? $_POST['storage'] : -1);
$storage = $dbConnection->escapeString((!empty($_POST['storage'])) ? $_POST['storage'] : '');
$genres = (!empty($_POST['genres'])) ? $_POST['genres'] : '';
$genres = explode(';', $genres);
$actors = (!empty($_POST['actors'])) ? $_POST['actors'] : '';
$actors = explode(';', $actors);
$directors = (!empty($_POST['directors'])) ? $_POST['directors'] : '';
$directors = explode(';', $directors);
$movieId = $dbConnection->escapeString((!empty($_POST['movieId'])) ? $_POST['movieId'] : -1);

$dbQuery = '';
$sqlString = "SELECT * FROM storage; ";
$dbQuery .= $sqlString;
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
    $dbQuery .= $sqlString;
    $storage_fk = $dbConnection->writeData($sqlString, true);
}

$dbAnswer = true;
$sqlString = "UPDATE movie SET ".
    "name = ".$movieName.", ".
    "date = ".$date.", ".
    "language_fk = ".$language.", ".
    "type_fk = ".$type.", ".
    "storage_fk = ".$storage_fk." ".
    "WHERE id = ".$movieId."; ";
$dbQuery .= $sqlString;

$dbResult = $dbConnection->writeData($sqlString);
$dbAnswer = ($dbResult) ? true : false;

$dbAnswer = $dbAnswer && saveMovieAssignments('genre', $dbConnection, $genres, $movieId, $dbAnswer);
$dbAnswer = $dbAnswer && saveMovieAssignments('actor', $dbConnection, $actors, $movieId, $dbAnswer);
$dbAnswer = $dbAnswer && saveMovieAssignments('director', $dbConnection, $directors, $movieId, $dbAnswer);

if ($dbAnswer) {
    echo json_encode($dbAnswer);
} else {
    echo json_encode($dbQuery);
}
?>