<?php
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

