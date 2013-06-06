<?php
include 'conexion.php';
$id = $_POST["id"];
$usuario = $_POST["usuario"];
$texto = $_POST["content"];
$comic = $_POST["comic"];
$email = $_POST["email"];
$hoy = getdate();
$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
$c = new conexion;
$c->nuevo_comentario($comic, $usuario, $fecha, $texto, $email);
header( "Location: comic.php?id=".$id);
?>