que_Linea_Tomar( Estacion, Ruta, N_Estaciones, Transbordos ):-
	write( '    Debe tomar la línea ' ),
	% buscamos una linea (N_Linea) en cuyo recorrido estén incluidas las estaciones Estacion
	% y la que viene a continuación de Estacion.
	lin( Estacion, N_Linea, Ruta, _, Recorrido, Tipo ), write( N_Linea ),
	write( ' en dirección ' ), write( Estacion ), write( ' hasta ' ),
	(
		(
			Tipo == lineal,
			(
				sublista( Ruta, Recorrido )
			;
				reverse( Ruta, N ), sublista( N, Recorrido )
			)
		;
			Tipo == circular, append( Recorrido, Recorrido, L ),
			(
				sublista( Ruta, L )
			;
				reverse( Ruta, N ), sublista( N, L )
			)
		;
			Tipo == circular, reverse( Recorrido, S ), append( S, S, T ), sublista( Ruta, T )
		),
		reverse( Ruta, M ), nth0( 0, M, Hasta ), write( Hasta ), write( '.\n' ),
		K is N_Estaciones - 2,
	        write( '\n\nRecorrerá ' ), write( K ), write( ' estaciones ' ),
		write( 'y hará ' ), write( Transbordos ), write( ' transbordo(s).\n' )
	;
		% sino buscamos la línea en la que se debe hacer el transbordo.
		hasta( Ruta, Recorrido, H ),
		nth0( J, Ruta, H ), J2 is J - 1,
		nth0( J2, Ruta, Hasta ),
		write( Hasta ), write( '.\n' ),
		N_Transbordos is Transbordos + 1,
		J3 is J2 - 1, borrar( J3, Ruta, Ruta2 ),
		que_Linea_Tomar( Hasta, Ruta2, N_Estaciones, N_Transbordos )
	).


% Se busca la linea (N_Linea) en cuyo Recorrido estén incluidas las estaciones Estacion y las 2 siguientes.
% Estacion y Ruta son parámetros de entrada.
% N_Linea: número de línea.
% Recorrido: listado de estaciones por donde pasa la línea N_Linea
% Dir: Estación que se encuentra a continuación de 'Estacion'. Se necesita para indicar en qué sentido tomar el tren.
% Tipo: lineal o circular.

lin( Estacion, N_Linea, Ruta, Dir, Recorrido, Tipo ):-
	linea( N_Linea, _, _, Tipo, Recorrido ), member( Estacion, Recorrido ), length( Ruta, Z ),
	(
		Z > 2, nth0( 1, Ruta, Dir ), nth0( 2, Ruta, Dir2 ), member( Dir2, Recorrido )
	;
		Z == 2, nth0( 1, Ruta, Dir )
	;
		Z == 1, nth0( 0, Ruta, Dir )
	),
	member( Dir, Recorrido ).

lin( Estacion, N_Linea, Ruta, Dir, Recorrido, Tipo ):-
	linea( N_Linea, _, _, Tipo, Recorrido ), member( Estacion, Recorrido ), length( Ruta, Z ),
	(
		Z >= 2, nth0( 1, Ruta, Dir )
	% ;
		% Z == 1, nth0( 0, Ruta, Dir )
	),
	member( Dir, Recorrido ).


% ¿Es S sublista de L?

sublista( S, L ):- append( _, L2, L ), append( S, _, L2 ).


% devuelve el primer elemento (de la lista que se pasa como primer parámetro) a partir del que dos listas difieren

hasta( [ ], [ ], _ ).
hasta( [ Ha | Ta ], L, H ) :- member( Ha, L ), hasta( Ta, L, H ), ! ; H = Ha, true.


% Borra los N primeros elementos de L. La nueva lista se deposita en L2.

borrar( N, L, L2 ):-
	(
		N >= 0, nth0( N, L, E ), select( E, L, Resto ), N1 is N - 1, borrar( N1, Resto, L2 )
	;
		L2 = L
	),
	!.

seg_2_horas(Seg):-
	S is Seg mod 60,
	Min is ( floor( ( Seg / 60 ) ) mod 60 ),
	H is floor( ( floor( ( Seg / 60 ) ) / 60 ) ),
	write( '\nEl tiempo de viaje será: ' ),
	write( H ), write( ' h. ' ),
	write( Min ), write( ' min. ' ),
	write( S ), write( ' seg.\n' ).


