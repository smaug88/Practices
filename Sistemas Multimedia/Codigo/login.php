<?php
	include 'conexion.php';
	
	$user = $_GET["user"];
	$pass = $_GET["pass"];
	
	$con = new conexion();
	
	if($con->login($user, $pass))
	{
		setcookie("WestWaterwick", "OK", time() + 3600);
		header( "Location: Zona-admin.php" );
	}
	else
	{
		header( "Location: admin.php?error" );
	}
?>