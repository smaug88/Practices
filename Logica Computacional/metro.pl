:- ensure_loaded('asterisco.pl').
:- ensure_loaded('Dijkstra.pl').

metro:- new(D,dialog('Sistema de trayectos del Metro de Madrid')),
       	send(D, append,
	     button('Dijkstra',message(D,return,1))),
	send(D, append,
	     button('A*',message(D,return,2))),
	send(D, append,
	     button('Salir',message(D,return,3))),
	send(D, default_button, 'Salir'),
	get(D, confirm, Rval),
	free(D),
	lista(Rval).

lista(3):- !.

lista(N):-
	new(D, dialog('Estación Inicial')),
        send(D, append, new(B, list_browser)),
        forall(coordenadas(X,_,_), send(B, append, X)),
	send(D, append,
             button('Siguiente',
                    message(D,return,
                            B?selection?key))),
        send(D,open),
	get(D,confirm, Rval),
	free(D),
	K = Rval,
	lista2(N,K).

lista2(N,L):-
	new(D, dialog('Estación Final')),
        send(D, append, new(B, list_browser)),
        forall(coordenadas(X,_,_), send(B, append, X)),
	send(D, append,
             button('Cálculo',
                    message(D,return,
                            B?selection?key))),
        send(D,open),
	get(D,confirm, Rval),
	free(D),
	K = Rval,
	opcion(N,L,K).

opcion(1, Einic, Efin):-
	    ruta_dn(Einic, Efin),
	    metro.

opcion(2,Einic, Efin):-
	    ruta_an(Einic, Efin),
	    metro.
