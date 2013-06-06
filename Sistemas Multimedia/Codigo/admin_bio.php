<?php
	include 'conexion.php';
	$con = new conexion();
	$texto1 = "";
	$texto2 = "";
	$imagen1 = "";
	$imagen2 = "";
	$errores = "";
	$resultados = $con->consulta("SELECT * FROM administracion WHERE id=1;");
	if(!$fila = mysql_fetch_assoc($resultados))
	{
		$con->consulta("INSERT INTO administracion (id) VALUES (1);");
		$resultados = $con->consulta("SELECT * FROM administracion WHERE id=1;");
		$fila = mysql_fetch_assoc($resultados);
	}
	if(isset($_POST["text1"]))
	{
		$texto1 = strip_tags(str_replace('"', "'", $_POST["text1"]), '<p>');
	}
	else
	{
		$texto = $fila["texto_autor1"];
	}
	if(isset($_POST["text2"]))
	{
		$texto2 = strip_tags(str_replace('"', "'", $_POST["text2"]), '<p>');
	}
	else
	{
		$texto = $fila["texto_autor2"];
	}

	if($_FILES["img1"]["name"]!=null)
	{
		if ((($_FILES["img1"]["type"] == "image/gif")
		|| ($_FILES["img1"]["type"] == "image/jpeg")
		|| ($_FILES["img1"]["type"] == "image/pjpeg")
		|| ($_FILES["img1"]["type"] == "image/png"))
		&& ($_FILES["img1"]["size"] < 200000000))
		{
			if ($_FILES["img1"]["error"] > 0)
			{
				if(!$correcto)
				{
					$errores = $errores.'&';
				}
				$correcto = false;
				$errores= $errores."e1=1";
				echo "Error: " . $_FILES["img1"]["error"] . "<br />";
			}
			else
			{
				if($fila["imagen_autor1"])
				{
					$dir="autor/".$fila["imagen_autor1"];
					unlink($dir);
				}
				move_uploaded_file($_FILES["img1"]["tmp_name"],"autor/".$_FILES["img1"]["name"]);
				$imagen1 = $_FILES["img1"]["name"];
			}
		}
		else
		{
			$imagen1 = $fila["imagen_autor1"];
			if(!$correcto)
			{
				$errores = $errores.'&';
				$correcto = false;
			}
			$errores= $errores."e1=3";
			echo "Error en la imagen 1.";
			echo "Tipo: " . $_FILES["img1"]["type"] . "<br />";
			echo "Tamaño: " . ($_FILES["img1"]["size"] / 1024) . " Kb<br />";
		}
	}
	else
	{
		$imagen1 = $fila["imagen_autor1"];
	}
	if($_FILES["img2"]["name"]!=null)
	{
		if ((($_FILES["img2"]["type"] == "image/gif")
		|| ($_FILES["img2"]["type"] == "image/jpeg")
		|| ($_FILES["img2"]["type"] == "image/pjpeg")
		|| ($_FILES["img2"]["type"] == "image/png"))
		&& ($_FILES["img2"]["size"] < 200000000))
		{
			if ($_FILES["img2"]["error"] > 0)
			{
				if(!$correcto)
				{
					$errores = $errores.'&';
				}
				$correcto = false;
				$errores= $errores."e2=1";
			}
			else
			{
				if($fila["imagen_autor1"])
				{
					$dir="autor/".$fila["imagen_autor2"];
					unlink($dir);
				}
				move_uploaded_file($_FILES["img2"]["tmp_name"],"autor/".$_FILES["img2"]["name"]);
				$imagen2 = $_FILES["img2"]["name"];
			}
		}
		else
		{
			$imagen2 = $fila["imagen_autor1"];
			if(!$correcto)
			{
				$errores = $errores.'&';
				$correcto = false;
			}
			$errores= $errores."e1=3";
			echo "Error en la imagen 2.";
			echo "Tipo: " . $_FILES["img2"]["type"] . "<br />";
			echo "Tamaño: " . ($_FILES["img2"]["size"] / 1024) . " Kb<br />";
		}
	}
	else
	{
		$imagen2 = $fila["imagen_autor2"];
	}
	if(!$con->consulta("UPDATE administracion SET texto_autor1=\"".$texto1."\", texto_autor2=\"".$texto2."\", imagen_autor1=\"".$imagen1."\",imagen_autor2=\"".$imagen2."\" WHERE id=1;"))
	{
		echo mysql_error()."  en la consulta  UPDATE administracion SET texto_autor=\"".$texto."\", imagen_autor1=\"".$imagen1."\",imagen_autor2=\"".$imagen2."\" WHERE id=0;";
	}
	ob_start(); // ensures anything dumped out will be caught
	while (ob_get_status()) 
	{
		ob_end_clean();
	}
	header('Location: Zona-admin.php?id=3&dato=1');
?>
