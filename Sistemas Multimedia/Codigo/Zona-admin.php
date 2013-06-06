<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?php
	if(isset($_COOKIE["WestWaterwick"]))
	{
		if($_COOKIE["WestWaterwick"] != "OK")
				header( "Location: admin.php?error" );
	}
	else
	{
		header( "Location: admin.php?error" );
	}
?>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
		<link rel="stylesheet" type="text/css" href="estilo/admin.css" />
        <script language="javascript" type="text/javascript" src="scripts/tiny_mce.js"></script>
		<script language="javascript" type="text/javascript">
			tinyMCE.init({
				mode : "textareas"
			});
		</script>
    	<title>Administraci&oacute;n de Western Waterirk Comic</title>
	</head>
    
    <body>
        <div class="zonas">
        	<br />
        	<br />
        	<br />
        	<br />
        	<br />
        	<br />
        	<br />
        	<input type="button" value="Comic" onclick="location.href='Zona-admin.php?id=1'" /><br />
        	<input type="button" value="Fan-art" onclick="location.href='Zona-admin.php?id=2'" /><br />
        	<input type="button" value="Autor" onclick="location.href='Zona-admin.php?id=3'" /><br />
        	<input type="button" value="Feed" onclick="location.href='Zona-admin.php?id=4'" /><br />
        	<input type="button" value="Portada" onclick="location.href='Zona-admin.php?id=5'" /><br />
        	<input type="button" value="Noticias" onclick="location.href='Zona-admin.php?id=6'" /><br />
        </div>
        <div class="elementos">
            <?php
            
            // INICIO DE CODIGO PHP
            // TODO: Añadir interpretacion de errores de editar
            include "conexion.php";
            
				if(!isset($_GET["id"]))
				{
					?> 
					Escoge una opci&oacute;n:
					<?php
				}
				else
				{
					?>
                    <?php
					$id = $_GET["id"];
					if($id == 1)
					{
						?>
                    	<div class="botones">
							<input type="button" value="A&ntilde;adir Comic" onclick="location.href='Zona-admin.php?id=1&modo=1'" /> <br />
							<input type="button" value="Gestion Comics" onclick="location.href='Zona-admin.php?id=1&modo=2'" /><br />
                        </div>
						<div id="modo">
							<?php
							if(isset($_GET["modo"]))
							{
								$modo = $_GET["modo"];
								
								//=========================================================================================================
								// NUEVO COMIC  ===========================================================================================
								//=========================================================================================================
								if($modo==1)
								{
									if(isset($_GET["dato"]))
									{
										if($_GET["dato"] == 1)
										{
											echo "<h4>Comic insertado Correctamente</h4>";
										}
										else if ($_GET["dato"] == 2)
										{
											echo "<h4>Errores</h4><br /> ";
											if(isset($_GET["e1"]))
											{
												if($_GET["e1"] == 1)
												{
													echo "Error al subir el comic Grande<br />";
												}
												else if ($_GET["e1"] == 2)
												{
													echo "Error, el comic Grande ya existe<br />";
												}
												else if ($_GET["e1"] == 3)
												{
													echo "Error, comic Grande incorrecto<br />";
												}
											}
											if(isset($_GET["e2"]))
											{
												if($_GET["e2"] == 1)
												{
													echo "Error al subir el comic Mediano<br />";
												}
												else if ($_GET["e2"] == 2)
												{
													echo "Error, el comic Mediano ya existe<br />";
												}
												else if ($_GET["e2"] == 3)
												{
													echo "Error, comic Mediano incorrecto<br />";
												}
											}
											if(isset($_GET["e3"]))
											{
												if($_GET["e3"] == 1)
												{
													echo "Error al subir el comic Pequeño<br />";
												}
												else if ($_GET["e3"] == 2)
												{
													echo "Error, el comic Pequeño ya existe<br />";
												}
												else if ($_GET["e3"] == 3)
												{
													echo "Error, comic Pequeño incorrecto<br />";
												}
											}
											if(isset($_GET["e4"]))
											{
												echo "Error, ya existe un comic con ese nombre<br />";
											}
										}
									}
									?>
                                    <div class="contenido">
                                        <div class="formulario2">
                                            <form action="admin_comic.php" method="post"enctype="multipart/form-data">
                                                Nombre del comic: <br /> <INPUT TYPE = "Text" NAME = "nomine"><br />
                                                Descripci&oacute;n del comic: <br /> <textarea NAME = "text"  COLS=40 ROWS=6></textarea><br />
                                                Listado de tags: <br /> <INPUT TYPE = "Text" NAME = "tags"><br />
                                                Escoja la imagen principal: <br /> <INPUT TYPE = "file" NAME = "img_big"><br />
                                                Escoja el thumbnail: <br /><INPUT TYPE = "file" NAME = "img_med"><br />
                                                Escoja el icono: <br /> <INPUT TYPE = "file" NAME = "img_small"><br /><br />
                                                <INPUT TYPE="submit" NAME = "subir" value="subir" />
                                            </form>
                                        </div>
                                    </div>
									<?php
								}
								
								//=========================================================================================================
								// GESTIONAR===============================================================================================
								//=========================================================================================================
								
								else if($modo==2)
								{
									$con = new conexion();
									//$numFilas = conexion->num_filas("comics");
									$resultados = $con->consulta("SELECT * FROM comics");
									
									//for($i = 0; $i < $numFilas; $i++)
									if(isset($_GET["dato"]))
									{
										if($_GET["dato"] == 0) // Borrado correcta
										{
											echo ("<h3>Comic borrado correctamente</h3><br /><br />");
										}
										if($_GET["dato"] == 1) // Operacion correcta
										{
											echo ("<h3>Comic modificado correctamente</h3><br /><br />");
										}
										else if($_GET["dato"] == 2) // Hubo un error
										{
											if(isset($_GET["e11"]))
											{
												echo("Error al borrar comic grande, no existe <br />");
											}
											if(isset($_GET["e12"]))
											{
												echo("Error al borrar comic mediano, no existe <br />");
											}
											if(isset($_GET["e13"]))
											{
												echo("Error al borrar comic pequeño, no existe <br />");
											}
											if(isset($_GET["e2"]))
											{
												echo("Error al actualizar la BBDD <br />");
											}
											if(isset($_GET["e3"]))
											{
												echo("Error, el comic no estaba en la BBDD <br />");
											}
											if(isset($_GET["e4"]))
											{
												echo("Error 506, el comando no existe <br />");
											}
										}
									}
									$i = 1;
									?>
                                    <div class="contenido">
                                        <table border = 1>
                                            <TR>
                                                <TH scope="col">id</TH>
                                                <TH scope="col">Nombre</TH>
                                                <TH scope="col">Fecha</TH>
                                                <TH scope="col">Imagen Pequena</TH>
                                                <TH scope="col">Imagen Mediana</TH>
                                                <TH scope="col">Imagen Grande</TH>
                                                <TH scope="col">Comentarios</TH>
                                            	<TH scope="col" colspan="2">Opciones</TH>
                                                </TR>
                                    <?php
									while($fila = mysql_fetch_assoc($resultados))
									{
										$RComentarios = $con->consulta("SELECT id FROM comentarios WHERE comic=\"".$fila["nombre"]."\";");
										if(!$RComentarios)
										{
											echo mysql_error()."  en la consulta ";
										}
										else
										{
											$numComentarios = mysql_num_rows($RComentarios);
										}
										echo "<TR>";
										$nombre = $fila["nombre"];
										if(strlen($nombre)>25)
										{
											$aux = substr($nombre, 0, 11);
											$aux = $aux."...";
											$aux = $aux.substr($nombre, strlen($nombre)-12, strlen($nombre)-1);
											$nombre = $aux;
										}
										$miniimg = $fila["comic_small"];
										if(strlen($miniimg)>25)
										{
											$aux = substr($miniimg, 0, 11);
											$aux = $aux."...";
											$aux = $aux.substr($miniimg, strlen($miniimg)-12, strlen($miniimg)-1);
											$miniimg = $aux;
										}
										$medimg = $fila["comic_medium"];
										if(strlen($medimg)>25)
										{
											$aux = substr($medimg, 0, 11);
											$aux = $aux."...";
											$aux = $aux.substr($medimg, strlen($medimg)-12, strlen($medimg)-1);
											$medimg = $aux;
										}
										$bigimg = $fila["comic_big"];
										if(strlen($medimg)>25)
										{
											$aux = substr($bigimg, 0, 11);
											$aux = $aux."...";
											$aux = $aux.substr($bigimg, strlen($bigimg)-12, strlen($bigimg)-1);
											$bigimg = $aux;
										}
										echo "<TD>".$fila["id"]."</TD>";
										echo "<TD>".$nombre."</TD>";
										echo "<TD>".$fila["fecha"]."</TD>";
										echo "<TD>".$miniimg."</TD>";
										echo "<TD>".$medimg."</TD>";
										echo "<TD>".$bigimg."</TD>";
										echo "<TD>".$numComentarios."</TD>";
										echo "<TD><input type=\"button\" value=\"borrar\" onclick=\"location.href='admin_comic.php?id=borrar&dato=".$fila["nombre"]."'\" /></TD>";
										echo "<TD><input type=\"button\" value=\"editar\" onclick=\"location.href='Zona-admin.php?id=1&modo=3&dato=".$fila["nombre"]."'\" /></TD>";
										echo "</TR>";
										$i++;
									} 
									?>
										</table>
                                    </div>
									<?php
								}
								//=========================================================================================================
								// EDITAR   ===============================================================================================
								//=========================================================================================================
								
								else if($modo==3){
									if(isset($_GET["dato"]))
									{
										$con = new conexion();
										$resultados = $con->consulta("SELECT * FROM comics WHERE nombre=\"".$_GET["dato"]."\"");
										$fila = mysql_fetch_assoc($resultados);
										?>
                                        <div class="contenido">
                                        	<div class="formulario2">
                                                <form action="admin_comic.php?id=editar&dato=<?php echo $_GET["dato"];?>" method="post" enctype="multipart/form-data">
                                                    Nombre del comic: <?php echo $_GET["dato"];?> <br />
                                                    Descripci&oacute;n del comic: <br /> <textarea NAME = "text" COLS=40 ROWS=6 ><?php echo $fila["descripcion"];?></textarea><br />
                                                    Listado de tags: <br /> <INPUT TYPE = "Text" NAME = "tags" VALUE = "<?php echo $fila["tags"];?>"><br />
                                                    Escoja la imagen principal: <br /> <INPUT TYPE = "file" NAME = "img_big"><br />
                                                    Escoja el thumbnail: <br /><INPUT TYPE = "file" NAME = "img_med"><br />
                                                    Escoja el icono: <br /> <INPUT TYPE = "file" NAME = "img_small"><br /><br />
                                                    <INPUT TYPE="submit" NAME = "subir" value="Actualizar" />
                                                </form>
                                            </div>
                                        </div>
                                         <?php
									}
									else
									{
										echo "Error de formato en la direccion<br />";
									}
								}
							}
							?>
							</div>
						<?php
					}
					if($id == 2)
					{
						?>
                    	<div class="botones">
							<input type="button" value="A&ntilde;adir Fan-art" onclick="location.href='Zona-admin.php?id=2&modo=1'" /> <br />
							<input type="button" value="Gestion Fan-arts" onclick="location.href='Zona-admin.php?id=2&modo=2'" /><br />
                        </div>
						<div id="modo">
							<?php
							if(isset($_GET["modo"]))
							{
								$modo = $_GET["modo"];
								
								//=========================================================================================================
								// NUEVO FAN-ART  =========================================================================================
								//=========================================================================================================
								if($modo==1)
								{
									if(isset($_GET["dato"]))
									{
										if($_GET["dato"] == 1)
										{
											echo "<h4>Fan-art insertado Correctamente</h4>";
										}
										else if ($_GET["dato"] == 2)
										{
											echo "<h4>Errores</h4><br /> ";
											if(isset($_GET["e1"]))
											{
												if($_GET["e1"] == 1)
												{
													echo "Error al subir el Fan-art Grande<br />";
												}
												else if ($_GET["e1"] == 2)
												{
													echo "Error, el Fan-art Grande ya existe<br />";
												}
												else if ($_GET["e1"] == 3)
												{
													echo "Error, Fan-art Grande incorrecto<br />";
												}
											}
											if(isset($_GET["e2"]))
											{
												if($_GET["e2"] == 1)
												{
													echo "Error al subir el Fan-art Mediano<br />";
												}
												else if ($_GET["e2"] == 2)
												{
													echo "Error, el Fan-art Mediano ya existe<br />";
												}
												else if ($_GET["e2"] == 3)
												{
													echo "Error, Fan-art Mediano incorrecto<br />";
												}
											}
											if(isset($_GET["e3"]))
											{
												if($_GET["e3"] == 1)
												{
													echo "Error al subir el Fan-art Pequeño<br />";
												}
												else if ($_GET["e3"] == 2)
												{
													echo "Error, el Fan-art Pequeño ya existe<br />";
												}
												else if ($_GET["e3"] == 3)
												{
													echo "Error, Fan-art Pequeño incorrecto<br />";
												}
											}
											if(isset($_GET["e4"]))
											{
												echo "Error, ya existe un Fan-art con ese nombre<br />";
											}
										}
									}
									?>
                                    <div class="contenido">
                                        <div class="formulario2">
                                            <form action="admin_fanart.php" method="post"enctype="multipart/form-data">
                                                Nombre del Fan-art: <br /> <INPUT TYPE = "Text" NAME = "nomine"><br />
                                                Descripci&oacute;n del Fan-art: <br /> <textarea NAME = "text"  COLS=40 ROWS=6></textarea><br />
                                                Listado de tags: <br /> <INPUT TYPE = "Text" NAME = "tags"><br />
                                                Escoja la imagen principal: <br /> <INPUT TYPE = "file" NAME = "img_big"><br />
                                                Escoja el icono: <br /> <INPUT TYPE = "file" NAME = "img_small"><br />
                                                <INPUT TYPE="submit" NAME = "subir" value="subir" />
                                            </form>
                                        </div>
                                    </div>
									<?php
								}
								
								//=========================================================================================================
								// GESTIONAR===============================================================================================
								//=========================================================================================================
								
								else if($modo==2)
								{
									$con = new conexion();
									//$numFilas = conexion->num_filas("comics");
									$resultados = $con->consulta("SELECT * FROM fanarts");
									
									//for($i = 0; $i < $numFilas; $i++)
									if(isset($_GET["dato"]))
									{
										if($_GET["dato"] == 0) // Borrado correcta
										{
											echo ("<h3>Comic borrado correctamente</h3><br /><br />");
										}
										if($_GET["dato"] == 1) // Operacion correcta
										{
											echo ("<h3>Comic modificado correctamente</h3><br /><br />");
										}
										else if($_GET["dato"] == 2) // Hubo un error
										{
											if(isset($_GET["e11"]))
											{
												echo("Error al borrar comic grande, no existe <br />");
											}
											if(isset($_GET["e12"]))
											{
												echo("Error al borrar comic mediano, no existe <br />");
											}
											if(isset($_GET["e13"]))
											{
												echo("Error al borrar comic pequeño, no existe <br />");
											}
											if(isset($_GET["e2"]))
											{
												echo("Error al actualizar la BBDD <br />");
											}
											if(isset($_GET["e3"]))
											{
												echo("Error, el comic no estaba en la BBDD <br />");
											}
											if(isset($_GET["e4"]))
											{
												echo("Error 506, el comando no existe <br />");
											}
										}
									}
									$i = 1;
									?>
                                    <div class="contenido">
                                        <table border = 1>
                                            <TR>
                                                <TH scope=\"col\">id</TH>
                                                <TH scope=\"col\">Nombre</TH>
                                                <TH scope=\"col\">Fecha</TH>
                                                <TH scope=\"col\">Imagen Pequena</TH>
                                                <TH scope=\"col\">Imagen Grande</TH>
                                                <TH scope=\"col\">Comentarios</TH>
                                            	<TH scope="col" colspan="2">Opciones</TH>
                                            </TR>
                                    <?php
									while($fila = mysql_fetch_assoc($resultados))
									{
										$RComentarios = $con->consulta("SELECT id FROM comentarios_fanart WHERE fanart=\"".$fila["nombre"]."\";");
										if(!$RComentarios)
										{
											echo mysql_error()."  en la consulta ";
										}
										else
										{
											$numComentarios = mysql_num_rows($RComentarios);
										}
										$nombre = $fila["nombre"];
										if(strlen($nombre)>25)
										{
											$aux = substr($nombre, 0, 11);
											$aux = $aux."...";
											$aux = $aux.substr($nombre, strlen($nombre)-12, strlen($nombre)-1);
											$nombre = $aux;
										}
										$miniimg = $fila["fanart_small"];
										if(strlen($miniimg)>25)
										{
											$aux = substr($miniimg, 0, 11);
											$aux = $aux."...";
											$aux = $aux.substr($miniimg, strlen($miniimg)-12, strlen($miniimg)-1);
											$miniimg = $aux;
										}
										$bigimg = $fila["fanart_big"];
										if(strlen($medimg)>25)
										{
											$aux = substr($bigimg, 0, 11);
											$aux = $aux."...";
											$aux = $aux.substr($bigimg, strlen($bigimg)-12, strlen($bigimg)-1);
											$bigimg = $aux;
										}
										$i++;
										?>
										<TD><?php echo $fila["id"];?></TD>
										<TD><?php echo $nombre;?></TD>
										<TD><?php echo $fila["fecha"];?></TD>
										<TD><?php echo $miniimg;?></TD>
										<TD><?php echo $bigimg;?></TD>
										<TD><?php echo $numComentarios;?></TD>
										<TD><input type="button" value="borrar" onclick="location.href='admin_fanart.php?id=borrar&dato=<?php echo $fila["nombre"];?>'"/></TD>
										<TD><input type="button" value="editar" onclick="location.href='Zona-admin.php?id=2&modo=3&dato=<?php echo $fila["nombre"];?>'" /></TD>
										</TR>
                                        <?php
									} 
									?>
										</table>
                                    </div>
                                    <?php
									
								}
								//=========================================================================================================
								// EDITAR   ===============================================================================================
								//=========================================================================================================
								
								else if($modo==3)
								{
									if(isset($_GET["dato"]))
									{
										$con = new conexion();
										$resultados = $con->consulta("SELECT * FROM fanarts WHERE nombre=\"".$_GET["dato"]."\"");
										$fila = mysql_fetch_assoc($resultados);
										?>
                                        <div class="contenido">
                                        	<div class="formulario2">
                                                <form action="admin_fanart.php?id=editar&dato<?php echo $_GET["dato"];?>" method="post" enctype="multipart/form-data">
                                                    Nombre del Fan-art: <?php echo $_GET["dato"];?><br />
                                                    Descripci&oacute;n del Fan-art: <br /> <textarea NAME = "text" COLS=40 ROWS=6 ><?php echo $fila["descripcion"];?></textarea><br />
                                                    Listado de tags: <br /> <INPUT TYPE = "Text" NAME = "tags" VALUE = "<?php echo $fila["tags"];?>"><br />
                                                    Escoja la imagen principal: <br /> <INPUT TYPE = "file" NAME = "img_big"><br />
                                                    Escoja el icono: <br /> <INPUT TYPE = "file" NAME = "img_small"><br /><br />
                                                    <INPUT TYPE="submit" NAME = "subir" value="Actualizar" />
                                                </form>
                                            </div><br /><br /><br /><br />
                                        </div>
										<?php
									}
									else
									{
										echo "Error de formato en la direccion<br />";
									}
								}
							}
							?>
							</div>
						<?php
						
					}
					if($id == 3)
					{
						// formulario2 PARA ACTUALIZAR LA INFO DEL AUTOR
						if(isset($_GET["dato"]))
						{
							echo "Informacion actualizada correctamente <br />";
						}
						$con = new conexion();
						$resultados = $con->consulta("SELECT * FROM administracion WHERE id = 1");
						$texto = "";
						if($fila = mysql_fetch_assoc($resultados))
						{
							$texto1 = $fila["texto_autor1"];
							$texto2 = $fila["texto_autor2"];
						}
						?>
                        <div class="contenido">
                            <div class="formulario2">
                                <form action="admin_bio.php" method="post"enctype="multipart/form-data">
                                    Texto del autor arriba: <br /> <textarea NAME = "text1"  COLS=40 ROWS=6><?php echo $texto1;?></textarea><br />
                                    Texto del autor abajo: <br /> <textarea NAME = "text2"  COLS=40 ROWS=6><?php echo $texto2;?></textarea><br />
                                    Escoja la imagen1: <br /> <INPUT TYPE = "file" NAME = "img1"><br />
                                    Escoja la imagen2: <br /> <INPUT TYPE = "file" NAME = "img2"><br /><br />
                                    <INPUT TYPE="submit" NAME = "subir" value="subir" />
                                </form>
                            </div>
                         </div>
						<?php

					}
					if($id == 4)
					{
						// formulario2 PARA ACTUALIZAR LOS FEEDS
						
						?>
                        <div class="contenido">
                            <div class="formulario2">
                                <form action="admin_feed.php" method="post"enctype="multipart/form-data">
                                    Facebook: <br /> <INPUT TYPE = "Text" NAME = "facebook">
                                    Eliminar: <input type="checkbox" name="delface"/><br />
                                    Twitter: <br /> <INPUT TYPE = "Text" NAME = "twitter">
                                    Eliminar: <input type="checkbox" name="deltwit"/><br />
                                    Deviantart: <br /> <INPUT TYPE = "Text" NAME = "deviantart">
                                    Eliminar: <input type="checkbox" name="deldevi"/><br />
                                    <INPUT TYPE="submit" NAME = "subir" value="subir" />
                                </form>
                            </div>
                        </div>
						<?php
					}
					if($id == 5)
					{
						if(isset($_GET["dato"]))
						{
							if($_GET["dato"] == 1)
							{
								echo "<h4>Portada actualizada Correctamente</h4>";
							}
							else if ($_GET["dato"] == 2)
							{
								echo "<h4>Errores</h4><br /> ";
								if(isset($_GET["e1"]))
								{
									if($_GET["e1"] == 1)
									{
										echo "Error al subir la imagen de la portada<br />";
									}
									else if ($_GET["e1"] == 2)
									{
										echo "Error, la imagen de la portada ya existe<br />";
									}
								}
								if(isset($_GET["e2"]))
								{
									if($_GET["e2"] == 1)
									{
										echo "Error al subir la m&aacute;scara de la portada<br />";
									}
									else if ($_GET["e2"] == 2)
									{
										echo "Error, la m&aacute;scara de la portada ya existe<br />";
									}
								}
							}
						}
						// formulario2 DE GESTION DE PORTADA
						?>
                        <div class="contenido">
							<form action="admin_main.php" method="post"enctype="multipart/form-data">
									Escoja la imagen de la portada: <br /> <INPUT TYPE = "file" NAME = "portada"><br />
									Escoja la m&aacute;scara de la portada: <br /> <INPUT TYPE = "file" NAME = "mascara"><br />
								<INPUT TYPE="submit" NAME = "subir" value="subir" />
							</form>
                         </div>
						<?php
					}
					if($id==6)
					{
						?>
                        <div class="botones">
							<input type="button" value="A&ntilde;adir Noticia" onclick="location.href='Zona-admin.php?id=6&modo=1'" /> <br />
							<input type="button" value="Gesti&oacute;n Noticias" onclick="location.href='Zona-admin.php?id=6&modo=2'" /><br />
                        </div>
							<?php
						// GESTIONAMOS LAS NOTICIAS
						if(isset($_GET["modo"]))
						{
							$modo = $_GET["modo"];
							if($modo == 1)
							{
								// NUEVA NOTICIA
								?>
                        		<div class="contenido">
                                    <div class="formulario2">
                                        <form action="admin_news.php" method="post"enctype="multipart/form-data">
                                            T&iacute;tulo de la noticia: <br /> <INPUT TYPE = "Text" NAME = "titulo"><br />
                                            Resumen de la noticia: <br /> <textarea NAME = "resumen"  COLS=40 ROWS=6></textarea><br />
                                            Cuerpo de la noticia: <br /> <textarea NAME = "texto"  COLS=40 ROWS=6></textarea><br /><br />
                                            <INPUT TYPE="submit" NAME = "subir" value="subir" />
                                        </form>
                                    </div>
                                </div>
								<?php
							}
							else if($modo == 2)
							{
								// GESTION DE NOTICIAS
								$con = new conexion();
								$resultados = $con->consulta("SELECT * FROM noticias");
								$con = new conexion();
									
								if(isset($_GET["dato"]))
								{
									if($_GET["dato"] == 0) // Borrado correcta
									{
										echo ("<h3>Noticia borrada correctamente</h3><br /><br />");
									}
									if($_GET["dato"] == 1) // Operacion correcta
									{
										echo ("<h3>Noticia modificada correctamente</h3><br /><br />");
									}
									else if($_GET["dato"] == 2) // Hubo un error
									{
										if(isset($_GET["e2"]))
										{
											echo("Error al actualizar la BBDD <br />");
										}
										if(isset($_GET["e3"]))
										{
											echo("Error, la noticia no estaba en la BBDD <br />");
										}
										if(isset($_GET["e4"]))
										{
											echo("Error 506, el comando no existe <br />");
										}
									}
								}
								$i = 1;
								?>
                        		<div class="contenido">
									<table border = 1>
                                        <TR>
                                            <TH scope="col">id</TH>
                                            <TH scope="col">T&iacute;tulo</TH>
                                            <TH scope="col">Resumen</TH>
                                            <TH scope="col">Comentarios</TH>
                                            <TH scope="col" colspan="2">Opciones</TH>
                                        </TR>
                                <?php
								while($fila = mysql_fetch_assoc($resultados))
								{
									$numComentarios = 0;
									$RComentarios = $con->consulta("SELECT id FROM noticias WHERE titulo=\"".$fila["titulo"]."\";");
									if(!$RComentarios)
									{
										echo mysql_error()."  en la consulta ";
									}
									else
									{
										$numComentarios = mysql_num_rows($RComentarios)-1;
									}
									$titulo = $fila["titulo"];
									if(strlen($titulo)>30)
									{
											$aux = substr($titulo, 0, 13);
											$aux = $aux."...";
											$aux = $aux.substr($titulo, strlen($titulo)-14, strlen($titulo)-1);
											$titulo = $aux;
									}
									$resumen = $fila["corto"];
									if(strlen($resumen)>50)
									{
											$aux = substr($resumen, 0, 23);
											$aux = $aux."...";
											$aux = $aux.substr($resumen, strlen($resumen)-24, strlen($resumen)-1);
											$resumen = $aux;
									}
									$i++;
									?>
									<TR>
                                        <TD><?php echo $fila["id"];?></TD>
                                        <TD><?php echo $titulo;?></TD>
                                        <TD><?php echo $resumen;?></TD>
                                        <TD><?php echo $numComentarios;?></TD>
                                        <TD><input type="button" value="borrar" onclick="location.href='admin_news.php?id=borrar&dato=<?php echo $fila["titulo"];?>'" /></TD>
                                        <TD><input type="button" value="editar" onclick="location.href='Zona-admin.php?id=6&modo=3&dato=<?php echo $fila["titulo"];?>'" /></TD>
									</TR>
									<?php
								} 
								?>
									</table>
                                </div>
                                <?php
							}
							else if($modo == 3)
							{
								if(isset($_GET["dato"]))
								{
									$con = new conexion();
									$resultados = $con->consulta("SELECT * FROM noticias WHERE titulo=\"".$_GET["dato"]."\"");
									$fila = mysql_fetch_assoc($resultados);
									?>
                                    <div class="contenido">
                                        <div class="formulario2">
                                            <form action="admin_news.php?id=editar&dato=<?php echo $_GET["dato"]; ?>" method="post"enctype="multipart/form-data">
                                                T&iacute;tulo de la noticia: <?php echo $_GET["dato"]; ?><br />
                                                Descripci&oacute;n de la noticia: <br /> <textarea NAME = "resumen" COLS=40 ROWS=6 ><?php echo $fila["corto"];?></textarea><br />
                                                Texto de la noticia: <br /> <textarea NAME = "texto" COLS=40 ROWS=6 ><?php echo $fila["texto"];?></textarea><br /><br />
                                                <INPUT TYPE="submit" NAME = "subir" value="Actualizar" />
                                            </form>	
                                        </div>
                                    </div>
                                    <?php	
								}
								else
								{
									echo "Error de formato en la direccion<br />";
								}
							}
						}
					}
				}
			?>
            </div>
        </div>
	</body>
</html>
