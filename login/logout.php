<?php
session_start();

$baseDir = $_SESSION['baseDir'];
session_destroy();

echo json_encode('');
?>