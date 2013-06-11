<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

//require $_SESSION['basedir'].'/classes/SmartyClass.php';
require 'smarty/Smarty.class.php';
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$users = $dbConnection->readData("SELECT U.*,UT.name AS type_name FROM user AS U LEFT JOIN user_type AS UT ON U.type_fk = UT.id  ORDER BY U.type_fk, U.name; ");
//echo "SELECT U.*,UT.name AS type_name FROM user AS U LEFT JOIN user_type AS UT ON U.type = UT.id;";

$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
$smarty->assign('userType', $_SESSION['userType']);
$smarty->assign('userName', $_SESSION['userName']);

$smarty->assign('users', $users);

$smarty->display('control-center/user-index.tpl');
?>