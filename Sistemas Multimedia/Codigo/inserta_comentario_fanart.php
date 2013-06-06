<?php
include 'conexion.php';
$id = $_POST["id"];
$usuario = $_POST["usuario"];
$texto = $_POST["content"];
$comic = $_POST["fanart"];
$email = $_POST["email"];
$hoy = getdate();
$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
$c = new conexion;
$RComentarios = $c->nuevo_comentario_fanart($comic, $usuario, $fecha, $texto, $email);
if(!$RComentarios)
{
	echo mysql_error()."  en la consulta ".$comic;
}
header( "Location: fanart.php?id=".$id);
?>