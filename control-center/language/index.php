<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('_ALL_');
require($_SESSION['baseDir'].'/include/user-control.php');

//require $_SESSION['basedir'].'/classes/SmartyClass.php';
require 'smarty/Smarty.class.php';
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$languages = $dbConnection->readData("SELECT * FROM language ORDER BY name; ");

$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
$smarty->assign('userType', $_SESSION['userType']);
$smarty->assign('userName', $_SESSION['userName']);

$smarty->assign('languages', $languages);

$smarty->display('control-center/language-index.tpl');
?>