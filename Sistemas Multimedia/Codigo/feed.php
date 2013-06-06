<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>West Waterirk</title>
<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
<link rel="stylesheet" type="text/css" href="estilo/feed.css" />
</head>
<body>
	<br /><br />
	<?php 
	include 'menu.php';
	?>
    <div class="enlaces">
		<?php
        include 'conexion.php';
        $con = new conexion();
        $resultado = $con->consulta("SELECT * FROM administracion WHERE id=1");
        $fila = mysql_fetch_assoc($resultado);
        if($fila["facebook"]!="")
        {
            ?>
            <div class="facebook">
                <a href="<?php echo $fila["facebook"]; ?>"><img src="facebook.jpg" /></a>
            </div>
            <?php
        }
        if($fila["deviantart"]!="")
        {
            ?>
            <div class="deviantart">
                <a href="<?php echo $fila["deviantart"]; ?>"><img src="deviantart.jpg" /></a>
            </div>	
            <?php
        }
        if($fila["twitter"]!="")
        {
            ?>
            <div class="twitter">
                <a href="<?php echo $fila["twitter"]; ?>"><img src="twitter.jpg" /></a>
            </div>	
            <?php
        }
        ?>
        <div class="rss">
            <a href="rss.php"><img src="rss.png" /></a>
        </div>
    </div>
	<div class="base2">
		<br /><br /><br />
	</div>
</body>
</html>