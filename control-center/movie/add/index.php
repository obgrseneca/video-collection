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
