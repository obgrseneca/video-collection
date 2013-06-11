<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require 'smarty/Smarty.class.php';
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$directors = $dbConnection->readData('SELECT * FROM director ORDER BY name; ');
$selectedDirectors = (!empty($_GET['directors'])) ? $_GET['directors'] : '';
$selectedDirectorArray = (!empty($_GET['directors'])) ? explode(';', $_GET['directors']) : array();

$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
$smarty->assign('userType', $_SESSION['userType']);
$smarty->assign('userName', $_SESSION['userName']);

$smarty->assign('directors', $directors);
$smarty->assign('selectedDirectors', $selectedDirectors);
$smarty->assign('selectedDirectorArray', $selectedDirectorArray);
$smarty->display('control-center/movie-ajax-director.tpl');
?>