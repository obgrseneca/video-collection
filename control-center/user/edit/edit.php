<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
$allowedUserId = !empty($_POST['id']) ? $_POST['id'] : -1;
require($_SESSION['baseDir'].'/include/user-control.php');

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbAnswer = false;
if (!empty($_POST['userName']) && !empty($_POST['email'])) {
    $dbConnection = new DbConnectionClass();
    $userName = $dbConnection->escapeString($_POST['userName']);
    $email = $dbConnection->escapeString($_POST['email']);
    $password = $dbConnection->escapeString($_POST['password']);
    //$userHash = $dbConnection->escapeString();
    $userHash = $dbConnection->escapeString($_POST['userHash']);
    $type = $dbConnection->escapeString($_POST['type']);
    $id = $dbConnection->escapeString($_POST['id']);


    $sqlString = 'UPDATE user SET '.
    'name = \''.$userName.'\', ';
    if ($password != '') {
        $sqlString .= 'password_hash = \''.$password.'\', ';
        $sqlString .= 'salt = \''.$userHash.'\', ';
    }
    $sqlString .= 'email = \''.$email.'\', ';
    $sqlString .= 'type_fk = '.$type.' ';
    $sqlString .= 'WHERE id = '.$id;
    $dbAnswer = $dbConnection->writeData($sqlString);
}

echo json_encode(array('sql' => $sqlString, 'answer' =>$dbAnswer));
?>