<?
	header('Content-Type: text/xml');
	echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>";
?>
<rss version="2.0"> 
	<channel> 
		<title>West Waterwick</title> 
		<link>http://westwaterirk.host56.com/</link> 
		<language>es-es</language> 
		<description>RSS de West Waterwick</description> 
		<generator>West Waterwick</generator> 
		<?php
			include 'conexion.php';
			$con = new conexion();
			$resultado = $con->consulta("SELECT * from noticias ORDER BY fecha DESC LIMIT 10");
			while($row=mysql_fetch_array($resultado))
			{
		?>
			<item> 
				<title><?php echo htmlspecialchars($row['titulo'],ENT_QUOTES);?></title> 
				<link>http://westwaterirk.host56.com/noticias.php?id=<?php echo $row["id"];?></link> 
				<pubDate><?php echo $row["fecha"];?></pubDate> 
				<category>Noticia</category> 
				<description><?php echo htmlspecialchars($row['corto'],ENT_QUOTES);?></description> 
				<![CDATA[<content:encoded><?php echo htmlspecialchars($row['texto'],ENT_QUOTES);?></content:encoded> ]]>
			</item>
		<?php
			}
			
			$resultado = $con->consulta("SELECT * from comics ORDER BY fecha DESC LIMIT 10");
			while($row=mysql_fetch_array($resultado))
			{
		?>
			<item>
				<title><?php echo htmlspecialchars($row['nombre'],ENT_QUOTES);?></title> 
				<link>http://westwaterirk.host56.com./comic.php?id=<?php echo $row["id"];?></link> 
				<pubDate><?php echo $row["fecha"];?></pubDate> 
				<category>Comic, <?php echo htmlspecialchars($row['tags'],ENT_QUOTES);?></category> 
				<description><?php echo htmlspecialchars($row['descripcion'],ENT_QUOTES);?>
					<img src='http://westwaterirk.host56.com/comic_big/<?php echo $row["comic_big"];?>'/>
				</description> 
			</item>
		<?php
			}
			$resultado = $con->consulta("SELECT * from fanarts ORDER BY fecha DESC LIMIT 10");
			while($row=mysql_fetch_array($resultado))
			{
		?>
			<item> 
				<title><?php echo htmlspecialchars($row['nombre'],ENT_QUOTES);?></title> 
				<link>http://westwaterirk.host56.com./noticias.php?id=<?php echo $row["id"];?></link> 
				<pubDate><?php echo $row["fecha"];?></pubDate> 
				<category>Fan-art, <?php echo htmlspecialchars($row['tags'],ENT_QUOTES);?></category> 
				<description><?php echo htmlspecialchars($row['descripcion'],ENT_QUOTES);?>
					<img src='http://westwaterirk.host56.com/fanart_big/<?php echo $row["fanart_big"];?>'/>
				</description>
			</item>
		<?php
			}
		?>
	</channel>
</rss>