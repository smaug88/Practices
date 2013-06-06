<?php

include 'conexion.php';
if(isset($_GET["id"]))
{
	if($_GET["id"]=="borrar")
	{		
		$correcto = true;
		$errores = "";
		if(isset($_GET["dato"])) 
		{
			$con = new conexion();
			$resultados = $con->consulta("SELECT * FROM noticias WHERE titulo=\"".$_GET["dato"]."\";");
			if($fila = mysql_fetch_assoc($resultados))
			{
				
				// ACTUALIZAR LAS ID's DE LOS DEMAS COMICS PARA QUE SE MANTENGAN ORDENADOS
				$id = $fila["id"];
				$resultado = $con->consulta("SELECT * FROM noticias");
				while($fila = mysql_fetch_assoc($resultado))
				{
					if($fila["id"] > $id)
					{
						$nueva_id = $fila["id"]-1;
						if(!$con->consulta("UPDATE noticias SET id=".$nueva_id." WHERE titulo=\"".$fila["titulo"]."\";"))
						{
							if(!$correcto)
							{
								$errores = $errores.'&';
							}
							$correcto = false;
							$errores= $errores."e2=1"; // Error al actualizar la BBDD
						}
					}
				}
				$con->borrar_noticia($_GET["dato"]);
			}
			else 
			{
				if(!$correcto)
				{
					$errores = $errores.'&';
				}
				$correcto = false;
				$errores= $errores."e3=1"; //"Error al borrar, no existe ese comic<br />"
			}
		}
		else 
		{
				if(!$correcto)
				{
					$errores = $errores.'&';
				}
				$correcto = false;
				$errores= $errores."e4=1";  //"Error 506: Comando en direccion erroneo<br />";
		}
		ob_start(); // ensures anything dumped out will be caught
		while (ob_get_status()) 
		{
			ob_end_clean();
		}
		if($correcto)
		{
			header( 'Location: Zona-admin.php?id=6&modo=2&dato=0' );
		}
		else
		{
			header( 'Location: Zona-admin.php?id=6&modo=2&dato=2&'.$errores);
		}


	}
	else if($_GET["id"]=="editar")
	{
		$correcto = true;		
		$errores = "";
		$con = new conexion();
		$resultados = $con->consulta("SELECT * FROM noticias WHERE titulo=\"".$_GET["dato"]."\";");
		$fila = mysql_fetch_assoc($resultados);
		
		$hoy = getdate();
		$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
		if(!$con->consulta("UPDATE noticias SET corto=\"".strip_tags(str_replace('"', "'", $_POST["resumen"]), '<p>')."\" WHERE titulo=\"".$fila["titulo"]."\";"))
		{
			echo mysql_error()."  en la consulta ";
			$correcto = false;
		}
		else if(!$con->consulta("UPDATE noticias SET texto=\"".strip_tags(str_replace('"', "'", $_POST["texto"]), '<p>')."\" WHERE titulo=\"".$fila["titulo"]."\";"))
		{
			echo mysql_error()."  en la consulta ";
			$correcto = false;
		}
		ob_start(); // ensures anything dumped out will be caught
		while (ob_get_status()) 
		{
			ob_end_clean();
		}
		if($correcto)
		{	
			header( 'Location: Zona-admin.php?id=6&modo=2&dato=1' );
		}
		else
		{
			header( 'Location: Zona-admin.php?id=6&modo=2&dato=3&'.$errores );
		}
			
			
			
	}
}
else
{	
	$correcto = true;
	$errores = "";
	
	$conn = new conexion();
	$hoy = getdate();
	$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
	$titulo = $_POST["titulo"];
	$resumen = $_POST["resumen"];
	$texto = $_POST["texto"];
	$titulo = strip_tags(str_replace('"', "'", $titulo), '<p>');
	$resumen = strip_tags(str_replace('"', "'", $resumen), '<p>');
	$texto = strip_tags(str_replace('"', "'", $texto), '<p>');
	if(!$conn->nueva_noticia($titulo, $resumen, $texto, $fecha))
	{
		if(!$correcto)
		{
			$errores = $errores.'&';
		}
		$correcto = false;
		$errores= $errores."e4=1";
	}
	ob_start(); // ensures anything dumped out will be caught
	while (ob_get_status()) 
	{
		ob_end_clean();
	}
	if($correcto)
	{
		header('Location: Zona-admin.php?id=6&modo=1&dato=1');
	}
	else
	{
		header('Location: Zona-admin.php?id=6&modo=1&dato=2&'.$errores);
	}
}
?>
