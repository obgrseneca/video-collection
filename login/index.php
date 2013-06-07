<?php
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