% añade el elemento Y al final de la lista indicada por el segundo parámetro.

añadir( Y, [ X | T ], [ X | NT ] ):- añadir( Y, T, NT ).
añadir( Y, [ ], [ Y ] ).

% ----------------------------------------------------------------------
% Calcula el coste (tiempo) entre dos estaciones cualesquiera.
% Se asume que el argumento inicial contiene la lista de estaciones
% correspondiente a todo el trayecto.
% ----------------------------------------------------------------------


% líneas circulares.

coste( 'Puerta del Sur', 'San Nicasio', 408 ).
coste( 'San Nicasio', 'Puerta del Sur', 408 ).
coste( 'Laguna', 'Lucero', 325 ).
coste( 'Lucero', 'Laguna', 325 ).


% Además comprueba transbordos

coste( X, Y, C ):- linea( _, _, _, _, R ), ( nextto( Y, X, R ) ; nextto( X, Y, R ) ), coste( [ X, Y ], C ).


coste(Trayecto,Coste):-
	dividePorLineas(_,Trayecto,TrayectoEnLineas),
	costes(TrayectoEnLineas,0,Coste),
	!.

costes([],Coste,Coste).

costes([Linea-Estaciones],Acum,Coste):-
	costePorLinea(Linea-Estaciones,CosteLinea),
	Coste is CosteLinea + Acum.

costes([L1-E1s,L2-E2s|OtrosTrayectos],Acum,Coste):-
	costePorLinea(L1-E1s,CosteLinea1),
	last(E1s,E1u),
	E2s = [E2|_],
	get_time(L1,E1u,L2,E2,CosteTrasbordo),
	Acum1 is CosteLinea1 + CosteTrasbordo + Acum,
	costes([L2-E2s|OtrosTrayectos],Acum1,Coste).

% ----------------------------------------------------------------------
% Calcula el coste (tiempo) entre dos estaciones en un tramo de línea.
% ----------------------------------------------------------------------
costePorLinea(Linea-Estaciones,Coste):-
	length(Estaciones,Ne),
	coste(Estaciones,Linea,Ne,0,Coste).

coste([],Linea,Ne,Acumulado,Coste):-
	!,
	offset(Linea,Offset),
	Coste is round(Acumulado - 2*(Ne-2)*Offset).

% Sólo una estación. Necesario para resolver "anomalías"
% consistentes en trasbordos entre dos estaciones diferentes
coste([_],_,_,0,0):- !.

coste([E1,E2],Linea,Ne,Acumulado,Total):-
	!,
	get_time(Linea,E1,Linea,E2,Parcial),
	NAcum is Acumulado + Parcial,
	coste([],Linea,Ne,NAcum,Total).

coste([E1,E2|Es],Linea,Ne,Acumulado,Total):-
	get_time(Linea,E1,Linea,E2,Parcial),
	NAcum is Acumulado + Parcial,
	coste([E2|Es],Linea,Ne,NAcum,Total).

% ----------------------------------------------------------------------
% Dividir una lista de estaciones por tramos de línea
% ----------------------------------------------------------------------
dividePorLineas(_,[],[]):-!.


% Sesgo para preferir tramos que eviten trasbordos innecesarios
dividePorLineas(_,Estaciones,[(Linea-EnEstaLinea)|EnOtrasLineas]):-
	Estaciones = [E1,E2,E3|_],
	% Para acelerar la búsqueda la línea
	(   tiempo(Linea,E1,Linea,E2,_),
	    tiempo(Linea,E2,Linea,E3,_)
	;   tiempo(Linea,E3,Linea,E2,_),
	    tiempo(Linea,E2,Linea,E1,_)),
	linea(Linea,_,EFinal,Tipo,ListaLinea),
	(   Tipo = lineal -> rev_nextto(E1,E2,ListaLinea)
	;   rev_nextto(E1,E2,[EFinal|ListaLinea])
	),
	conectadas(Estaciones,Linea,EnEstaLinea,OtrasEstaciones),
	dividePorLineas(Linea,OtrasEstaciones,EnOtrasLineas),
	!.


