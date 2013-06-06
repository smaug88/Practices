<link rel="stylesheet" type="text/css" href="estilo/estilo.css" />
<div class="cabecera">
	<?php $bann = rand(0,1);
	echo "<a href='index.php'><img id='banner' src='banner".$bann.".gif'/></a>";
	?>
</div>
<div id="menu">
	<ul id="Menu">
		<li><a href="comic.php"><img src="../menu/comic.gif"/></a>
		<ul>
			<li><a href="comic.php?id=0"><img src="../menu/primero.gif"/></a></li>
			<li><a href="comic.php"><img src="../menu/ultimo.gif"/></a></li>
			<li><a href="comic.php?id=-1"><img src="../menu/archivo.gif"/></a></li>	
		</ul>
		</li>
		<li><a href="fanart.php"><img src="../menu/fanart.gif"/></a>
		<ul>
			<li><a href="fanart.php?id=0"><img src="../menu/primero.gif"/></a></li>
			<li><a href="fanart.php"><img src="../menu/ultimo.gif"/></a></li>
			<li><a href="fanart.php?id=-1"><img src="../menu/archivo.gif"/></a></li>	
		</ul>
		</li>
		<li><a href="autor.php"><img src="../menu/autor.gif"/></a></li>
		<li><a href="phpBB3"><img src="../menu/foro.gif"/></a></li>
		<li><a href="feed.php"><img src="../menu/feed.gif"/></a></li>
	</ul>
</div>