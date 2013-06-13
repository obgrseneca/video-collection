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