dividePorLineas(_,Estaciones,[(Linea-EnEstaLinea)|EnOtrasLineas]):-
	Estaciones = [E1,E2|_],
	% Para acelerar la búsqueda la línea
	(   tiempo(Linea,E1,_,_,_)
	;   tiempo(Linea,E2,_,_,_)),
	linea(Linea,_,EFinal,Tipo,ListaLinea),
	(   Tipo = lineal -> rev_nextto(E1,E2,ListaLinea)
	;   rev_nextto(E1,E2,[EFinal|ListaLinea])
	),
	conectadas(Estaciones,Linea,EnEstaLinea,OtrasEstaciones),
	dividePorLineas(Linea,OtrasEstaciones,EnOtrasLineas),
	!.

% Estas definiciones son necesarias para tratar las "anomalías":
% trasbordos entre estaciones de diferente nombre
% Caso 1: Basta con el trasbordo. Situación sólo "teórica".
dividePorLineas(PrevLinea,[E],[(Linea-[E])]):-
	nonvar(PrevLinea),
	(   tiempo(PrevLinea,_,Linea,E,_) -> true
	;   tiempo(Linea,E,PrevLinea,_,_)),
	!.

dividePorLineas(_,[E1,E2],[(Linea-[E2])]):-
	(   tiempo(_,E1,Linea,E2,_)
	;   tiempo(_,E2,Linea,E1,_)),
	!.

% Caso 2: El trayecto tiene más de una estación
dividePorLineas(_,Estaciones,[(Linea1-[E1])|Tramos]):-
	Estaciones = [E1,E2|Otras],
	(   tiempo(Linea1,E1,Linea2,E2,_)
	;   tiempo(Linea1,E2,Linea2,E1,_)),
	Linea1 \== Linea2,
	!,
	dividePorLineas(Linea1,[E2|Otras],Tramos).


% ----------------------------------------------------------------------
% Verifica que dos estaciones son consecutivas en la línea
% ----------------------------------------------------------------------
enLinea([E1,E2],Linea,[E1,E2],[]):-
	linea(Linea,_,EFinal,Tipo,EstLinea),
	(   Tipo = lineal -> rev_nextto(E1,E2,EstLinea)
	;   rev_nextto(E1,E2,[EFinal|EstLinea])),
	!.

enLinea([E1,E2|Es],Linea,[E1|EnLinea],Resto):-
	linea(Linea,_,EFinal,Tipo,EstLinea),
	(   Tipo = lineal -> rev_nextto(E1,E2,EstLinea)
	;   rev_nextto(E1,E2,[EFinal|EstLinea])),
	!,
	enLinea([E2|Es],Linea,EnLinea,Resto).


enLinea([E],_,[E],[]).

% ----------------------------------------------------------------------
% Verifica que dos estaciones directamente conectadas
% ----------------------------------------------------------------------
conectadas([E1,E2],Linea,[E1,E2],[]):-
	linea(Linea,_,EFinal,Tipo,EstLinea),
	(   Tipo = lineal -> rev_nextto(E1,E2,EstLinea)
	;   rev_nextto(E1,E2,[EFinal|EstLinea])),
	!.

conectadas([E1,E2|Es],Linea,[E1|EnLinea],Resto):-
	linea(Linea,_,EFinal,Tipo,EstLinea),
	(   Tipo = lineal -> rev_nextto(E1,E2,EstLinea)
	;   rev_nextto(E1,E2,[EFinal|EstLinea])),
	!,
	conectadas([E2|Es],Linea,EnLinea,Resto).


conectadas([E1,E2|Es],Linea1,[E1],[E1,E2|Es]):-
	tiempo(Linea1,E1,Linea2,E1,_),
	!,
	Linea1 \== Linea2. % Paranoid check

conectadas([E1,E2|Es],Linea1,[E1],[E2|Es]):-
	tiempo(Linea1,E1,Linea2,E2,_),
	!,
	Linea1 \== Linea2, % More paranoid checks
	E1 \== E2.         % More paranoid checks

conectadas([E|Es],_,[E],[E|Es]).


% ----------------------------------------------------------------------
% Utilidades.
% ----------------------------------------------------------------------
get_time(Linea1,E1,Linea2,E2,Tiempo):-
	 tiempo(Linea1,E1,Linea2,E2,Tiempo),
	 !.
get_time(Linea1,E1,Linea2,E2,Tiempo):-
	 tiempo(Linea2,E2,Linea1,E1,Tiempo),
	 !.

rev_nextto(E1,E2,Es):-
	nextto(E1,E2,Es),
	!.

rev_nextto(E1,E2,Es):-
	nextto(E2,E1,Es),
	!.


