<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>West Waterirk</title>
		<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
		<link rel="stylesheet" type="text/css" href="estilo/main.css" />
	</head>

	<body>
		<br /><br />
		<?php 
			include 'menu.php';
			include 'conexion.php';
			$con = new conexion();
			$resultado = $con->consulta("SELECT * FROM comics");
			$total = mysql_num_rows($resultado);
			$id = $total-1;
			$resultado = $con->consulta("SELECT comic_medium FROM comics WHERE id=".$id);
			$fila = mysql_fetch_assoc($resultado);
			$imagen = $fila["comic_medium"];
			$resultado = $con->consulta("SELECT * FROM administracion WHERE id=1");
			$fila = mysql_fetch_assoc($resultado);
			$imagen_portada = $fila["imagen_portada"];
			$mascara = $fila["imagen_mascara"];
		?>
		<div class="preview">
			<img class="bajo" src="comic_med/<?php echo $imagen; ?>"/>
			<a href="comic.php"><img class="sobre" src="<?php echo "portada/".$mascara; ?>" /></a>
		</div>
		<div class="zona_inferior">
			<div class="imagen_main">
				<img src="<?php echo "portada/".$imagen_portada; ?>" />
			</div>
			<div class="noticias">
            	<a href="noticias.php"><img src="noticias.gif"/></a>
                <div class="conjunto">
			<?php
				$resultado = $con->consulta("SELECT * FROM noticias");
				$total = mysql_num_rows($resultado);
				$i = $total-1;
				while(($i>=0)&&($total-$i<4))
				{
					$resultado = $con->consulta("SELECT * FROM noticias WHERE id=".$i);
					$fila = mysql_fetch_assoc($resultado);
					$titulo = $fila["titulo"];
					$texto = $fila["corto"];
					$fecha = $fila["fecha"];
					?>
					<div class="noticia_individual">
						<?php echo "<b>Titulo: &nbsp;".$titulo."</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br /><br />".$texto."<br /><a href='noticias.php?id=".$i."'>Leer m&aacute;s...</a>";
						?>
					</div>
					<?php
					$i--;
				}
			?>
                </div>
			</div>
		</div>
        <div class="base2">
            <br /><br /><br />
        </div>
	</body>
</html>