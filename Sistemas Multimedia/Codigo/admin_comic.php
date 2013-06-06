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
			$resultados = $con->consulta("SELECT * FROM comics WHERE nombre=\"".$_GET["dato"]."\";");
			if($fila = mysql_fetch_assoc($resultados))
			{
				$dir="comic_big/".$fila["comic_big"];
				if(file_exists($dir))
				{
					unlink($dir);
				}
				else
				{
					if(!$correcto)
					{
						$errores = $errores.'&';
					}
					$correcto = false;
					$errores = $errores."e11=1";
					echo "Este archivo ".$dir." no existe<br />";
				}
	
				
				$dir="comic_med/".$fila["comic_medium"];
				if(file_exists($dir))
				{
					unlink($dir);
				}
				else
				{
					if(!$correcto)
					{
						$errores = $errores.'&';
					}
					$correcto = false;
					$errores = $errores."e12=1";
					echo "Este archivo ".$dir." no existe<br />";
				}
				
				$dir="comic_small/".$fila["comic_small"];
				if(file_exists($dir))
				{
					unlink($dir);
				}
				else
				{
					if(!$correcto)
					{
						$errores = $errores.'&';
					}
					$correcto = false;
					$errores = $errores."e13=1";
					echo "Este archivo ".$dir." no existe<br />";
				}
					
				// ACTUALIZAR LAS ID's DE LOS DEMAS COMICS PARA QUE SE MANTENGAN ORDENADOS
				$id = $fila["id"];
				$resultado = $con->consulta("SELECT * FROM comics");
				while($fila = mysql_fetch_assoc($resultado))
				{
					if($fila["id"] > $id)
					{
						$nueva_id = $fila["id"]-1;
						if(!$con->consulta("UPDATE comics SET id=".$nueva_id." WHERE nombre=\"".$fila["nombre"]."\";"))
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
				$con->borrar_comic($_GET["dato"]);
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
			header( 'Location: Zona-admin.php?id=1&modo=2&dato=0' );
		}
		else
		{
			header( 'Location: Zona-admin.php?id=1&modo=2&dato=2&'.$errores);
		}


	}
	else if($_GET["id"]=="editar")
	{
		$correcto = true;		
		$errores = "";
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
					if(!$correcto)
					{
						$errores = $errores.'&';
					}
					$correcto = false;
					$errores= $errores."e1=1";
					echo "Error: " . $_FILES["img_big"]["error"] . "<br />";
				}
				else
				{
					if (file_exists("comic_big/" . $fila["nombre"]."_".$_FILES["img_big"]["name"]))
					{
						if(!$correcto)
						{
							$errores = $errores.'&';
							$correcto = false;
						}
						$errores= $errores."e1=2";
						echo $_FILES["img_big"]["name"] . " ya existe. ";
					}
					else
					{
						$dir="comic_big/".$fila["comic_big"];
						unlink($dir);
						move_uploaded_file($_FILES["img_big"]["tmp_name"],"comic_big/".$fila["nombre"]."_".$_FILES["img_big"]["name"]);
						if(!$con->consulta("UPDATE comics SET comic_big=\"".$fila["nombre"]."_".$_FILES["img_big"]["name"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
						{
							echo mysql_error()."  en la consulta ";
						}
					}
				}
			}
			else
			{
				if(!$correcto)
				{
					$errores = $errores.'&';
					$correcto = false;
				}
				$errores= $errores."e1=3";
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
					if(!$correcto)
					{
						$errores = $errores.'&';
					}
					$correcto = false;
					$errores= $errores."e2=1";
					echo "Error: " . $_FILES["img_med"]["error"] . "<br />";
					$correcto = false;
				}
				else
				{
					if (file_exists("comic_med/" . $fila["nombre"]."_".$_FILES["img_med"]["name"]))
					{
						if(!$correcto)
						{
							$errores = $errores.'&';
							$correcto = false;
						}
						$errores= $errores."e2=2";
						echo $_FILES["img_med"]["name"] . " ya existe. ";
					}
					else
					{
						
						$dir="comic_med/".$fila["comic_medium"];
						unlink($dir);
						move_uploaded_file($_FILES["img_med"]["tmp_name"],"comic_med/".$fila["nombre"]."_".$_FILES["img_med"]["name"]);
						if(!$con->consulta("UPDATE comics SET comic_medium=\"".$fila["nombre"]."_".$_FILES["img_med"]["name"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
						{   
							$correcto = false;
							echo mysql_error()."  en la consulta ";
						}
					}
				}
			}
			else
			{
				if(!$correcto)
					{
						$errores = $errores.'&';
					}
					$correcto = false;
				$errores= $errores."e2=3";
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
					if(!$correcto)
					{
						$errores = $errores.'&';
					}
					$correcto = false;
					$errores= $errores."e3=1";
					echo "Error: " . $_FILES["img_small"]["error"] . "<br />";
				}
				else
				{
					if (file_exists("comic_small/" . $fila["nombre"]."_".$_FILES["img_small"]["name"]))
					{
						if(!$correcto)
						{
							$errores = $errores.'&';
							$correcto = false;
						}
						$errores= $errores."e3=2";
						echo $_FILES["img_small"]["name"] . " ya existe. ";
					}
					else
					{
						$dir="comic_small/".$fila["comic_small"];
						unlink($dir);
						move_uploaded_file($_FILES["img_small"]["tmp_name"],"comic_small/".$fila["nombre"]."_".$_FILES["img_small"]["name"]);
						if(!$con->consulta("UPDATE comics SET comic_small=\"".$fila["nombre"]."_".$_FILES["img_small"]["name"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
						{
							echo mysql_error()."  en la consulta ";
							$correcto = false;
						}
					}
				}
			}
			else
			{
				if(!$correcto)
				{
					$errores = $errores.'&';
					}
				$correcto = false;
				$errores= $errores."e3=3";
				echo "Error en la imagen pequeña.";
				echo "Tipo: " . $_FILES["img_small"]["type"] . "<br />";
				echo "Tamaño: " . ($_FILES["img_small"]["size"] / 1024) . " Kb<br />";
			}
		}
		$hoy = getdate();
		$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
		if(!$con->consulta("UPDATE comics SET descripcion=\"".strip_tags(str_replace('"', "'", $_POST["text"]), '<p>')."\", tags=\"".$_POST["tags"]."\" WHERE nombre=\"".$fila["nombre"]."\";"))
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
			header( 'Location: Zona-admin.php?id=1&modo=2&dato=1' );
		}
		else
		{
			header( 'Location: Zona-admin.php?id=1&modo=2&dato=3&'.$errores );
		}
	}
}
else
{	
	$correcto = true;
	$errores = "";
	$nombre = $_POST["nomine"];
	$nombre = str_replace(" ","_",$nombre);
	// SUBIMOS EL COMIC GRANDE
	if ((($_FILES["img_big"]["type"] == "image/gif")
	|| ($_FILES["img_big"]["type"] == "image/jpeg")
	|| ($_FILES["img_big"]["type"] == "image/pjpeg")
	|| ($_FILES["img_big"]["type"] == "image/png"))
	&& ($_FILES["img_big"]["size"] < 200000000))
	{
		if ($_FILES["img_big"]["error"] > 0)
		{
			$errores = "e1=1";
			echo "Error: " . $_FILES["img_big"]["error"] . "<br />";
			$correcto = false;
		}
		else
		{
			if (file_exists("comic_big/" . $nombre."_".$_FILES["img_big"]["name"]))
			{
				$errores = "e1=2";
				echo  $_FILES["img_big"]["name"] . " ya existe. ";
				$correcto = false;
			}
			else
			{
				move_uploaded_file($_FILES["img_big"]["tmp_name"],"comic_big/".$nombre."_".$_FILES["img_big"]["name"]);
			}
		}
	}
	else
	{
		$errores = "e1=3";
		$correcto = false;
		echo  "Error en la imagen grande.";
		echo  "Tipo: " . $_FILES["img_big"]["type"] . "<br />";
		echo  "Tamaño: " . ($_FILES["img_big"]["size"] / 1024) . " Kb<br />";
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
			if(!$correcto)
			{
				$errores = $errores.'&';
				
			}
			$correcto = false;
			$errores= $errores."e2=1";
			echo  "Error: " . $_FILES["img_med"]["error"] . "<br />";
		}
		else
		{
			if (file_exists("comic_med/" . $nombre."_".$_FILES["img_med"]["name"]))
			{
				if(!$correcto)
				{
					$errores = $errores.'&';
				}
				$correcto = false;
				$errores= $errores."e2=2";
				echo  $_FILES["img_med"]["name"] . " ya existe. ";
			}
			else
			{
				move_uploaded_file($_FILES["img_med"]["tmp_name"],"comic_med/" .$nombre."_". $_FILES["img_med"]["name"]);
			}
		}
	}
	else
	{	
		if(!$correcto)
		{
			$errores = $errores.'&';
		}
		$correcto = false;
		$errores= $errores."e2=3";
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
			if(!$correcto)
			{
				$errores = $errores.'&';
			}
			$correcto = false;
			$errores= $errores."e3=1";
			echo  "Error: " . $_FILES["img_small"]["error"] . "<br />";
		}
		else
		{
			if (file_exists("comic_small/" . $nombre."_".$_FILES["img_small"]["name"]))
			{
				if(!$correcto)
				{
					$errores = $errores.'&';
				}
				$correcto = false;
				$errores= $errores."e3=2";
				echo  $_FILES["img_small"]["name"] . " ya existe. ";
			}
			else
			{
				move_uploaded_file($_FILES["img_small"]["tmp_name"],"comic_small/" .$nombre."_". $_FILES["img_small"]["name"]);
			}
		}
	}
	else
	{	
		if(!$correcto)
		{
			$errores = $errores.'&';
		}
		$correcto = false;
		$errores= $errores."e3=3";
		echo  "Error en el fichero";
		echo  "Tipo: " . $_FILES["img_small"]["type"] . "<br />";
		echo  "Tamaño: " . ($_FILES["img_small"]["size"] / 1024) . " Kb<br />";
	}

	$conn = new conexion();
	$hoy = getdate();
	$fecha = $hoy['year']."-".$hoy['mon']."-".$hoy['mday']." ".$hoy['hours'].":".$hoy['minutes'].":".$hoy['seconds'];
	echo "<br />".$fecha;
	if(!$conn->nuevo_comic($nombre, strip_tags(str_replace('"', "'", $_POST["text"]), '<p>'), $_POST["tags"], $nombre."_".$_FILES["img_small"]["name"], $nombre."_".$_FILES["img_med"]["name"], $nombre."_".$_FILES["img_big"]["name"], $fecha))
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
		header( 'Location: Zona-admin.php?id=1&modo=1&dato=1' );
	}
	else
	{
		header( 'Location: Zona-admin.php?id=1&modo=1&dato=2&'.$errores);

	}
}
?>
