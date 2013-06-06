<?php
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 *	Sube las imagenes y los distintos datos al servidor	 *
	 *	$fanart_grande: imagen grande del fanart			 *
	 *	$fanart_peq: imagen peqeña del fanart				 *
	 *	$tags: conjunto de tags del fanart					 *
	 *	$desc: descripcion del fanart						 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	 
	function nuevo_usuario($nombre, $email, $avatar, $blog)
	{
		if(comprueba_mail($email))
		{
			if(strlen($nombre)>3)
				{
				// Actualizamos la BBDD
				$c = new conexion();
				if($c->consulta("SELECT * FROM usuarios WHERE id IS ".$id)==NULL)
				{
					if($blog!=NULL)
						$c->consulta("INSERT INTO usuarios VALUES ".$nombre.", ".$email.", ".$avatar.", ".$blog);
					else
						$c->consulta("INSERT INTO usuarios VALUES ".$nombre.", ".$email.", ".$avatar);
				}
				else
				{
					if ($email==$c->consulta("SELECT email FROM usuarios where id IS ".$nombre))
						echo "usuario correcto pero ya registrado";
					else
						echo "error en la creacion de usuario";
				}
			}
		}
		else
			echo "email no valido";
	}
	
	function comprueba_email($email)
	{ 
		$mail_correcto = 0; 
		//compruebo unas cosas primeras 
		if ((strlen($email) >= 6) && (substr_count($email,"@") == 1) && (substr($email,0,1) != "@") && (substr($email,strlen($email)-1,1) != "@"))
		{ 
			 if ((!strstr($email,"'")) && (!strstr($email,"\"")) && (!strstr($email,"\\")) && (!strstr($email,"\$")) && (!strstr($email," "))) 
			 { 
				 //miro si tiene caracter . 
				 if (substr_count($email,".")>= 1)
				 { 
					 //obtengo la terminacion del dominio 
					 $term_dom = substr(strrchr ($email, '.'),1); 
					 //compruebo que la terminación del dominio sea correcta 
					 if (strlen($term_dom)>1 && strlen($term_dom)<5 && (!strstr($term_dom,"@")) )
					 { 
						 //compruebo que lo de antes del dominio sea correcto 
						 $antes_dom = substr($email,0,strlen($email) - strlen($term_dom) - 1); 
						 $caracter_ult = substr($antes_dom,strlen($antes_dom)-1,1); 
						 if ($caracter_ult != "@" && $caracter_ult != ".") 
							 $mail_correcto = 1; 
					 } 
				 } 
			 } 
		} 
		if ($mail_correcto) 
			 return 1; 
		else 
			 return 0; 
	} 
?>