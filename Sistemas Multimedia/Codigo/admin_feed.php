<?php
	include 'conexion.php';
	$con = new conexion();
	$facebook = "";
	$deviantart = "";
	$twitter = "";
	$resultados = $con->consulta("SELECT * FROM administracion WHERE id=1;");
	$fila = mysql_fetch_assoc($resultados);
	if(isset($_POST["delface"]))
	{
		if(!$con->consulta("UPDATE administracion SET facebook=\"\" WHERE id=1;"))
		{
			echo mysql_error()."  en la consulta  UPDATE administracion SET facebook=\"\" WHERE id=1;";
		}
	}
	if(isset($_POST["facebook"])&&($_POST["facebook"]!=""))
	{
		if(!$con->consulta("UPDATE administracion SET facebook=\"".$_POST["facebook"]."\" WHERE id=1;"))
		{
			echo mysql_error()."  en la consulta  UPDATE administracion SET facebook=\"".$_POST["facebook"]."\" WHERE id=1;";
		}
	}
	if(isset($_POST["deldevi"]))
	{
		if(!$con->consulta("UPDATE administracion SET deviantart=\"\" WHERE id=1;"))
		{
			echo mysql_error()."  en la consulta  UPDATE administracion SET deviantart=\"\" WHERE id=1;";
		}
	}
	if(isset($_POST["deviantart"])&&($_POST["deviantart"]!=""))
	{
		if(!$con->consulta("UPDATE administracion SET facebook=\"".$_POST["deviantart"]."\" WHERE id=1;"))
		{
			echo mysql_error()."  en la consulta  UPDATE administracion SET facebook=\"".$_POST["deviantart"]."\" WHERE id=1;";
		}
	}
	if(isset($_POST["deltwit"]))
	{
		if(!$con->consulta("UPDATE administracion SET twitter=\"\" WHERE id=1;"))
		{
			echo mysql_error()."  en la consulta  UPDATE administracion SET twitter=\"\" WHERE id=1;";
		}
	}
	if(isset($_POST["twitter"])&&($_POST["twitter"]!=""))
	{
		if(!$con->consulta("UPDATE administracion SET facebook=\"".$_POST["deviantart"]."\" WHERE id=1;"))
		{
			echo mysql_error()."  en la consulta  UPDATE administracion SET facebook=\"".$_POST["deviantart"]."\" WHERE id=1;";
		}
	}
	ob_start(); // ensures anything dumped out will be caught
	while (ob_get_status()) 
	{
		ob_end_clean();
	}
	header('Location: Zona-admin.php?id=4&dato=1');
?>