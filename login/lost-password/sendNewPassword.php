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

$tempHash = (!empty($_POST['tempHash'])) ? $_POST['tempHash'] : '';
if ($tempHash != $_SESSION['tempHash']) {
    die('Fatal error!');
}

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$name = $dbConnection->escapeString($_POST['name']);

$sqlString = "SELECT email FROM user WHERE name = '".$name."'; ";
$dbAnswer = $dbConnection->readData($sqlString);
$email = $dbAnswer[0]['email'];

$newPassword = substr(sha1(uniqid()),0,8);
$message = wordwrap('Your new video-collection password is : '.$newPassword,70);

$userHash = sha1(uniqid());
$passwordHash = $newPassword;
for ($i=0; $i<10; $i++) {
    $passwordHash = sha1($name.$passwordHash.$userHash);
}
$sqlString = "UPDATE user SET ".
    "salt = '".$userHash."', ".
    "password_hash = '".$passwordHash."' ".
    "WHERE name = '".$name."'; ";
$dbAnswer = $dbConnection->writeData($sqlString);

mail($email, '[video-collection] Password recovery', $message);

echo json_encode('');
?>