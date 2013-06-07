<?php
$config = file_get_contents($_SESSION['baseDir'].'/configuration/config.inc.in');

$config = preg_replace('/%HOSTNAME%/', $_POST['dbHostname'], $config);
$config = preg_replace('/%USER%/', $_POST['dbUser'], $config);
$config = preg_replace('/%PASSWORD%/', $_POST['dbPassword'], $config);
$config = preg_replace('/%DATABASE%/', $_POST['dbName'], $config);

file_put_contents($_SESSION['baseDir'].'/config.inc', $config);
?>