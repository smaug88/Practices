<?php 
class conexion 
{
	//Datos de la conexin
	var $host="mysql9.000webhost.com";
	var $usuario="a9828503_gallo";	// Nombre de usuario con derechos de escritura
	var $clave="sopadepollo76";		// Contraseña del usuario
	var $nombre_bdd="a9828503_WW";	// Nombre de la base de datos a acceder
	var $conexion;
	var $dataset;
	//La funcion que se llamaba igual que la clase, es la constructura, como el new
	//Crea la conexion con la bdd
	//NOTA: Aqui, podra habilitarse la funcion para que aceptase parametros indicando
	//todos los datos de conexion (los nombres y el tipo de la bdd). Servira para abrir
	//todo tipo de bases de datos con una sola funcion. Modulo reutilizable al maximo.
	function conexion()
	{
		//Conectamos a la BDD
		$this->conexion = mysql_connect($this->host, $this->usuario, $this->clave) 
		or die("Error al conectar con la base de datos: C01");
		$bdd=mysql_select_db($this->nombre_bdd,$this->conexion)
		or die("Error seleccionando la base de datos: C02");
	}
	
	function consulta($csql)
	{
		return mysql_query($csql,$this->conexion);
	}
	
	function campo($indice,$fila,$columna)
	{
		mysql_data_seek($this->dataset[$indice],$fila); 
		$row = mysql_fetch_row($this->dataset[$indice]);
		return $row[$columna];
	}
	
	function num_filas($tabla)
	{
		return mysql_query("SELECT FOUND_ROWS( ) FROM ".$tabla);
	}
	
	function num_campos($indice)
	{
		return mysql_num_fields($this->dataset[$indice]);
	}
	
	function ultimo_id() {
		return mysql_insert_id($this->conexion);
	}	

	function nueva_tabla($nombre, $directorio)
	{
		mysql_query("CREATE TABLE ".$nombre." (id MEDIUMINT NOT NULL AUTO_INCREMENT, 
											   usuario TINYTEXT NOT NULL, 
											   comentario TEXT NOT NULL, 
											   hora DATE NOT NULL, 
											   fecha TIME NOT NULL, 
											   PRIMARY KEY(id), 
											   FOREIGN KEY(usuario) REFERENCES usuario)", $this->conexion);
	}
	
	function nuevo_comic($nombre, $descripcion, $tags, $comic_small, $comic_medium, $comic_big, $fecha)
	{	
		
		$resultado = $this->consulta("SELECT * FROM comics");
		$id = mysql_num_rows($resultado);
		return mysql_query("INSERT INTO comics (id, nombre, fecha, comic_small, comic_medium, comic_big, tags, descripcion)
		                         VALUES (\"".$id."\",
										 \"".$nombre."\",
										 \"".$fecha."\",
		                                 \"".$comic_small."\", 
		                                 \"".$comic_medium."\", 
		                                 \"".$comic_big."\",
		                                 \"".$tags."\",
		                                 \"".$descripcion."\");");
	}
	
	function nuevo_fanart($nombre, $descripcion, $tags, $comic_small, $comic_big, $fecha)
	{	
		
		$resultado = $this->consulta("SELECT * FROM fanarts");
		$id = mysql_num_rows($resultado);
		return mysql_query("INSERT INTO fanarts (id, nombre, fecha, fanart_small, fanart_big, tags, descripcion)
		                         VALUES (\"".$id."\",
										 \"".$nombre."\",
										 \"".$fecha."\",
		                                 \"".$comic_small."\",  
		                                 \"".$comic_big."\",
		                                 \"".$tags."\",
		                                 \"".$descripcion."\");");
	}
	
	function nueva_noticia($titulo, $corto, $texto, $fecha)
	{	
		
		$resultado = $this->consulta("SELECT * FROM noticias");
		$id = mysql_num_rows($resultado);
		return mysql_query("INSERT INTO noticias (id, titulo, corto, texto, fecha)
		                         VALUES (\"".$id."\",
										 \"".$titulo."\",
										 \"".$corto."\",
										 \"".$texto."\",
		                                 \"".$fecha."\");");
	}
	
	function borrar_comic($nombre)
	{
		mysql_query("DELETE FROM comentarios WHERE comic=\"".$nombre."\";");
		mysql_query("DELETE FROM comics WHERE nombre=\"".$nombre."\";");
	}
	
	function borrar_fanart($nombre)
	{
		mysql_query("DELETE FROM comentarios_fanart WHERE fanart=\"".$nombre."\";");
		mysql_query("DELETE FROM fanarts WHERE nombre=\"".$nombre."\";");
	}
	
	function borrar_noticia($nombre)
	{
		mysql_query("DELETE FROM comentarios_noticia WHERE noticia=\"".$nombre."\";");
		mysql_query("DELETE FROM noticias WHERE titulo=\"".$nombre."\";");
	}
	
	function nuevo_comentario($comic, $autor, $fecha, $texto, $email)
	{
		return mysql_query("INSERT INTO comentarios (comic, autor, fecha, texto, email)
		                         VALUES (\"".$comic."\",
										 \"".$autor."\",
										 \"".$fecha."\",
		                                 \"".$texto."\",
										 \"".$email."\");");
	}
	
	function nuevo_comentario_fanart($comic, $autor, $fecha, $texto, $email)
	{
		return mysql_query("INSERT INTO comentarios_fanart (fanart, autor, fecha, texto, email)
		                         VALUES (\"".$comic."\",
										 \"".$autor."\",
										 \"".$fecha."\",
		                                 \"".$texto."\",
										 \"".$email."\");");
	}
	
	function nuevo_comentario_noticia($noticia, $autor, $fecha, $texto, $email)
	{
		return mysql_query("INSERT INTO comentarios_noticia (noticia, autor, fecha, texto, email)
		                         VALUES (\"".$noticia."\",
										 \"".$autor."\",
										 \"".$fecha."\",
		                                 \"".$texto."\",
										 \"".$email."\");");
	}
	
	function login($user, $pass)
	{
		$query = mysql_query("SELECT * FROM administracion",$this->conexion);
		$vector = mysql_fetch_assoc($query);
		if(($vector["user"] == $user)&&($vector["pass"] == $pass))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}
?>