% ----------------------------------------------------------------------
% Utilidades de verificación/corrección de erratas en nombres
% ----------------------------------------------------------------------

test_correspondencia(Línea):-
	findall(Estacion,correspondencia(Línea,Estacion,_),Estaciones),
	linea(Línea,_,_,_,EstacionesLinea),
	forall(member(E,Estaciones),member(E,EstacionesLinea)).

test_estaciones:-
	findall(E,coordenadas(E,_,_),Estaciones),
	findall(Es,linea(_,_,_,_,Es),E1s),
	flatten(E1s,E2s),
	sort(E2s,TodasEstaciones),
	check(Estaciones,TodasEstaciones).

check([],_).
check([E|Es],TodasEstaciones):-
	(   memberchk(E,TodasEstaciones) -> true
	;   format('~w no aparece en ninguna línea~n',[E])
	),
	check(Es,TodasEstaciones).

test_líneas:-
	findall(E,coordenadas(E,_,_),Estaciones),
	findall(Es,linea(_,_,_,_,Es),E1s),
	flatten(E1s,E2s),
	sort(E2s,TodasEstaciones),
	check(TodasEstaciones,Estaciones).

% ----------------------------------------------------------------------
% Usado para generar el esqueleto de costes.pl
% ----------------------------------------------------------------------
write_times(Linea):-
	telling(Old),
	append('costes.pl'),
	linea(Linea,Primera,_,Tipo,Estaciones),
	process(Linea,Tipo,Primera,Estaciones),
	told,
	tell(Old).

process(_,lineal,_,[_]).
process(Linea,circular,Primera,[Ultima]):-
	Primera \== Ultima,
	format('tiempo(~w,\'~w\',~w,\'~w\',0).~n',
	       [Linea,Ultima,Linea,Primera]).

process(Linea,Tipo,Primera,[E1,E2|Es]):-
	format('tiempo(~w,\'~w\',~w,\'~w\',0).~n',
	       [Linea,E1,Linea,E2]),
	process(Linea,Tipo,Primera,[E2|Es]).


% ----------------------------------------------------------------------
% Identifica los tiempos de correspondencias que no son iguales
% ----------------------------------------------------------------------
tiempos_no_correspondientes(L):-
	findall((E,L1,L2),
		(   tiempo(L1,E,L2,E,T1), tiempo(L2,E,L1,E,T2), T1 =\= T2),
		L).


% ----------------------------------------------------------------------
% Función heurística: Calcula el coste (tiempo) estimado para
% viajar entre dos estaciones cualesquiera. Se emplea como
% base de la heurística la distancia entre las estaciones obtenida a
% partir de las coordenadas de las estaciones.
%
% Radio medio de la Tierra en metros: 6371000 m
% ----------------------------------------------------------------------

distancia(E1,E2,Dist):-
	coordenadas(E1,Lat1,Lon1),
	coordenadas(E2,Lat2,Lon2),
	LatMed is pi*(Lat1+Lat2)/360,
	Dist is sqrt((Lat1-Lat2)^2+((Lon1-Lon2)*cos(LatMed))^2)*6371000*pi/180.


velocidad(E1,E2,Vel):-
	distancia(E1,E2,Dist),
	once(   tiempo(Linea,E1,Linea,E2,Tiempo)
	    ;   tiempo(Linea,E2,Linea,E1,Tiempo)),
	Vel is Dist/Tiempo.

velocidad_media(Linea,Vmed):-
	linea(Linea,_,_,_,Estaciones),
	length(Estaciones,Nest),
	vel_linea(Estaciones,0,Vsum),
	Vmed is Vsum/(Nest-1),
	format('~nLínea ~w  Vel media: ~f m/s.~n',[Linea,Vmed]).

vel_linea([_],Vsum,Vsum):-!.
vel_linea([E1,E2|Es],Acum,Vsum):-
	velocidad(E1,E2,Vel),
	distancia(E1,E2,Dist),
	once(   tiempo(Linea,E1,Linea,E2,Tiempo)
	    ;   tiempo(Linea,E2,Linea,E1,Tiempo)),
	format('~w~`.t~w~45| :~f m/s ~62|~2f m ~73|~d s ~n',[E1,E2,Vel,Dist,Tiempo]),
	Acum1 is Acum + Vel,
	vel_linea([E2|Es],Acum1,Vsum).
