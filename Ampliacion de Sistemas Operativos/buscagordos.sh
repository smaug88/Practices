#!/bin/bash


total=-10;
modo=0;
orden=0;
# Comprobamos si tenemos algún argumento
if [ $# == 0 ]
then
	ruta="";
	total=-10;
else
	# Estudiamos cada argumento
	for k in $@
	do
		if [ $k == '--help' ]
		then
			printf "Este sistema busca los N ficheros mas grandes de los directorios suministrados.\n";
			continue;
		fi
		if [ $k == '--size' ]
		then
			modo=1;
			continue;
		fi
		if [ $k == '--route' ]
		then
			modo=2;
			continue;
		fi
		if [ $k == '--reverse' ]
		then
			orden=1
			continue;
		fi
		if [ $k == '-l' ]
		then
			modo=1;
			continue;
		fi
		if [ $k == '-r' ]
		then
			modo=2;
			continue;
		fi
		if [ $k == '-R' ]
		then
			orden=1;
			continue;
		fi
		expr ${k:1:1} + 0 >/dev/null 2>&1;
		if [ $? -eq 0 ]
		then
			total=$k;
			continue;
		fi
		if [ ${k:0:1} == '-' ]
		then
			printf "Error: el comando "$k" es desconocido.\n"
			exit;
		fi
		if [ ${k:0:2} == '--' ]
		then
			printf "Error: el comando "$k" es desconocido.\n"
			exit;
		fi
		ruta=$ruta" "$k;
	done
fi
aux="";
inicial=1;
# Estudiamos cada fichero
for fichero in $(find $ruta -type f)
do
	if [ ${fichero:0:1} == '/' ]||[ ${fichero:0:2} == './' ]||[ ${fichero:0:3} == '../' ]
	then
		if [ $inicial != 1 ]
		then
			# Damos forma a la ruta completa y guardamos en un fichero temporal los datos
			aux=$(readlink -f "$aux");

			if [ $modo == 0 ]
			then
				stat -c "%s %n" "$aux" >> /tmp/stat.aux;
			fi
			if [ $modo == 1 ]
			then
				du -h "$aux" >> /tmp/stat.aux;
			fi
			if [ $modo == 2 ]
			then
				stat -c "%s %n" "$aux" >> /tmp/stat.aux;
			fi
			aux=$fichero;
		else
			inicial=0;
			aux=$fichero;
		fi
	else
		aux=$aux" "$fichero;
	fi
done
if [ "$aux" == "" ]
then
	exit;
fi
aux=$(readlink -f "$aux");
if [ $modo == 0 ]
then
	stat -c "%s %n" "$aux" >> /tmp/stat.aux;
	if [ $orden == 0 ]
	then
		cat /tmp/stat.aux | sort -n | tail $total | sort -nr;
	else
		cat /tmp/stat.aux | sort -n | tail $total | sort -n;
	fi
fi
if [ $modo == 1 ]
then
	du -h "$aux" >> /tmp/stat.aux;
	if [ $orden == 0 ]
	then
		cat /tmp/stat.aux | sort -n | tail $total | sort -nr;
	else
		cat /tmp/stat.aux | sort -n | tail $total | sort -n;
	fi
fi
if [ $modo == 2 ]
then
	stat -c "%s %n" "$aux" >> /tmp/stat.aux;
	if [ $orden == 0 ]
	then
		cat /tmp/stat.aux | sort -n | tail $total | sort -nr >> /tmp/stat2.aux;
	else
		cat /tmp/stat.aux | sort -n | tail $total | sort -n >> /tmp/stat2.aux;
	fi
	cat /tmp/stat2.aux | sed 's/[0-9]* //g'
	rm /tmp/stat2.aux;
fi
# Cargamos los datos del fichero temporal, los ordenamos, los mostramos y eliminamos el fichero
rm /tmp/stat.aux;
