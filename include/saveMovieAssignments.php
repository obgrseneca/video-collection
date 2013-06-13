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

function saveMovieAssignments($type, $dbConnection, $assignments, $movieId, $dbAnswer) {
    $sqlString = "SELECT * FROM ".$type."; ";
    $dbResult = $dbConnection->readData($sqlString);
    $dbAnswer = $dbAnswer && (($dbResult !== false) ? true : false);
    $existingAssignments = array();
    foreach ($dbResult as $row) {
        $existingAssignments[$row['id']] = $row['name'];
    }

    $addAssignments = array();
    $newAssignments = array();
    foreach ($assignments AS $aRow) {
        if (in_array(trim($aRow), $existingAssignments)) {
            foreach ($existingAssignments as $k => $v) {
                if (trim($aRow) == $v) {
                    array_push($addAssignments, $k);
                }
            }
        } else {
            array_push($newAssignments, $aRow);
        }
    }
    if (count($newAssignments) > 0) {
        foreach ($newAssignments as $aRow) {
            if (trim($aRow) != '') {
                $sqlString = 'INSERT INTO '.$type.' ' .
                    '(name)' .
                    'VALUES' .
                    '(' . $dbConnection->escapeString(trim($aRow), 'str') . '); ';
                $assignmentId = $dbConnection->writeData($sqlString, true);
                $assignmentId = ($assignmentId) ? $assignmentId : -1;
                $dbAnswer = (($assignmentId != -1) ? true : false) && $dbAnswer;

                if ($assignmentId != -1) {
                    array_push($addAssignments, $assignmentId);
                }
            }
        }
    }
    $sqlString = 'DELETE FROM assignment_movie_'.$type.' ' .
        'WHERE movie_fk = '.$movieId.'; ';
    $dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);

    if (count($addAssignments) > 0) {
        $sqlString = 'INSERT INTO assignment_movie_'.$type.' ' .
            '(movie_fk, '.$type.'_fk) ' .
            'VALUES ';
        $sqlString2 = '';
        foreach ($addAssignments as $aRow) {
            $sqlString2 .= '(' . $movieId . ', ' . $aRow . '), ';
        }
        $sqlString .= rtrim($sqlString2, ', ') . '; ';
        $dbAnswer = $dbAnswer && $dbConnection->writeData($sqlString);
    }

    return $dbAnswer;
}

?>
