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

$dbAnswer = false;
if (!file_exists($_SESSION['baseDir'].'/config.inc')) {
    require($_SESSION['baseDir'].'/include/writeConfigFile.php');
    require $_SESSION['baseDir'].'/classes/DbConnectionClass.php';

    $dbConnection = new DbConnectionClass();
    $dbAnswer = ($dbConnection->getDbConnection() != false);
    unlink($_SESSION['baseDir'].'/config.inc');
}

echo json_encode($dbAnswer);
?>