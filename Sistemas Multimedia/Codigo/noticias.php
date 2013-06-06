<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Documento sin título</title>
<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
<link rel="stylesheet" type="text/css" href="estilo/noticias.css" />
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
?>
<div id="cuerpo_noticias">
<?php
	include 'conexion.php';
	if(!isset($_GET["id"]))
	{
		// Vemos todas las noticias
		$con = new conexion();
		$resultado = $con->consulta("SELECT * FROM noticias");
		$total = mysql_num_rows($resultado);
		$i = $total-1;
		?>
        <div class="noticias">
		<?php
		while($i>=0)
		{
			$resultado = $con->consulta("SELECT * FROM noticias WHERE id=".$i);
			$fila = mysql_fetch_assoc($resultado);
			$titulo = $fila["titulo"];
			$texto = $fila["corto"];
			$fecha = $fila["fecha"];
			?>
			<div class="noticia_individual">
				<?php echo "<b>".$titulo."</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />".$texto."<a href='noticias.php?id=".$i."'>Leer m&aacute;s...</a>";
				?>
				<br /><br /><br />
			</div>
			<?php
			$i--;
		}
		?>
		</div>
        <br /><br /><br /><br /><br /><br />
        <div class="base2">
            <br /><br /><br />
        </div>
    	<?php
	}
	else
	{	
		$id = $_GET["id"];
		if($id<0)
		{
			?>
            <div class="noticias">
				<div class="noticia_individual">
    	        	La noticia a la que desea acceder no existe.
        	    </div>
            </div>
            <br /><br /><br /><br />
            <?php
		}
		else
		{			
			$con = new conexion();	
			$resultado = $con->consulta("SELECT * FROM noticias WHERE id=".$id);
			$fila = mysql_fetch_assoc($resultado);
			$titulo = $fila["titulo"];
			$texto = $fila["texto"];
			$fecha = $fila["fecha"];
		
			?>
            <div class="noticia_completa">
                <?php 
					echo "<h2>&nbsp;".$titulo."</h2><br />".$texto."<br />";
                ?>
            </div>
			<?php
			
			
			$resultado = $con->consulta("SELECT * FROM comentarios_noticia WHERE noticia=\"".$titulo."\"");
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
                    <form method="post" enctype="multipart/form-data" action="inserta_comentario_noticia.php">
                        Usuario: <input type= "textarea" name="usuario"/>
                        Email: <input type="text" name="email" />
                        <br /><br />
						<textarea name="content" cols="53" rows="8">
                            Inserte el comentario
                        </textarea>
                        <br /><br />
                        <input type="hidden" name="noticia" value="<?php echo $titulo;?>">
                        <input type="hidden" name="id" value="<?php echo $id;?>">
                        <INPUT TYPE="submit" NAME = "subir" value="subir"/>
                    </form>
                </div>
                <div class="base2">
                    <br /><br /><br />
                </div>
			<?php
		}
	}
	
?>
</div>
</body>
</html>