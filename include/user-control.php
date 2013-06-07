<?php

if (empty($_SESSION['userName'])) {
    header('location: '.$_SESSION['baseUrl'].'/login/');
}

if ($_SESSION['userType'] != 'Administrator') {
    if ((!in_array($_SESSION['userType'], $allowedUserTypes) && !in_array('_ALL_', $allowedUserTypes)) ||
        (!empty($allowedUserId) && $allowedUserId != $_SESSION['userId'])) {
        header('location: '.$_SESSION['baseUrl']);
        /*die($_SESSION['userType'] . ' - ' . print_r($allowedUserTypes, true) . '<br />' .
            $allowedUserId . ' - ' . $_SESSION['userId']);*/
    }
}

?>