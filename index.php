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
$_SESSION['baseDir'] = dirname(__FILE__);
$baseUrl = $_SERVER['REQUEST_URI'];
if (preg_match('/\?/',$baseUrl) != 0) {
    $baseUrl = explode('?', $baseUrl);
    $baseUrl = $baseUrl[0];
}
$_SESSION['baseUrl'] = $baseUrl;
$error = !empty($_GET['error']) ? '?error='.$_GET['error'] : '';

if (!file_exists($_SESSION['baseDir'].'/config.inc')) {
    header('location: '.$_SESSION['baseUrl'].'configuration/index.php');
} else {
    if (empty($_SESSION['userName'])) {
        header('location: ./login/'.$error);
    } else {
        header('location: ./control-center/');
    }
}
?>

