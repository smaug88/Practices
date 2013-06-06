:- ensure_loaded('lineas.pl').

% Informa al usuario hacia dónde dirigirse, con qué líneas y
% cuánto tardará para ir de 'Inicio' a 'Destino'
% La ruta se calcula por medio de Dijkstra

ruta_dn( A, A ) :- write_ln( 'LAS RUTAS DE INICIO Y DESTINO SON IGUALES.' ), !.
ruta_dn( Inicio, Destino ) :-
	camino( Inicio, Destino, Ruta, Dist ), % se calcula el trayecto (Ruta) y coste (Dist)
	length( Ruta, N_Estaciones ), % se calcula el número de estaciones
	% se indica al usuario qué líneas debe tomar desde dónde hasta dónde y en qué sentido
	write('\n\n La ruta de debe tomar es: \n\n'),
	que_Linea_Tomar( Inicio, Ruta, N_Estaciones, 0 ),
	seg_2_horas( Dist ),  % se imprime en pantalla en formato h.m.s.
	retract( nodos_exp( N ) ),
	write( 'Nodos expandidos: ' ), write( N ),
	!.


% camino( Inicio, Destino, Ruta, Dist ) calcula la ruta más corta entre 'Inicio' y 'Destino'
% devolviéndola en Ruta. De la misma manera el coste desde 'Inicio' hasta 'Destino' se coloca en 'Dist'.

camino( Inicio, Destino, Ruta, Dist ):- dijkstra( Inicio, L ), member( nodo( Destino, Dist, Ruta ), L ), !.


% Calcula la ruta entre 'Inicio' y 'Destino' y la devuelve en L.

dijkstra( Inicio, L ):-
% para cada uno de los vértices se calcula la distancia por pares
% si existe arista entre ellos.
	conectar( Inicio, [ Inicio ], Ls ), % se buscan los vértices a los que se tiene acceso
	dijkstra_1( Ls, [ nodo( Inicio, 0, [] ) ], L ).

dijkstra_1( [], L, L ).
dijkstra_1( [ Elem | Resto ], L0, L ):-
% mientras que no estén vistos todos los vértices ...
	dist2( Resto, Elem, S ), % se busca el de menor distancia
	eliminar( [ Elem | Resto ], [ S ], Ls ),
	S = nodo( V, Dist, Ruta ),
% se añade la nueva estación a la ruta.
	reverse( [ V | Ruta ], Ruta1 ), % Se invierte la lista para que esté en sentido corcalc_cost2to
% añadimos a la ruta_mas_corta_parcial(L0) el nuevo nodo
	merge( L0, [ nodo( V, Dist, Ruta1 ) ], L1 ),
	conectar( V, [ V | Ruta ], L2 ), % se buscan los sucesores del nuevo nodo
	eliminar( L2, L1, L3 ),          % y se eliminan los duplicados
	incr( L3, Dist, L4 ),		 % se actualiza la distancia
% se añade a la lista de vértices sin procesar los últimos a los que se ha llegado
	merge( Ls, L4, L5 ),
	calc_cost2( L5, L6 ),			  % se calculan las distancias por causa de los offsets
	dijkstra_1( L6, L1, L ).	  % mientras que no estén vistos todos los vértices


% conectar( Inicio, Ruta, L ) crea una lista (L) de functores nodo( Nodo_Actual, Coste, Ruta ).
% Para cada una de las estaciones a las que se puede acceder desde Nodo_Actual,
% L contiene la distancia (tiempo) desde Nodo_Actual y la Ruta para llegar a dicha estación.

conectar( Inicio, Ruta, L ):-
	setof( nodo( V, Coste, Ruta ), coste( Inicio, V, Coste ), L ),
	length( L, Nodos ),
	(
		retract( nodos_exp( N ) ),
        	Nexp is N + Nodos,
        	assert( nodos_exp( Nexp ) )
	;
		assert( nodos_exp( 1 ) )
	),
	!.
conectar( _, _, [] ).

% dist2( Resto, Elem, S ) tiene éxito si Elem es el elemento de Resto
% que posee la distancia más baja.
% Resto es una lista de functores nodo( Nodo_actual, Ruta, Coste, Heurística ).

dist2( [], MD, MD ). % si la Lista_Abierta sólo posee 1 elemento (MD), se devuelve.
dist2( [ V | L ], Elem, MD ):-
	mascorto( V, Elem ), !,  % comprobamos si V tiene un f(s) menor que el menor actual (Elem).
	dist2( L, V, MD ).  % seguimos con el resto de la lista.
dist2( [ _ | L ], Elem, MD ):-
	dist2( L, Elem, MD ). % en caso de que no se cumpla el predicado anterior, seguimos con el resto de la lista.

mascorto( nodo( _, X, _ ), nodo( _, Y,_ ) ) :- X < Y.


% Resto, Resto2 y L son listas de functores nodo. L resulta de borrar en Resto
% todos aquellos elementos que tengan los mismos Nodo_actual que Resto2.

eliminar( [ ], _, [ ] ). % si las listas estén vacías, no hay nada que eliminar
eliminar( [ X | Resto ], [ ], [ X | Resto ] ):- 
	!. % no hay nada que eliminar --> Resto2 está vacía
eliminar( [ X | Resto ], [ Y | Resto2 ], L ):- 
	igual( X, Y ), !, 
	eliminar( Resto, Resto2, L ).
% si el Nodo_actual de X es menor que el de Y, se elimina Resto y X se añade a L pero se elimina de la búsqueda.
eliminar( [ X | Resto ], [ Y | Resto2 ], [ X | L ] ):- 
	menor( X, Y ), !, 
	eliminar( Resto, [ Y | Resto2 ], L ).
% El Nodo_actual de X es mayor que el de Y --> Y se elimina de la búsqueda.
eliminar( [ X | Resto ], [ _ | Resto2 ], L ):- 
	eliminar( [ X | Resto ], Resto2, L ).

igual( nodo( X, _, _ ), nodo( X, _, _ ) ).

menor( nodo( X, _, _ ), nodo( Y, _, _ ) ):- X @< Y.


% L y M son listas de functores nodo( Estacion, Coste, Ruta ).
% incr( L, Incr, M ) copia la lista L en la M con la salvedad de que M.Coste = L.Coste + Incr.

incr( [], _, [] ).
incr( [ nodo( V, D1, P ) | Resto ], Incr, [ nodo( V, D2, P ) | Resto2 ] ):-
	D2 is D1 + Incr, incr( Resto, Incr, Resto2 ).

% Obtiene el coste final de un trayecto.
calc_cost2( [], [] ).
calc_cost2( [ nodo( V, _, P ) | Resto ], [ nodo( V, Coste, P ) | Resto2 ] ) :-
	reverse( P, P2 ), añadir( V, P2, P3 ), coste( P3, Coste ), calc_cost2( Resto, Resto2 ).
