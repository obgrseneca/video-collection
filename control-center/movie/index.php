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
$sqlString = 'SELECT M.id, M.name, M.type_fk, M.storage_fk, M.date, M.story, M.tmdb_id, '.
    'S.name AS storage_name, MT.name AS type_name, L.name AS language_name, '.
    'GROUP_CONCAT(DISTINCT G.name ORDER BY G.name SEPARATOR \'; \') AS genres, '.
    'GROUP_CONCAT(DISTINCT A.name ORDER BY A.name SEPARATOR \'; \') AS actors, '.
    'GROUP_CONCAT(DISTINCT D.name ORDER BY D.name SEPARATOR \'; \') AS directors '.
    'FROM movie AS M '.
    'LEFT JOIN storage AS S ON M.storage_fk = S.id '.
    'LEFT JOIN movie_type AS MT ON M.type_fk = MT.id '.
    'LEFT JOIN language AS L ON M.language_fk = L.id '.
    'LEFT JOIN assignment_movie_genre AS AMG ON M.id = AMG.movie_fk '.
    'LEFT JOIN genre AS G ON AMG.genre_fk = G.id '.
    'LEFT JOIN assignment_movie_actor AS AMA ON M.id = AMA.movie_fk '.
    'LEFT JOIN actor AS A ON AMA.actor_fk = A.id '.
    'LEFT JOIN assignment_movie_director AS AMD ON M.id = AMD.movie_fk '.
    'LEFT JOIN director AS D ON AMD.director_fk = D.id '.
    'GROUP BY M.id, M.name, M.type_fk, M.storage_fk, M.date, M.story, M.tmdb_id, S.name, MT.name, L.name '.
    'ORDER BY M.name; ';
#echo $sqlString.'<br /><br />';
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