<?php
include 'conexion.php';
$id = $_POST["id"];
$usuario = $_POST["usuario"];
$texto = $_POST["content"];
$noticia = $_POST["noticia"];
$email = $_POST["email"];
$hoy = getdate();
$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
$c = new conexion;
$c->nuevo_comentario_noticia($noticia, $usuario, $fecha, $texto, $email);
header( "Location: noticias.php?id=".$id);
?>