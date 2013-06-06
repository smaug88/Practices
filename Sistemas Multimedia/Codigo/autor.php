<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>West Waterirk</title>
<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
<link rel="stylesheet" type="text/css" href="estilo/autor.css" />
</head>

<body>
<br /><br />
<?php 
	include 'menu.php';
?>
<?php
	include 'conexion.php';
	$conn = new conexion;
	$resultado = $conn->consulta("SELECT * FROM administracion");
	$fila = mysql_fetch_assoc($resultado);
?>
<div id="cuerpo_autor">
	<div class="Parte_superior">
    	<div class="texto1">
        <?php
			$texto = $fila["texto_autor1"];
			echo $texto;
		?>
        </div>
        <div class="foto1">
        <?php
			echo "<img src='autor/".$fila["imagen_autor1"]."'/>";
		?>
        </div>
    </div>
    <div class="salto"></div>
    <br /><br />
    <div class="Parte_inferior">
        <div class="foto2">
        <?php
			echo "<img src='autor/".$fila["imagen_autor2"]."'/>";
		?>
        </div>
    	<div class="texto2">
        <?php
			echo $fila["texto_autor2"];
		?>
        </div>
    </div>
    <div class="salto"></div>
    <br /><br />
    <div class="base">
        <br /><br /><br />
    </div>
</div>
</body>
</html>