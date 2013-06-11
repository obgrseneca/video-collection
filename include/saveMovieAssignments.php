<?php
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
