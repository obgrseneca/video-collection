<?php
session_start();

$baseUrl = $_SESSION['baseUrl'];
session_destroy();

echo json_encode($baseUrl);
?>