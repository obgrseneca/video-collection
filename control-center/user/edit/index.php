<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
$allowedUserId = !empty($_GET['userId']) ? $_GET['userId'] : -1;
require($_SESSION['baseDir'].'/include/user-control.php');

$userHash = sha1(uniqid());

require 'smarty/Smarty.class.php';
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$userTypes = $dbConnection->readData("SELECT * FROM user_type;");
$userId = !empty($_GET['userId']) ? $dbConnection->escapeString($_GET['userId']) : 1;
$user = $dbConnection->readData("SELECT U.*, UT.name AS type_name FROM user AS U LEFT JOIN user_type AS UT ON U.type_fk = UT.id WHERE U.id = ".$userId);
$user = $user[0];

$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('userHash', $userHash);
$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
$smarty->assign('userTypes', $userTypes);
$smarty->assign('user', $user);
$smarty->assign('userType', $_SESSION['userType']);
$smarty->assign('userName', $_SESSION['userName']);

$smarty->display('control-center/user-edit.tpl');
?>