<?php
	if(isset($_COOKIE["WestWaterwick"]))
	{
		if($_COOKIE["WestWaterwick"] != "OK")
				header( "Location: admin.php?error" );
	}
?>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>West Waterirk</title>
		<link rel="stylesheet" type="text/css" href="estilo/admin.css" />
	</head>
	<body>
		<div class="identificacion">
			<form action="login.php" method="get"enctype="multipart/form-data">
				Usuario: <br /> <INPUT TYPE = "Text" NAME = "user"><br />
				Contrase&ntilde;a: <br /> <INPUT TYPE = "Text" NAME = "pass"><br />
				<INPUT TYPE="submit" NAME = "Entrar" value="Entrar" />
			</form>	
			<?php
				if(isset($_GET["error"]))
				{
					echo "<div class='error'>Error en el acceso. Revise si el usuario y la contrase&ntilde;a son correctas.</div>";
				}
			?>
		</div>
	</body>
</html>