<?php

/*
 * Copyright (c) 2013 Oliver Burger obgr_seneca@mageia.org
 *
 * This file is part of video-collection.
 *
 * video-collection is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * video-collection is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with video-collection.  If not, see <http://www.gnu.org/licenses/>.
 */

session_start();
if (empty($_SESSION['baseUrl'])) {
    die('Fatal error!');
}

$dbName = $_POST['dbName'];

$errors = array('fatal' => array(), 'warning' => array());
if (!file_exists($_SESSION['baseDir'].'/config.inc')) {
    require($_SESSION['baseDir'].'/include/writeConfigFile.php');
    require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

    $dbConnection = new DbConnectionClass();

    // check all tables are present and no extra tables
    $errors = checkTableExistence($dbConnection, $dbName, $errors);

    //check the integrity of the required tables
    $tableUserLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'email', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => '', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'type_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'salt', 'Type' => 'varchar(255)', 'Null' => 'YES', 'Key' => '', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'password_hash', 'Type' => 'varchar(255)', 'Null' => 'YES', 'Key' => '', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'user', $tableUserLayout, $errors);

    $tableUserTypeLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'user_type', $tableUserTypeLayout, $errors);

    $tableMovieLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => '', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'year', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => '', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'date', 'Type' => 'date', 'Null' => 'YES', 'Key' => '', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'story', 'Type' => 'text', 'Null' => 'YES', 'Key' => '', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'tmdb_id', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => '', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'language_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'type_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'storage_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => ''),
    );
    $errors = checkTableIntegrity($dbConnection, 'movie', $tableMovieLayout, $errors);

    $tableMovieTypeLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'movie_type', $tableMovieTypeLayout, $errors);

    $tableConfigLayout = array(
        array('Field' => 'config_key', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'config_value', 'Type' => 'varchar(255)', 'Null' => 'YES', 'Key' => '', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'config', $tableConfigLayout, $errors);

    $tableGenreLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'genre', $tableGenreLayout, $errors);

    $tableLanguageLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'acronym', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'language', $tableLanguageLayout, $errors);

    $tableActorLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'actor', $tableActorLayout, $errors);

    $tableDirectorLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'director', $tableDirectorLayout, $errors);

    $tableStorageLayout = array(
        array('Field' => 'id', 'Type' => 'int(11)', 'Null' => 'NO', 'Key' => 'PRI', 'Default' => NULL, 'Extra' => 'auto_increment'),
        array('Field' => 'name', 'Type' => 'varchar(255)', 'Null' => 'NO', 'Key' => 'UNI', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'storage', $tableStorageLayout, $errors);

    $tableAssignmentMovieActor = array(
        array('Field' => 'movie_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'actor_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'assignment_movie_actor', $tableAssignmentMovieActor, $errors);

    $tableAssignmentMovieDirector = array(
        array('Field' => 'movie_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'director_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'assignment_movie_director', $tableAssignmentMovieDirector, $errors);

    $tableAssignmentMovieGenre = array(
        array('Field' => 'movie_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => ''),
        array('Field' => 'genre_fk', 'Type' => 'int(11)', 'Null' => 'YES', 'Key' => 'MUL', 'Default' => NULL, 'Extra' => '')
    );
    $errors = checkTableIntegrity($dbConnection, 'assignment_movie_genre', $tableAssignmentMovieGenre, $errors);

    unlink($_SESSION['baseDir'].'/config.inc');
};

function checkTableExistence($dbConnection, $dbName, $errors) {
    $sqlString = 'SHOW TABLES; ';
    $dbResult = $dbConnection->readData($sqlString);

    $requiredTables = array('user', 'movie', 'genre', 'actor', 'director', 'movie_type', 'user_type', 'storage',
        'config', 'language', 'assignment_movie_actor', 'assignment_movie_director', 'assignment_movie_genre');
    $existingTables = array();
    $extraTables = array();
    $missingTables = array();
    foreach ($dbResult as $row) {
        array_push($existingTables, $row['Tables_in_'.$dbName]);
        if (!in_array($row['Tables_in_'.$dbName], $requiredTables)) {
            array_push($extraTables, $row['Tables_in_'.$dbName]);
        }
    }
    unset($table);
    foreach ($requiredTables as $table) {
        if (!in_array($table, $existingTables)) {
            array_push($missingTables, $table);
        }
    }
    unset($table);
    if (count($missingTables) > 0) {
        array_push($errors['fatal'], 'Mising tables : '.implode(', ', $missingTables));
    }
    if (count($extraTables) > 0) {
        array_push($errors['warning'], 'Extra tables : '.implode(', ', $extraTables));
    }

    return $errors;
}

function checkTableIntegrity($dbConnection, $tableName, $tableLayout, $errors) {
    $sqlString = 'SHOW COLUMNS FROM '.$tableName.'; ';
    $dbResult = $dbConnection->readData($sqlString);

    $missingColumns = array();
    $wronglyFormattedColumns = array();
    $extraColumns = array();
    foreach($tableLayout AS $requiredColumn) {
        array_push($missingColumns, $requiredColumn['Field']);
        foreach ($dbResult AS $existingColumn) {
            if ($requiredColumn['Field'] == $existingColumn['Field']) {
                $foo = array_pop($missingColumns);
                foreach($requiredColumn AS $k => $v) {
                    if ($existingColumn[$k] != $v) {
                        array_push($wronglyFormattedColumns, $requiredColumn['Field']." : ".$k." is ".$existingColumn[$k]." - should be ".$v);
                    }
                }
            }
        }
    }
    foreach ($dbResult AS $existingColumn) {
        array_push($extraColumns, $existingColumn['Field']);
        foreach($tableLayout AS $requiredColumn) {
            if ($requiredColumn['Field'] == $existingColumn['Field']) {
                $foo = array_pop($extraColumns);
            }
        }
    }

    if (count($missingColumns) > 0) {
        array_push($errors['fatal'], 'Columns are missing in table '.$tableName.' : '.implode(', ', $missingColumns));
    }
    if (count($wronglyFormattedColumns) > 0) {
        array_push($errors['fatal'], 'Wrongly formatted colums in '.$tableName.' : <br />&nbsp;&ndash;&nbsp;'.implode('<br />&nbsp;&ndash;&nbsp;', $wronglyFormattedColumns));
    }
    if (count($extraColumns) > 0) {
        array_push($errors['warning'], 'Extra columns in table '.$tableName.' : '.implode(', ', $extraColumns));
    }


    return $errors;
}

echo json_encode($errors);
?>