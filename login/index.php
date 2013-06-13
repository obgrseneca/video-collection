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
$_SESSION['tempHash'] = sha1(uniqid());

//require $_SESSION['basedir'].'/classes/SmartyClass.php';
require 'smarty/Smarty.class.php';

$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('tempHash', $_SESSION['tempHash']);
$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
if (isset($_GET['error']) && $_GET['error'] == 'login false') {
    $smarty->assign('error', 'login');
} else {
    $smarty->assign('error', '');
}

$smarty->display('login/index.tpl');

?>