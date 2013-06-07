<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}

if (file_exists($_SESSION['baseDir'].'/config.inc')) {
    header('location: '.$_SESSION['baseDir'].'/');
} else {
    require 'smarty/Smarty.class.php';

    $smarty = new Smarty();
    $smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
    $smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
    $smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
    $smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

    $smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
    $smarty->assign('baseUrl', $_SESSION['baseUrl']);

    $smarty->display('configuration/index.tpl');
}

?>