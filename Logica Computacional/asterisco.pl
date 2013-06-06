:- ensure_loaded('lineas.pl').

% Informa al usuario hacia dónde dirigirse, con qué líneas y cuánto tardará para ir de 'Inicio' a 'Destino'
% La ruta se calcula por medio del A asterisco

ruta_an( A, A ) :- write_ln( 'LAS RUTAS DE INICIO Y DESTINO SON IGUALES.' ), !.
ruta_an( Inicio, Destino ) :-
	aster( Inicio, Destino, Ruta ), % se calcula el trayecto
	length( Ruta, N_Estaciones ),	 % se calcula el número de estaciones
	% write( 'Su ruta de viaje es: ' ), write( Ruta ), write( '\n\n' ),
	% se indica al usuario qué líneas debe tomar desde dónde hasta dónde y en qué sentido
	write('\n\n La ruta de debe tomar es: \n\n'),
	que_Linea_Tomar( Inicio, Ruta, N_Estaciones, 0 ),
	coste( Ruta, Segundos ), % se calcula el tiempo que durará el trayecto
	seg_2_horas( Segundos ), % se imprime en pantalla en formato h.m.s.
	retract( nodos_exp( N ) ),
	write( 'Nodos expandidos: ' ), write( N ),
	!.


% Calcula la ruta entre 'Inicio' y 'Destino' y la devuelve en L.

aster( Inicio, Destino, L ) :-
	% se calcula el coste estimado desde donde se parte hasta el destino
	dist( Inicio, [ Inicio ], Destino, Est ),

	% functor nodo( Nodo_actual, Ruta, Coste, Dist )
	Nodo = nodo( Inicio, [ Inicio ], 0, Est ),

	astar( [ Nodo ], [], Destino, Ruta ), 
	reverse( Ruta, L ), % solución desde 'Inicio' a 'Destino'
	!.

astar( Abierta, Cerrada, Destino, Ruta ):-
    % buscar_mas_corto quita Mascorto de la Lista_Abierta.
	buscar_mas_corto( Abierta, Mascorto, Abierta1 ),
	astar( Mascorto, Abierta1, Cerrada, Destino, Ruta ).

% Si Mascorto == 'Destino' (nodo objetivo), se devuelve la ruta.
astar( Mascorto, _, _, Destino, Ruta ):- 
	Mascorto = nodo( Estacion, Ruta, _, _ ), 
	Estacion == Destino.

astar( Mascorto, Abierta, Cerrada, Destino, Ruta ) :-
	Mascorto = nodo( Estacion, _, _, _ ),
	Estacion \== Destino, 

	% se agrega Mascorto->Estacion a la Lista_cerrada (Cerrada)
	Cerrada1 = [ Estacion | Cerrada ],

	% para cada 'Nodo' vecino de Mascorto, obtenemos la nueva lista abierta
	(
		setof( Nodo, expandir( Mascorto, Destino, Nodo, Cerrada ), N ) -> merge( Abierta, N, Abierta1 )
	;
		Abierta1 = Abierta
	),
	calc_cost( Abierta1, Abierta2 ), % se recalculan los costes por causa de los offsets
	astar( Abierta2, Cerrada1, Destino, Ruta ). % mientras la Lista_Abierta no esté vac’a,

%
% Evalúa los vecinos de Mascorto
%
expandir( Nodo, Destino, SigNodo, Cerrada ) :-
	Nodo = nodo( Estacion, Ruta, C, _ ),
	coste( Estacion, SigEst, Coste ),

	% si el vecino de Mascorto (SigEst) está en la Lista_Cerrada --> continue
	\+ member( SigEst, Cerrada ),
	SigRuta = [ SigEst | Ruta ], % en otro caso, se conecta Mascorto con SigEst
	SigCoste is C + Coste, 
	dist( SigEst, SigRuta, Destino, Dist ), % Dist = coste aprox. para ir desde SigEst a Destino
	SigC is SigCoste + Dist,
	SigNodo = nodo( SigEst, SigRuta, SigCoste, SigC ). % si SigEst no está en la Lista_Abierta, se a–ade.

% funciona
dist( Actual, _, Destino, H ):- distancia( Actual, Destino, D ), H is D / 7.75.

% Busca el nodo de la Lista_Abierta (Abierta) que posee el valor más bajo de f(s).
% Abierta1 es Abierta sin Mascorto.

buscar_mas_corto( Abierta, Mascorto, Abierta1 ):-
	nth1( 1, Abierta, E ),
	dist_min( Abierta, E, Mascorto ), 	% se busca el nodo con mas cercano
	(
		retract( nodos_exp( N ) ),
        	Nexp is N + 1,
        	assert( nodos_exp( Nexp ) )
	;
		assert( nodos_exp( 1 ) )
	),
	select( Mascorto, Abierta, Abierta1 ).  % se quita Mascorto de Abierta

% dist_min( Abierta, E, Mascorto ) tiene éxito si Mascorto es el elemento de Abierta
% que tiene el menor coste.
% Abierta es una lista de functores nodo( Nodo_actual, Ruta, Coste, Dist ).

dist_min( [], MD, MD ). % si la Lista_Abierta sólo posee 1 elemento (MD), se devuelve.
dist_min( [ V | L ], Elem, MD ):-
	corto( V, Elem ), !, % comprobamos si V tiene una distancia menor que el menor actual (Elem).
	dist_min( L, V, MD ).  % seguimos con el resto de la lista.
dist_min( [ _ | L ], Elem, MD ):-
	dist_min( L, Elem, MD ). % en caso de que no se cumpla el predicado anterior, seguimos con el resto de la lista.

corto( nodo( _, _, _, Est ), nodo( _, _, _, Est2 ) ):- Est < Est2.

% Obtiene el coste final de un trayecto.
calc_cost( [], [] ).
calc_cost( [ nodo( Nodo_actual, Ruta, _, Dist )| Xs ], [nodo( Nodo_actual, Ruta, Coste, Dist ) | Ys ] ):- coste( Ruta, Coste ), calc_cost( Xs, Ys ).
