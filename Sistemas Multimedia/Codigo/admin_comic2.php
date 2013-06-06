<?php

include 'conexion.php';
if(isset($_GET["id"]))
{
	if($_GET["id"]=="borrar")
	{		
		if(isset($_GET["dato"])) 
		{
			$con = new conexion();
			$resultados = $con->consulta("SELECT * FROM comics WHERE nombre=\"".$_GET["dato"]."\";");
			if($fila = mysql_fetch_assoc($resultados))
			{
				$dir="comic_big/".$fila["comic_big"];
				if(file_exists($dir))
				{
					if(unlink($dir))
						print "El archivo ".$dir." fue borrado<br />";
				}
				else
					print "Este archivo ".$dir." no existe<br />"; 
				
				$dir="comic_med/".$fila["comic_medium"];
				if(file_exists($dir))
				{
					if(unlink($dir))
						print "El archivo ".$dir." fue borrado<br />";
				}
				else
					print "Este archivo ".$dir." no existe<br />"; 
				
				$dir="comic_small/".$fila["comic_small"];
				if(file_exists($dir))
				{
					if(unlink($dir))
						print "El archivo ".$dir." fue borrado<br />";
				}
				else
					print "Este archivo ".$dir." no existe<br />"; 
					
				// ACTUALIZAR LAS ID's DE LOS DEMAS COMICS PARA QUE SE MANTENGAN ORDENADOS
				$id = $fila["id"];
				$resultado = $con->consulta("SELECT * FROM comics");
				while($fila = mysql_fetch_assoc($resultado))
				{
					if($fila["id"] > $id)
					{
						$nueva_id = $fila["id"]-1;
						echo "Nueva ID: " .$nueva_id."<br />";
						if(!$con->consulta("UPDATE comics SET id=".$nueva_id." WHERE nombre=\"".$fila["nombre"]."\";"))
						{
							echo mysql_error()."  en la consulta ";
						}
						echo "UPDATE comics SET id=".$nueva_id." WHERE nombre=\"".$fila["nombre"]."\";<br />";
					}
				}
				$con->borrar_comic($_GET["dato"]);
				echo "Comic ".$_GET["dato"]." borrado <br />";
			}
			else echo "Error al borrar, no existe ese comic<br />";
		}
		else echo "Error 506: Comando en direccion erroneo<br />";
		ob_start(); // ensures anything dumped out will be caught
		while (ob_get_status()) 
			{
				ob_end_clean();
			}

		header( "Location: Zona-admin.php?id=1&modo=2" );
		


	}
	else if($_GET["id"]=="editar")
	{
		$nombre = $_POST["nomine"];
		$correcto = true;		
		$con = new conexion();
		$resultados = $con->consulta("SELECT * FROM comics WHERE nombre=\"".$_GET["dato"]."\";");
		$fila = mysql_fetch_assoc($resultados);
		
		// Primero comprobar que se mando un comic grande
		if($_FILES["img_big"]["name"]!=null)
		{
			
			if ((($_FILES["img_big"]["type"] == "image/gif")
			|| ($_FILES["img_big"]["type"] == "image/jpeg")
			|| ($_FILES["img_big"]["type"] == "image/pjpeg")
			|| ($_FILES["img_big"]["type"] == "image/png"))
			&& ($_FILES["img_big"]["size"] < 200000000))
			{
				if ($_FILES["img_big"]["error"] > 0)
				{
					echo "Error: " . $_FILES["img_big"]["error"] . "<br />";
					$correcto = false;
				}
				else
				{
					if (file_exists("comic_big/" . $nombre."_".$_FILES["img_big"]["name"]))
					{
						echo $_FILES["img_big"]["name"] . " ya existe. ";
						$correcto = false;
					}
					else
					{
						$dir="comic_big/".$fila["comic_big"];
						unlink($dir);
						move_uploaded_file($_FILES["img_big"]["tmp_name"],"comic_big/".$nombre."_".$_FILES["img_big"]["name"]);
						if(!$con->consulta("UPDATE comics SET comic_big=\"".$fila["comic_big"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
						{
							echo mysql_error()."  en la consulta ";
						}
						echo "<h1>Imagen grande actualizada correctamente.</h1>";
					}
				}
			}
			else
			{
				$correcto = false;
				echo "Error en la imagen grande.";
				echo "Tipo: " . $_FILES["img_big"]["type"] . "<br />";
				echo "Tamaño: " . ($_FILES["img_big"]["size"] / 1024) . " Kb<br />";
			}
		}
		// Segundo comprobar que se mando un comic mediano
		if($_FILES["img_med"]["name"]!=null)
		{		
			if ((($_FILES["img_med"]["type"] == "image/gif")
			|| ($_FILES["img_med"]["type"] == "image/jpeg")
			|| ($_FILES["img_med"]["type"] == "image/pjpeg")
			|| ($_FILES["img_med"]["type"] == "image/png"))
			&& ($_FILES["img_med"]["size"] < 200000000))
			{
				if ($_FILES["img_med"]["error"] > 0)
				{
					echo "Error: " . $_FILES["img_med"]["error"] . "<br />";
					$correcto = false;
				}
				else
				{
					if (file_exists("comic_med/" . $nombre."_".$_FILES["img_med"]["name"]))
					{
						echo $_FILES["img_med"]["name"] . " ya existe. ";
						$correcto = false;
					}
					else
					{
						$dir="comic_med/".$fila["comic_med"];
						unlink($dir);
						move_uploaded_file($_FILES["img_med"]["tmp_name"],"comic_med/".$nombre."_".$_FILES["img_med"]["name"]);
						if(!$con->consulta("UPDATE comics SET comic_med=\"".$fila["comic_med"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
						{
							echo mysql_error()."  en la consulta ";
						}
						echo "<h1>Imagen mediana actualizada correctamente.</h1>";
					}
				}
			}
			else
			{
				$correcto = false;
				echo "Error en la imagen mediana.";
				echo "Tipo: " . $_FILES["img_med"]["type"] . "<br />";
				echo "Tamaño: " . ($_FILES["img_med"]["size"] / 1024) . " Kb<br />";
			}
		}
		// Tercero comprobar que se mando un comic pequeño
		if($_FILES["img_small"]["name"]!=null)
		{
			
			if ((($_FILES["img_small"]["type"] == "image/gif")
			|| ($_FILES["img_small"]["type"] == "image/jpeg")
			|| ($_FILES["img_small"]["type"] == "image/pjpeg")
			|| ($_FILES["img_small"]["type"] == "image/png"))
			&& ($_FILES["img_small"]["size"] < 200000000))
			{
				if ($_FILES["img_small"]["error"] > 0)
				{
					echo "Error: " . $_FILES["img_small"]["error"] . "<br />";
					$correcto = false;
				}
				else
				{
					if (file_exists("comic_small/" . $nombre."_".$_FILES["img_small"]["name"]))
					{
						echo $_FILES["img_small"]["name"] . " ya existe. ";
						$correcto = false;
					}
					else
					{
						$dir="comic_small/".$fila["comic_small"];
						unlink($dir);
						move_uploaded_file($_FILES["img_small"]["tmp_name"],"comic_small/".$nombre."_".$_FILES["img_small"]["name"]);
						if(!$con->consulta("UPDATE comics SET comic_small=\"".$fila["comic_small"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
						{
							echo mysql_error()."  en la consulta ";
						}
						echo "<h1>Imagen pequeña actualizada correctamente.</h1>";
					}
				}
			}
			else
			{
				$correcto = false;
				echo "Error en la imagen pequeña.";
				echo "Tipo: " . $_FILES["img_small"]["type"] . "<br />";
				echo "Tamaño: " . ($_FILES["img_small"]["size"] / 1024) . " Kb<br />";
			}
		}
		$hoy = getdate();
		$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
		echo "<br />".$fecha;
		if(!$con->consulta("UPDATE comics SET descripcion=\"".$_POST["text"]."\", tags=\"".$_POST["tags"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
		{
			echo mysql_error()."  en la consulta ";
		}
		if($nombre != $fila["nombre"])
		{
			if(!$con->consulta("UPDATE comics SET nombre=\"".$nombre."\" WHERE nombre=\"".$fila["nombre"]."\";"))
			{
				echo mysql_error()."  en la consulta ";
			}
		}
		//if($correcto)header( "Location: Zona-admin.php?id=1&modo=1&dato=1" );		
	}
}
else
{	
	$correcto = true;
	$nombre = $_POST["nomine"];
	// SUBIMOS EL COMIC GRANDE
	if ((($_FILES["img_big"]["type"] == "image/gif")
	|| ($_FILES["img_big"]["type"] == "image/jpeg")
	|| ($_FILES["img_big"]["type"] == "image/pjpeg")
	|| ($_FILES["img_big"]["type"] == "image/png"))
	&& ($_FILES["img_big"]["size"] < 200000000))
	{
		if ($_FILES["img_big"]["error"] > 0)
		{
			echo "Error: " . $_FILES["img_big"]["error"] . "<br />";
			$correcto = false;
		}
		else
		{
			if (file_exists("comic_big/" . $nombre."_".$_FILES["img_big"]["name"]))
			{
				echo $_FILES["img_big"]["name"] . " ya existe. ";
				$correcto = false;
			}
			else
			{
				move_uploaded_file($_FILES["img_big"]["tmp_name"],"comic_big/".$nombre."_".$_FILES["img_big"]["name"]);
				echo "<h1>Imagen grande subida correctamente.</h1>";
			}
		}
	}
	else
	{
		$correcto = false;
		echo "Error en la imagen grande.";
		echo "Tipo: " . $_FILES["img_big"]["type"] . "<br />";
		echo "Tamaño: " . ($_FILES["img_big"]["size"] / 1024) . " Kb<br />";
	}

	// SUBIMOS EL COMIC MEDIANO
	if ((($_FILES["img_med"]["type"] == "image/gif")
	|| ($_FILES["img_med"]["type"] == "image/jpeg")
	|| ($_FILES["img_med"]["type"] == "image/pjpeg")
	|| ($_FILES["img_med"]["type"] == "image/png"))
	&& ($_FILES["img_med"]["size"] < 200000000))
	{
		if ($_FILES["img_med"]["error"] > 0)
		{
			echo "Error: " . $_FILES["img_med"]["error"] . "<br />";
		}
		else
		{
			if (file_exists("comic_med/" . $nombre."_".$_FILES["img_med"]["name"]))
			{
				$correcto = false;
				echo $_FILES["img_med"]["name"] . " ya existe. ";
			}
			else
			{
				move_uploaded_file($_FILES["img_med"]["tmp_name"],"comic_med/" .$nombre."_". $_FILES["img_med"]["name"]);
				echo "<h1>Imagen mediana subida correctamente.</h1>";
			}
		}
	}
	else
	{	$correcto = false;
		echo "Error en el fichero";
		echo "Tipo: " . $_FILES["img_med"]["type"] . "<br />";
		echo "Tamaño: " . ($_FILES["img_med"]["size"] / 1024) . " Kb<br />";
	}

	// SUBIMOS EL COMIC PEQUEÑO
	if ((($_FILES["img_small"]["type"] == "image/gif")
	|| ($_FILES["img_small"]["type"] == "image/jpeg")
	|| ($_FILES["img_small"]["type"] == "image/pjpeg")
	|| ($_FILES["img_small"]["type"] == "image/png"))
	&& ($_FILES["img_small"]["size"] < 200000000))
	{
		if ($_FILES["img_small"]["error"] > 0)
		{
			$correcto = false;
			echo "Error: " . $_FILES["img_small"]["error"] . "<br />";
		}
		else
		{
			if (file_exists("comic_small/" . $nombre."_".$_FILES["img_small"]["name"]))
			{
				$correcto = false;
				echo $_FILES["img_small"]["name"] . " ya existe. ";
			}
			else
			{
				move_uploaded_file($_FILES["img_small"]["tmp_name"],"comic_small/" .$nombre."_". $_FILES["img_small"]["name"]);
				echo "<h1>Imagen peque&ntilde;a subida correctamente.</h1>";
			}
		}
	}
	else
	{	
		$correcto = false;
		echo "Error en el fichero";
		echo "Tipo: " . $_FILES["img_small"]["type"] . "<br />";
		echo "Tamaño: " . ($_FILES["img_small"]["size"] / 1024) . " Kb<br />";
	}

	$conn = new conexion();
	$hoy = getdate();
	$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
	echo "<br />".$fecha;
	$conn->nuevo_comic($_POST["nomine"], $_POST["text"], $_POST["tags"], $nombre."_".$_FILES["img_small"]["name"], $nombre."_".$_FILES["img_med"]["name"], $nombre."_".$_FILES["img_big"]["name"], $fecha);
	if($correcto)header( "Location: Zona-admin.php?id=1&modo=1&dato=1" );
}
?>
