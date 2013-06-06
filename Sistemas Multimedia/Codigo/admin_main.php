<?php

include 'conexion.php';

$con = new conexion();
$errores = "";
$correcto = true;
$resultados = $con->consulta("SELECT * FROM administracion");
$fila = mysql_fetch_assoc($resultados);

// Primero comprobamos que la imagen de la portada es correcta
if($_FILES["portada"]["name"]!=null)
{
	if((($_FILES["portada"]["type"] == "image/gif")
		||($_FILES["portada"]["type"] == "image/jpeg")
		||($_FILES["portada"]["type"] == "image/pjpeg")
		||($_FILES["portada"]["type"] == "image/png"))
		&&($_FILES["portada"]["type"] < 200000000))
	{
		if ($_FILES["portada"]["error"] > 0)
		{
			$correcto = false;
			$errores= $errores."e1=1";
			echo "Error: " . $_FILES["portada"]["error"] . "<br />";
		}
		else
		{
			if($fila["imagen_portada"] != "")
			{
				$dir="portada/".$fila["imagen_portada"];
				if (file_exists($dir))
				{
					unlink($dir);
					echo $_FILES["portada"]["name"] . " ya existe. ";
				}
			}
			$dir="portada/".$fila["imagen_portada"];
			move_uploaded_file($_FILES["portada"]["tmp_name"],"portada/".$_FILES["portada"]["name"]);
			if(!$con->consulta("UPDATE administracion SET imagen_portada=\"".$_FILES["portada"]["name"]."\" WHERE id=1;"))
			{
				$correcto = false;
				echo mysql_error()."  en la consulta ";
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
		echo "Error en la portada.";
		echo "Tipo: " . $_FILES["portada"]["type"] . "<br />";
		echo "Tamaño: " . ($_FILES["portada"]["size"] / 1024) . " Kb<br />";
	}
}

if($_FILES["mascara"]["name"]!=null)
{
	if((($_FILES["mascara"]["type"] == "image/gif")
		||($_FILES["mascara"]["type"] == "image/jpeg")
		||($_FILES["mascara"]["type"] == "image/pjpeg")
		||($_FILES["mascara"]["type"] == "image/png"))
		&&($_FILES["mascara"]["type"] < 200000000))
	{
		if ($_FILES["mascara"]["error"] > 0)
		{
			if(!$correcto)
			{
				$errores = $errores.'&';
			}
			$correcto = false;
			$errores= $errores."e2=1";
			echo "Error: " . $_FILES["mascara"]["error"] . "<br />";
		}
		else
		{
			if($fila["imagen_mascara"] != "")
			{
				$dir="portada/".$fila["imagen_mascara"];
				if (file_exists($dir))
				{
					unlink($dir);
					echo $_FILES["mascara"]["name"] . " ya existe. ";
				}
			}
			move_uploaded_file($_FILES["mascara"]["tmp_name"],"portada/".$_FILES["mascara"]["name"]);
			if(!$con->consulta("UPDATE administracion SET imagen_mascara=\"".$_FILES["mascara"]["name"]."\" WHERE id=1;"))
			{
				$correcto = false;
				echo mysql_error()."  en la consulta ";
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
		$errores= $errores."e1=3";
		echo "Error en la mascara.";
		echo "Tipo: " . $_FILES["mascara"]["type"] . "<br />";
		echo "Tamaño: " . ($_FILES["mascara"]["size"] / 1024) . " Kb<br />";
	}
}

if($correcto)
{	
	header( 'Location: Zona-admin.php?id=5&dato=1' );
}
else
{
	header( 'Location: Zona-admin.php?id=5&dato=2&'.$errores );
}

?>