<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator');
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['userName']) && !empty($_POST['email']) && !empty($_POST['password'])) {
    $dbConnection = new DbConnectionClass();
    $userName = $dbConnection->escapeString($_POST['userName']);
    $email = $dbConnection->escapeString($_POST['email']);
    $password = $dbConnection->escapeString($_POST['password']);
    $userHash = $dbConnection->escapeString($_POST['userHash']);
    $type = $dbConnection->escapeString($_POST['type']);

    $dbAnswer = $dbConnection->writeData('INSERT INTO user ' .
        '(name, salt, password_hash, email, type_fk) ' .
        'VALUES ' .
        '(\''.$userName.'\', \''.$userHash.'\', \''.$password.'\', \''.$email.'\', '.$type.')');
}

echo json_encode(array('answer' =>$dbAnswer));
?>