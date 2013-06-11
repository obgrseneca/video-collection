<?php
session_start();
if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}

$dbAnswer = 0;
if (!file_exists($_SESSION['baseDir'].'/config.inc')) {
    require($_SESSION['baseDir'].'/include/writeConfigFile.php');
    require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

    $dbConnection = new DbConnectionClass();
    $tmpDbAnswer = true;
    $dbQuery = '';
    if ($dbConnection->getDbSelection() == false) {

        // Create the database
        $sqlString = "CREATE DATABASE ".$_POST['dbName']." CHARACTER SET utf8; ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);


        // Table user_type
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".user_type ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL UNIQUE ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);
        $sqlString = "INSERT INTO ".$_POST['dbName'].".user_type ".
            "(name) ".
            "VALUES ".
            "('Administrator'), ('Standard'), ('Guest'); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table user
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".user ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL UNIQUE, ".
            "email VARCHAR(255) NOT NULL, ".
            "type_fk INT, ".
            "salt VARCHAR(255), ".
            "password_hash VARCHAR(255), ".
            "CONSTRAINT user_user_type_fk FOREIGN KEY(type_fk) REFERENCES user_type(id) ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);
        $sqlString = "INSERT INTO ".$_POST['dbName'].".user ".
        "(name, email, type_fk, salt, password_hash) ".
        "VALUES ".
        "('admin', 'admin@localhost', 1, '4f98286f3075be9820f3aa3745a0207b9a836445', '27bad8256a33378179dfd9b6bd045de499de3a10'); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table genre
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".genre ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL UNIQUE ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table movie_type
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".movie_type ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL UNIQUE ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);
        $sqlString = "INSERT INTO ".$_POST['dbName'].".movie_type ".
            "(name) ".
            "VALUES ".
            "('Movie'), ('Series'), ('Documentation'); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table actor
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".actor ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL UNIQUE ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table director
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".director ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL UNIQUE ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table storage
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".storage ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL UNIQUE ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table movie
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".movie ( ".
            "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, ".
            "name VARCHAR(255) NOT NULL, ".
            "type_fk INT, ".
            "storage_fk INT, ".
            "CONSTRAINT movie_storage_fk FOREIGN KEY(storage_fk) REFERENCES storage(id), ".
            "CONSTRAINT movie_movie_type_fk FOREIGN KEY(type_fk) REFERENCES movie_type(id) ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table assignment_movie_genre
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".assignment_movie_genre ( ".
            "movie_fk INT, ".
            "genre_fk INT, ".
            "CONSTRAINT movie_movie_genre_fk FOREIGN KEY(movie_fk) REFERENCES movie(id), ".
            "CONSTRAINT genre_movie_genre_fk FOREIGN KEY(genre_fk) REFERENCES genre(id) ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table assignment_movie_actor
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".assignment_movie_actor ( ".
            "movie_fk INT, ".
            "actor_fk INT, ".
            "CONSTRAINT movie_movie_actor_fk FOREIGN KEY(movie_fk) REFERENCES movie(id), ".
            "CONSTRAINT actor_movie_actor_fk FOREIGN KEY(actor_fk) REFERENCES actor(id) ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);

        // Table assignment_movie_director
        $sqlString = "CREATE TABLE ".$_POST['dbName'].".assignment_movie_director ( ".
            "movie_fk INT, ".
            "director_fk INT, ".
            "CONSTRAINT movie_movie_director_fk FOREIGN KEY(movie_fk) REFERENCES movie(id), ".
            "CONSTRAINT actor_movie_director_fk FOREIGN KEY(director_fk) REFERENCES director(id) ".
            "); ";
        $dbQuery .= $sqlString;
        $tmpDbAnswer = $tmpDbAnswer && $dbConnection->writeData($sqlString);


        $dbAnswer = ($tmpDbAnswer) ? 1 : 3;
    } else {
        $dbAnswer = 2;
    }
    unlink($_SESSION['baseDir'].'/config.inc');
}

echo json_encode(array($dbAnswer,$dbQuery));
?>