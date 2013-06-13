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
$allowedUserTypes = array('_ALL_');
$allowedUserId = !empty($_POST['id']) ? $_POST['id'] : -1;
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['userName']) && !empty($_POST['email'])) {
    $dbConnection = new DbConnectionClass();
    $userName = $dbConnection->escapeString($_POST['userName']);
    $email = $dbConnection->escapeString($_POST['email']);
    $password = $dbConnection->escapeString($_POST['password']);
    //$userHash = $dbConnection->escapeString();
    $userHash = $dbConnection->escapeString($_POST['userHash']);
    $type = $dbConnection->escapeString($_POST['type']);
    $id = $dbConnection->escapeString($_POST['id']);


    $sqlString = 'UPDATE user SET '.
    'name = \''.$userName.'\', ';
    if ($password != '') {
        $sqlString .= 'password_hash = \''.$password.'\', ';
        $sqlString .= 'salt = \''.$userHash.'\', ';
    }
    $sqlString .= 'email = \''.$email.'\', ';
    $sqlString .= 'type_fk = '.$type.' ';
    $sqlString .= 'WHERE id = '.$id;
    $dbAnswer = $dbConnection->writeData($sqlString);
}

echo json_encode(array('sql' => $sqlString, 'answer' =>$dbAnswer));
?>