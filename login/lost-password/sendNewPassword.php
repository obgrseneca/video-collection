<?php
session_start();

$tempHash = (!empty($_POST['tempHash'])) ? $_POST['tempHash'] : '';
if ($tempHash != $_SESSION['tempHash']) {
    die('Fatal error!');
}

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$name = $dbConnection->escapeString($_POST['name']);

$sqlString = "SELECT email FROM user WHERE name = '".$name."'; ";
$dbAnswer = $dbConnection->readData($sqlString);
$email = $dbAnswer[0]['email'];

$newPassword = substr(sha1(uniqid()),0,8);
$message = wordwrap('Your new video-collection password is : '.$newPassword,70);

$userHash = sha1(uniqid());
$passwordHash = $newPassword;
for ($i=0; $i<10; $i++) {
    $passwordHash = sha1($name.$passwordHash.$userHash);
}
$sqlString = "UPDATE user SET ".
    "salt = '".$userHash."', ".
    "password_hash = '".$passwordHash."' ".
    "WHERE name = '".$name."'; ";
$dbAnswer = $dbConnection->writeData($sqlString);

mail($email, '[video-collection] Password recovery', $message);

echo json_encode('');
?>