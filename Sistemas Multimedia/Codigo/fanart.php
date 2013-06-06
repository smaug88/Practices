<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>West Waterirk</title>
<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
<link rel="stylesheet" type="text/css" href="estilo/fanart.css" />
<script language="javascript" type="text/javascript" src="scripts/tiny_mce.js"></script>
<script language="javascript" type="text/javascript">
	tinyMCE.init({
		mode : "textareas"
	});
</script>
</head>

<body>
<br /><br />
<?php 
	include 'menu.php';
	include 'conexion.php';
	$con = new conexion();
?>
<div id="cuerpo_fanart">
<?php
	if(!isset($_GET["id"]))
	{
		// Ultimo fanart
		$resultado = $con->consulta("SELECT * FROM fanarts");
		$total = mysql_num_rows($resultado);
		$id = $total-1;
		$resultado = $con->consulta("SELECT * FROM fanarts WHERE id=".$id);
		$fila = mysql_fetch_assoc($resultado);
		$imagen = $fila["fanart_big"];
		$descripcion = $fila["descripcion"];
		$nombre = $fila["nombre"];
		if($con->num_filas("fanarts")==1)
		{
			?><br />
			<div class="mov">
				<img src='vacio.gif' />
				<img src='vacio.gif' />
				<img src="archivo.gif" />
				<img src='vacio.gif' />
				<img src='vacio.gif' />
			</div>
			<div class="imagen"><a href="#image-2"><?php echo "<img src='fanart_big/".$imagen."' border='0' />"?></a></div>
			<div class="lb-overlay" id="image-2">
				<?php echo "<img src='fanart_big/".$imagen."' border='0'/>"?>
				<a href="#page" class="lb-close">x Close</a>
			</div>
 	 		<div class="descripcion">
                <img src='descripcion.png' />
				<div class="conjunto">
                    <div class="desc_txt">
                        <?php echo $descripcion; ?>
                    </div>
                </div>
			</div>
			<?php
		}
		else
		{
			?><br />
			<div class="mov">
            	<a href="fanart.php?id=0"><img src='first.gif' /></a>
                <a href="<?php echo "fanart.php?id=".($id-1);?>"><img src='back.gif' /></a>
                <a href="fanart.php?id=-1"><img src="archivo.gif" /></a>
				<img src='vacio.gif' />
				<img src='vacio.gif' />
            </div>
			<div class="imagen"><a href="#image-2"><?php echo "<img src='fanart_big/".$imagen."' border='0' />"?></a></div>
			<div class="lb-overlay" id="image-2">
				<?php echo "<img src='fanart_big/".$imagen."' border='0'/>"?>
				<a href="#page" class="lb-close">x Close</a>
				<?php 
				echo "<a href=\"fanart.php?id=".($id-1)."#image-2\" class=\"lb-back\">&lt- Anterior</a>"
				?>
			</div>
 	 		<div class="descripcion">
                <img src='descripcion.png' />
				<div class="conjunto">
                    <div class="desc_txt">
                        <?php echo $descripcion; ?>
                    </div>
                </div>
			</div>
			<?php
		}
		$resultado = $con->consulta("SELECT * FROM comentarios_fanart WHERE fanart=\"".$nombre."\"");
		$comentarios = mysql_num_rows($resultado);
		?>
		<div class="comentarios">
        	<div class="conjunto">
		<?php
		while($fila = mysql_fetch_assoc($resultado))
		{
			?>
			<div class="comentario_individual">
            <?php
				echo "Autor: &nbsp;".$fila["autor"]."&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fecha: &nbsp;".$fila["fecha"]."<br /><br />".$fila["texto"]."<br /><br />";
			?>
            </div>
			<?php
		}
		?>
        </div>
        <div class="formulario">
        	<form method="post" enctype="multipart/form-data" action="inserta_comentario_fanart.php">
            	Usuario: <input type= "textarea" name="usuario"/>
                Email: <input type="text" name="email" />
                <br /><br />
                <textarea name="content" cols="53" rows="8">
                    Inserte el comentario
                </textarea>
                <input type="hidden" name="fanart" value="<?php echo $nombre;?>">
                <input type="hidden" name="id" value="<?php echo $id;?>">
                <INPUT TYPE="submit" NAME = "subir" value="subir"/>
            </form>
        </div>
		</div>
        <br /><br /><br /><br />
    	<?php
	}
	else
	{	
		$id = $_GET["id"];
		if($id<0)
		{
			// ARCHIVO
			?>
			<ul class="archivo">
			<?php
			$resultado = $con->consulta("SELECT * FROM fanarts");
			$total = mysql_num_rows($resultado);
			
			for($i=0; $i<$total; $i++)
			{
				$rest = $con->consulta("SELECT * FROM fanarts WHERE id=".$i);
				$fanart = mysql_fetch_assoc($rest);
				$tags = $fanart["tags"];
				$nombre = $fanart["nombre"];
				echo "<li>";
				echo "<a href=fanart.php?id=".$i."><img src=\"fanart_small/".$fanart['fanart_small']."\" /><img src=\"fanart_big/".$fanart['fanart_big']."\" class=\"preview\"/></a>";
				echo "</li>";
				if(($i%5)==4)
					echo "<br />";
			}
			?>
            </ul>
            <br /><br /><br /><br />
            <?php
		}
		else
		{				
			$resultado = $con->consulta("SELECT * FROM fanarts WHERE id=".$id);
			$total = mysql_num_rows($resultado);
			$fila = mysql_fetch_assoc($resultado);
			$imagen = $fila["fanart_big"];
			$descripcion = $fila["descripcion"];
			$nombre = $fila["nombre"];
			// fanart numero $id
			if($id>=0)
			{
				
				if($id==($total+1))
				{
					?><br />
					<div class="mov">
						<a href="fanart.php?id=0"><img src='first.gif' /></a>
						<a href="<?php echo "fanart.php?id=".($id-1);?>"><img src='back.gif' /></a>
						<a href="fanart.php?id=-1"><img src="archivo.gif" /></a>
						<img src='vacio.gif' />
						<img src='vacio.gif' />
					</div>
            		<?php
				}
				else
				{
					if($id==0)
					{
						?><br />
                        <div class="mov">
							<a href="fanart.php?id=-1"><img src="archivo.gif" /></a>
							<a href="<?php echo "fanart.php?id=".($id+1);?>"><img src='next.gif' /></a>
							<a href="<?php echo "fanart.php?id=".$total;?>"><img src='last.gif' /></a>
							<img src='vacio.gif' />
							<img src='vacio.gif' />
						</div>
                        <?php
					}
					else
					{
						?><br />
						<div class="mov">
							<a href="fanart.php?id=0"><img src='first.gif' /></a>
							<a href="<?php echo "fanart.php?id=".($id-1);?>"><img src='back.gif' /></a>
							<a href="fanart.php?id=-1"><img src="archivo.gif" /></a>
							<a href="<?php echo "fanart.php?id=".($id+1);?>"><img src='next.gif' /></a>
							<a href="<?php echo "fanart.php?id=".$total;?>"><img src='last.gif' /></a>
						</div>
						<?php
					}
				}
			}
			else
			{
				if($id!=$total)
				{
			?><br />
				<div class="mov"><a href="fanart.php?id=-1"><img src="archivo.gif" /></a> <a href="<?php echo "fanart.php?id=".($id+1);?>"><img src='next.gif' /></a><a href="<?php echo "fanart.php?id=".$total;?>"><img src='last.gif' /></a></div>
            <?php
				}
				else
				{
			?><br />
				<div class="mov"><a href="fanart.php?id=-1"><img src="archivo.gif" /></a></div>
            <?php
				}
			}
			?>
			<div class="imagen"><a href="#image-2"><?php echo "<img src='fanart_big/".$imagen."' border='0' />"?></a></div>
			<div class="lb-overlay" id="image-2">
				<?php echo "<img src='fanart_big/".$imagen."' border='0'/>"?>
				<a href="#page" class="lb-close">x Close</a>
				<?php 
				if($id!=0)
					echo "<a href=\"fanart.php?id=".($id-1)."#image-2\" class=\"lb-back\">&lt- Anterior</a>"
				?>
				<?php 
				if($id!=$total)
					echo "<a href=\"fanart.php?id=".($id+1)."#image-2\" class=\"lb-next\">Siguiente -></a>"
				?>
			</div>
 	 		<div class="descripcion">
                <img src='descripcion.png' />
				<div class="conjunto">
                    <div class="desc_txt">
                        <?php echo $descripcion; ?>
                    </div>
                </div>
			</div>
            <?php
			$resultado = $con->consulta("SELECT * FROM comentarios_fanart WHERE fanart=\"".$nombre."\"");
			$comentarios = mysql_num_rows($resultado);
			?>
			<div class="comentarios">
        		<div class="conjunto">
			<?php
			while($fila = mysql_fetch_assoc($resultado))
			{
				?>
				<div class="comentario_individual">
				<?php
					echo "<b>Autor: &nbsp;".$fila["autor"]."</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Fecha: &nbsp;".$fila["fecha"]."</b><br /><br />".$fila["texto"]."<br /><br />";
				?>
				</div>
				<?php
			}
			?>
            </div>
            <div class="formulario">
                <form method="post" enctype="multipart/form-data" action="inserta_comentario_fanart.php">
                	Usuario: <input type= "textarea" name="usuario"/>
                    Email: <input type="text" name="email" />
                    <br /><br />
					<textarea name="content" cols="53" rows="8">
                        Inserte el comentario
                    </textarea>
                    <br /><br />
                    <input type="hidden" name="fanart" value="<?php echo $nombre;?>">
                    <input type="hidden" name="id" value="<?php echo $id;?>">
                    <INPUT TYPE="submit" NAME = "subir" value="subir"/>
                </form>
            </div>
			</div>
            <br /><br /><br /><br />
			<?php
		}
	}
	
?>
    <div class="base">
	    <br /><br /><br />
    </div>
</div>
</body>
</html>