<?php
session_start();

if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}
$allowedUserTypes = array('Administrator', 'Standard');
require($_SESSION['baseDir'].'/include/user-control.php');

require 'smarty/Smarty.class.php';
require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

$dbConnection = new DbConnectionClass();
$movieId = $dbConnection->escapeString((!empty($_GET['movieId'])) ? $_GET['movieId'] : -1);

$movieSql = 'SELECT M.*, '.
    'GROUP_CONCAT(DISTINCT G.name ORDER BY G.name SEPARATOR \'; \') AS genres, '.
    'GROUP_CONCAT(DISTINCT A.name ORDER BY A.name SEPARATOR \'; \') AS actors, '.
    'GROUP_CONCAT(DISTINCT D.name ORDER BY D.name SEPARATOR \'; \') AS directors '.
    'FROM movie AS M '.
    'LEFT JOIN assignment_movie_genre AS AMG ON M.id = AMG.movie_fk '.
    'LEFT JOIN genre AS G ON AMG.genre_fk = G.id '.
    'LEFT JOIN assignment_movie_actor AS AMA ON M.id = AMA.movie_fk '.
    'LEFT JOIN actor AS A ON AMA.actor_fk = A.id '.
    'LEFT JOIN assignment_movie_director AS AMD ON M.id = AMD.movie_fk '.
    'LEFT JOIN director AS D ON AMD.director_fk = D.id '.
    'WHERE M.id = '.$movieId;
$movie = $dbConnection->readData($movieSql);
//$genres = $dbConnection->readData('SELECT * FROM genre ORDER BY name; ');
//$actors = $dbConnection->readData('SELECT * FROM actor ORDER BY name; ');
//$directors = $dbConnection->readData('SELECT * FROM director ORDER BY name; ');
$types = $dbConnection->readData('SELECT * FROM movie_type ORDER BY name; ');
$storages = $dbConnection->readData('SELECT * FROM storage ORDER BY name; ');
$languages = $dbConnection->readData('SELECT * FROM language ORDER BY name; ');


$smarty = new Smarty();
$smarty->setTemplateDir($_SESSION['baseDir'].'/smarty/templates/');
$smarty->setCompileDir($_SESSION['baseDir'].'/smarty/templates_c/');
$smarty->setConfigDir($_SESSION['baseDir'].'/smarty/configs/');
$smarty->setCacheDir($_SESSION['baseDir'].'/smarty/cache/');

$smarty->assign('javascriptDir', $_SESSION['baseUrl'].'javascript/');
$smarty->assign('baseUrl', $_SESSION['baseUrl']);
$smarty->assign('userType', $_SESSION['userType']);
$smarty->assign('userName', $_SESSION['userName']);

$smarty->assign('movieId', $movieId);
$smarty->assign('movie', $movie[0]);
//$smarty->assign('genres', $genres);
//$smarty->assign('actors', $actors);
//$smarty->assign('directors', $directors);
$smarty->assign('types', $types);
$smarty->assign('storages', $storages);
$smarty->assign('languages', $languages);

$smarty->display('control-center/movie-edit.tpl');

?>