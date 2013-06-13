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

require 'smarty/Smarty.class.php';
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$genres = $dbConnection->readData('SELECT * FROM genre ORDER BY name; ');
$actors = $dbConnection->readData('SELECT * FROM actor ORDER BY name; ');
$directors = $dbConnection->readData('SELECT * FROM director ORDER BY name; ');
$types = $dbConnection->readData('SELECT * FROM movie_type ORDER BY name; ');
$storages = $dbConnection->readData('SELECT * FROM storage ORDER BY name; ');
$languages = $dbConnection->readData('SELECT * FROM language ORDER BY name; ');

$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
$smarty->assign('userType', $_SESSION['userType']);
$smarty->assign('userName', $_SESSION['userName']);

$smarty->assign('genres', $genres);
$smarty->assign('actors', $actors);
$smarty->assign('directors', $directors);
$smarty->assign('types', $types);
$smarty->assign('storages', $storages);
$smarty->assign('languages', $languages);

$smarty->display('control-center/movie-add.tpl');

?>
