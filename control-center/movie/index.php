<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('_ALL_');
require($_SESSION['baseDir'].'/include/user-control.php');

require 'smarty/Smarty.class.php';
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$sqlString = 'SELECT M.*,S.name AS storage_name, MT.name AS type_name FROM movie AS M '.
    'LEFT JOIN storage AS S ON M.storage_fk = S.id '.
    'LEFT JOIN movie_type AS MT ON M.type_fk = MT.id '.
    'LEFT JOIN assignment_movie_genre AS AMG ON M.id = AMG.movie_fk '.
    'LEFT JOIN genre AS G ON AMG.genre_fk = G.id '.
    'LEFT JOIN assignment_movie_actor AS AMA ON M.id = AMA.movie_fk '.
    'LEFT JOIN actor AS A ON AMA.actor_fk = A.id '.
    'LEFT JOIN assignment_movie_director AS AMD ON M.id = AMD.movie_fk '.
    'LEFT JOIN director AS D ON AMD.director_fk = D.id '.
    'ORDER BY M.name; ';
echo $sqlString.'<br />';
$movies = $dbConnection->readData($sqlString);

$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
$smarty->assign('userType', $_SESSION['userType']);
$smarty->assign('userName', $_SESSION['userName']);

$smarty->assign('movies', $movies);

$smarty->display('control-center/movie-index.tpl');
?>