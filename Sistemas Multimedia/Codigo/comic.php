<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>West Waterirk</title>
<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
<link rel="stylesheet" type="text/css" href="estilo/comic.css" />
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
?>
<div id="cuerpo_comic">
<?php
	if(!isset($_GET["id"]))
	{
		// Ultimo comic
		$con = new conexion();
		$resultado = $con->consulta("SELECT * FROM comics");
		$total = mysql_num_rows($resultado);
		$id = $total-1;
		$resultado = $con->consulta("SELECT * FROM comics WHERE id=".$id);
		$fila = mysql_fetch_assoc($resultado);
		$imagen = $fila["comic_big"];
		$descripcion = $fila["descripcion"];
		$nombre = $fila["nombre"];
		if($total==1)
		{
			?><br />
			<div class="mov">
				<img src='vacio.gif' />
				<img src='vacio.gif' />
				<a href="comic.php?id=-1"><img src="archivo.gif" /></a>
				<img src='vacio.gif' />
				<img src='vacio.gif' />
			</div>
			<div class="imagen"><a href="#image-2"><?php echo "<img src='comic_big/".$imagen."' border='0' />"?></a></div>
			<div class="lb-overlay" id="image-2">
				<?php echo "<img src='comic_big/".$imagen."' border='0'/>"?>
				<a href="#page" class="lb-close">x Close</a>
				<?php 
				echo "<a href=\"comic.php?id=".($id-1)."#page\" class=\"lb-back\">&lt- Anterior</a>"
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
		else
		{
			?><br />
			<div class="mov">
            	<a href="comic.php?id=0"><img src='first.gif' /></a>
                <a href="<?php echo "comic.php?id=".($id-1);?>"><img src='back.gif' /></a>
                <a href="comic.php?id=-1"><img src="archivo.gif" /></a>
				<img src='vacio.gif' />
				<img src='vacio.gif' />
            </div>
			<div class="imagen"><a href="#image-2"><?php echo "<img src='comic_big/".$imagen."' border='0' />"?></a></div>
			<div class="lb-overlay" id="image-2">
				<?php echo "<img src='comic_big/".$imagen."' border='0'/>"?>
				<a href="#page" class="lb-close">x Close</a>
				<?php 
				echo "<a href=\"comic.php?id=".($id-1)."#image-2\" class=\"lb-back\">&lt- Anterior</a>"
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
		$resultado = $con->consulta("SELECT * FROM comentarios WHERE comic=\"".$nombre."\"");
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
        	<form method="post" enctype="multipart/form-data" action="inserta_comentario.php">
            	Usuario: <input type= "textarea" name="usuario"/>
                Email: <input type="text" name="email" />
                <br /><br />
                <textarea name="content" cols="53" rows="8">
                    Inserte el comentario
                </textarea>
                <input type="hidden" name="comic" value="<?php echo $nombre;?>">
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
		$con = new conexion();
		$id = $_GET["id"];
		$resultado = $con->consulta("SELECT * FROM comics");
		$total = mysql_num_rows($resultado);
		if($id<0)
		{
			?>
			<ul class="archivo">
			<?php
			
			for($i=0; $i<$total; $i++)
			{
				$rest = $con->consulta("SELECT * FROM comics WHERE id=".$i);
				$comic = mysql_fetch_assoc($rest);
				$tags = $comic["tags"];
				$nombre = $comic["nombre"];
				echo "<li>";
				echo "<a href=comic.php?id=".$i."><img src=\"comic_small/".$comic['comic_small']."\" /><img src=\"comic_big/".$comic['comic_big']."\" class=\"preview\"/></a>";
				echo "</li>";
				if(($i%5)==4)
					echo "<br />";
			}
			for(; $i<5; $i++)
			{
            	echo "<br /><br /><br />";
			}
			?>
            </ul>
            <br /><br /><br /><br />
            <?php
		}
		else
		{				
			$resultado = $con->consulta("SELECT * FROM comics WHERE id=".$id);
			$fila = mysql_fetch_assoc($resultado);
			$imagen = $fila["comic_big"];
			$descripcion = $fila["descripcion"];
			$nombre = $fila["nombre"];
			// Comic numero $id
			if($id>=0)
			{
				if($id==$total)
				{
					?><br />
					<div class="mov">
						<a href="comic.php?id=0"><img src='first.gif' /></a> 
						<a href="<?php echo "comic.php?id=".($id-1);?>"><img src='back.gif' /></a> 
						<a href="comic.php?id=-1"><img src="archivo.gif" /></a>
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
							<img src='vacio.gif' />
							<img src='vacio.gif' />
							<a href="comic.php?id=-1"><img src="archivo.gif" /></a>
                            <?php
								if($id==$total-1)
								{
							?>
							<img src='vacio.gif' />
							<img src='vacio.gif' />
                            <?php
								}
								else
								{
							?>
                                <a href="<?php echo "comic.php?id=".($id+1);?>"><img src='next.gif' /></a>
                                <a href="<?php echo "comic.php?id=".($total-1);?>"><img src='last.gif' /></a>
                            <?php
								}
							?>
						</div>
                        <?php
					}
					else
					{
						?><br />
						<div class="mov">
							<a href="comic.php?id=0"><img src='first.gif' /></a>
							<a href="<?php echo "comic.php?id=".($id-1);?>"><img src='back.gif' /></a>
							<a href="comic.php?id=-1"><img src="archivo.gif" /></a>
							<a href="<?php echo "comic.php?id=".($id+1);?>"><img src='next.gif' /></a>
							<a href="<?php echo "comic.php?id=".$total;?>"><img src='last.gif' /></a>
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
				<div class="mov">
					<img src='vacio.gif' />
					<img src='vacio.gif' />
					<a href="comic.php?id=-1"><img src="archivo.gif" /></a>
					<a href="<?php echo "comic.php?id=".($id+1);?>"><img src='next.gif' /></a>
					<a href="<?php echo "comic.php?id=".$total;?>"><img src='last.gif' /></a>
				</div>
            <?php
				}
				else
				{
			?><br />
				<div class="mov">
					<img src='vacio.gif' />
					<img src='vacio.gif' />
					<a href="comic.php?id=-1"><img src="archivo.gif" /></a>
					<img src='vacio.gif' />
					<img src='vacio.gif' />
				</div>
            <?php
				}
			}
			?>
			<div class="imagen"><a href="#image-2"><?php echo "<img src='comic_big/".$imagen."' border='0' />"?></a></div>
			<div class="lb-overlay" id="image-2">
				<?php echo "<img src='comic_big/".$imagen."' border='0'/>"?>
				<a href="#page" class="lb-close">x Close</a>
				<?php 
				if($id>0)
					echo "<a href=\"comic.php?id=".($id-1)."#image-2\" class=\"lb-back\">&lt- Anterior</a>"
				?>
				<?php 
				if($id<$total)
					echo "<a href=\"comic.php?id=".($id+1)."#image-2\" class=\"lb-next\">Siguiente -></a>"
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
			$resultado = $con->consulta("SELECT * FROM comentarios WHERE comic=\"".$nombre."\"");
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
					echo "<b>Autor: &nbsp;".$fila["autor"]."</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Fecha: &nbsp;".$fila["fecha"]."</b><br /><br />".$fila["texto"];
				?>
				</div>
				<?php
			}
			?>
            </div>
            <div class="formulario">
                <form method="post" enctype="multipart/form-data" action="inserta_comentario.php">
                	Usuario: <input type= "textarea" name="usuario"/>
                    Email: <input type="text" name="email" />
                    <br /><br />
					<textarea name="content" cols="53" rows="8">
                        Inserte el comentario
                    </textarea>
                    <input type="hidden" name="comic" value="<?php echo $nombre;?>">
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