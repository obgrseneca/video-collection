<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}

require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$userName = $dbConnection->escapeString($_GET['userName']);
$incomingPasswordHash = $_GET['passwordHash'];
$sqlString = 'SELECT U.id, U.salt, U.password_hash, UT.name AS type_name '.
    'FROM user AS U LEFT JOIN user_type AS UT ON U.type_fk = UT.id '.
    'WHERE U.name = \''.$userName.'\';';
$queryResult = $dbConnection->readData($sqlString);

$tempPasswordHash = '';
$userHash = '';
$passwordHash = '';
$userType = '';
if (count($queryResult) == 1) {
    $userHash = $queryResult[0]['salt'];
    $passwordHash = $queryResult[0]['password_hash'];
    $tempPasswordHash = sha1($passwordHash.$_SESSION['tempHash']);
    $userType = $queryResult[0]['type_name'];
    $userId = $queryResult[0]['id'];
}

$data = array('loginResult' => false, 'data' => $queryResult[0]);
if ($tempPasswordHash == $incomingPasswordHash) {
    $data['loginResult'] = true;
    $_SESSION['userName'] = $userName;
    $_SESSION['userType'] = $userType;
    $_SESSION['userId'] = $userId;
}

echo json_encode($data);
?>