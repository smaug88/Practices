import java.util.Scanner;
import monkeyqueen.*;

public class Trabajo_IA {

	public static MQ_Partida partida;

	public static void main(String[] args)
	{
		while(true)
		{
			partida = new MQ_Partida();
			Scanner sc = new Scanner(System.in);
			System.out.print("\nBienvenido al Grandioso y Magnífico juego de \n");
			System.out.print("\n                MONKEY-QUEEN                 \n\n\n");
			System.out.print("\nEscoja entre una de las siguientes opciones: \n");
			System.out.print("\n     - MÁQUINA vs MÁQUINA (0)");
			System.out.print("\n     - JUGADOR vs MÁQUINA (1)");
			System.out.print("\n     - JUGADOR vs JUGADOR (2)");
			System.out.print("\n     - CARGAR PARTIDA (3)");
			System.out.print("\n\n\n  Escoja: ");
			int opc = sc.nextInt();
			switch(opc)
			{
			case 0:
				Modo_2IA(false);
				break;
			case 1:
				Modo_1IA(false);
				break;
			case 2:
				Modo_2Jug(false);
				break;
			case 3:
				CargarPartida();
				break;
			}
		}
	}

	public static void CargarPartida()
	{
		String ruta = "";
		Scanner sc = new Scanner(System.in);
		System.out.print("\nPor favor, indique la ruta de la partida: ");
		ruta = sc.next();
		partida.Carga_Partida(ruta);
		System.out.print("\nEscoja entre una de las siguientes opciones: \n");
		System.out.print("\n     - MÁQUINA vs MÁQUINA (0)");
		System.out.print("\n     - JUGADOR vs MÁQUINA (1)");
		System.out.print("\n     - JUGADOR vs JUGADOR (2)");
		System.out.print("\n     - VER JUEGO (3)");
		System.out.print("\n\n\n  Escoja: ");
		int opc = sc.nextInt();
		switch(opc)
		{
		case 0:
			Modo_2IA(true);
			break;
		case 1:
			Modo_1IA(true);
			break;
		case 2:
			Modo_2Jug(true);
			break;
		case 3:
			Ver_Historial();
			break;
		}
	}

	public static void Ver_Historial()
	{
		int ia1, ia2, dim, tam1, tam2, posx1, posx2, posy1, posy2, prof1, prof2, resol1, resol2;
		int valores[] = new int[7];
		valores = partida.ValoresIniciales();
		dim = valores[0];
		tam1 = valores[1];
		tam2 = valores[2];
		posx1 = valores[3];
		posy1 = valores[4];
		posx2 = valores[5];
		posy2 = valores[6];
		ia1 = valores[7];
		prof1 = valores[8];
		resol1 = valores[9];
		ia2 = valores[10];
		prof2 = valores[11];
		resol2 = valores[12];
		MQ_Juego juego = new MQ_Juego(dim, ia1, ia2, tam1, tam2, prof1, prof2, resol1, resol2, posx1, posy1, posx2, posy2, 0);
		for(int i=0; i<partida.NumeroJugadas(); i++)
		{
			juego.Juega_Jugada(partida.ObtenerJugada(i));
			juego.Imprime();
		}
	}

	public static void Modo_2IA(boolean cargado)
	{
		int ia1, ia2, dim, tam1, tam2, posx1, posx2, posy1, posy2, prof1, prof2, resol1, resol2;
		Scanner sc = new Scanner(System.in);
		String ruta;
		if(!cargado)
		{
			System.out.print("\nPor favor, El tamaño del mapa: ");
			dim = sc.nextInt();
			while(true)
			{
				System.out.print("Por favor, escoja la posición X de la reina del jugador 1: ");
				posy1 = sc.nextInt();
				System.out.print("Por favor, escoja la posición Y de la reina del jugador 1: ");
				posx1 = sc.nextInt();
				if((posy1<0)||(posy1>=dim)||(posx1<0)||(posx1>=dim))
				{
					System.out.print("La posición indicada está fuera de rango\n");
					continue;
				}
				break;
			}
			System.out.print("Por favor, escoja la pila de la reina para el jugador 1: ");
			tam1 = sc.nextInt();
			while(true)
			{
				System.out.print("Por favor, escoja la posición X de la reina del jugador 2: ");
				posy2 = sc.nextInt();
				System.out.print("Por favor, escoja la posición Y de la reina del jugador 2: ");
				posx2 = sc.nextInt();
				if((posy2<0)||(posy2>=dim)||(posx2<0)||(posx2>=dim))
				{
					System.out.print("La posición indicada está fuera de rango\n");
					continue;
				}
				break;
			}
			System.out.print("Por favor, escoja la pila de la reina para el jugador 2: ");
			tam2 = sc.nextInt();
			System.out.print("Por favor, escoja heurística para el jugador 1: ");
			ia1 = sc.nextInt();
			System.out.print("Por favor, escoja la profundidad de la heurística para el jugador 1: ");
			prof1 = sc.nextInt();
			System.out.print("Por favor, escoja el tipo de resolución del árbol del jugador 1 (MINIMAX = 0, ALFA-BETA = 1): ");
			resol1 = sc.nextInt();
			System.out.print("Por favor, escoja heurística para el jugador 2: ");
			ia2 = sc.nextInt();
			System.out.print("Por favor, escoja la profundidad de la heurística para el jugador 2: ");
			prof2 = sc.nextInt();
			System.out.print("Por favor, escoja el tipo de resolución del árbol del jugador 2 (MINIMAX = 0, ALFA-BETA = 1): ");
			resol2 = sc.nextInt();
			System.out.print("Por favor, indique el nombre del fichero de juego: ");
			ruta = sc.next();
			partida.Set_Ruta(ruta);

			int valores[] = new int[13];
			valores[0] = dim;
			valores[1] = tam1;
			valores[2] = tam2;
			valores[3] = posx1;
			valores[4] = posy1;
			valores[5] = posx2;
			valores[6] = posy2;
			valores[7] = ia1;
			valores[8] = prof1;
			valores[9] = resol1;
			valores[10] = ia2;
			valores[11] = prof2;
			valores[12] = resol2;
			partida.SetValoresIniciales(valores);
			partida.Salva_Partida();
		}
		else
		{
			int valores[] = new int[7];
			valores = partida.ValoresIniciales();
			dim = valores[0];
			tam1 = valores[1];
			tam2 = valores[2];
			posx1 = valores[3];
			posy1 = valores[4];
			posx2 = valores[5];
			posy2 = valores[6];
			ia1 = valores[7];
			prof1 = valores[8];
			resol1 = valores[9];
			ia2 = valores[10];
			prof2 = valores[11];
			resol2 = valores[12];
			ruta = partida.Get_ruta();
		}
		MQ_Juego juego = new MQ_Juego(dim, ia1, ia2, tam1, tam2, prof1, prof2, resol1, resol2, posx1, posy1, posx2, posy2, 0);
		if(cargado)
		{
			for(int i=0; i<partida.NumeroJugadas(); i++)
				juego.Juega_Jugada(partida.ObtenerJugada(i));
		}
		juego.Imprime();
		while(true)
		{
			juego.Juega(0, partida);
			juego.Imprime();
			int fin = juego.CompruebaFin();
			if(fin==1)
			{
				System.out.print("El Jugador 1 ha ganado");
				partida.Salva_Partida();
				return;
			}
			juego.Juega(1, partida);
			juego.Imprime();
			fin = juego.CompruebaFin();
			if(fin==-1)
			{
				System.out.print("El Jugador 2 ha ganado");
				partida.Salva_Partida();
				return;
			}
			partida.Salva_Partida();
		}
	}

	public static void Modo_1IA(boolean cargado)
	{
		int ia1, dim, tam1, tam2, posx1, posx2, posy1, posy2, prof1, resol1;
		MQ_Juego juego;
		String ruta;
		Scanner sc = new Scanner(System.in);
		if(!cargado)
		{
			System.out.print("\nPor favor, escoja el tamaño del mapa: ");
			dim = sc.nextInt();
			System.out.print("Por favor, escoja heurística para la máquina: ");
			ia1 = sc.nextInt();
			System.out.print("Por favor, escoja la profundidad de la heurística para la máquina: ");
			prof1 = sc.nextInt();
			System.out.print("Por favor, escoja el tipo de resolución del árbol de la máquina (MINIMAX = 0, ALFA-BETA = 1): ");
			resol1 = sc.nextInt();
			while(true)
			{
				System.out.print("Por favor, escoja la posición X de la reina de la máquina: ");
				posy1 = sc.nextInt();
				System.out.print("Por favor, escoja la posición Y de la reina de la máquina: ");
				posx1 = sc.nextInt();
				if((posy1<0)||(posy1>=dim)||(posx1<0)||(posx1>=dim))
				{
					System.out.print("La posición indicada está fuera de rango\n");
					continue;
				}
				break;
			}
			System.out.print("Por favor, escoja la pila de la reina para la máquina: ");
			tam1 = sc.nextInt();
			while(true)
			{
				System.out.print("Por favor, escoja la posición X de su reina: ");
				posy2 = sc.nextInt();
				System.out.print("Por favor, escoja la posición Y de su reina: ");
				posx2 = sc.nextInt();
				if((posy2<0)||(posy2>=dim)||(posx2<0)||(posx2>=dim))
				{
					System.out.print("La posición indicada está fuera de rango\n");
					continue;
				}
				break;
			}
			System.out.print("Por favor, escoja la pila de su reina: ");
			tam2 = sc.nextInt();
			System.out.print("Por favor, indique el nombre del fichero de juego: ");
			ruta = sc.next();
			partida.Set_Ruta(ruta);

			int valores[] = new int[13];
			valores[0] = dim;
			valores[1] = tam1;
			valores[2] = tam2;
			valores[3] = posx1;
			valores[4] = posy1;
			valores[5] = posx2;
			valores[6] = posy2;
			valores[7] = ia1;
			valores[8] = prof1;
			valores[9] = resol1;
			valores[10] = 0;
			valores[11] = 1;
			valores[12] = 0;
			partida.SetValoresIniciales(valores);
			partida.Salva_Partida();
		}
		else
		{
			int valores[] = new int[7];
			valores = partida.ValoresIniciales();
			dim = valores[0];
			tam1 = valores[1];
			tam2 = valores[2];
			posx1 = valores[3];
			posy1 = valores[4];
			posx2 = valores[5];
			posy2 = valores[6];
			ia1 = valores[7];
			prof1 = valores[8];
			resol1 = valores[9];
			ruta = partida.Get_ruta();
		}
		juego = new MQ_Juego(dim, ia1, 0, tam1, tam2, prof1, 0, resol1, 0, posx1, posy1, posx2, posy2, 0);
		int opc;
		if(cargado)
		{
			for(int i=0; i<partida.NumeroJugadas(); i++)
				juego.Juega_Jugada(partida.ObtenerJugada(i));
			if(partida.NumeroJugadas()==0)
			{

				System.out.print("Por favor, indique quien empieza primero (USTED = 0, MÁQUINA = 1): ");
				opc = sc.nextInt();
			}
			else
			{
				opc = partida.NumeroJugadas()%2;
			}
		}
		else
		{
			System.out.print("Por favor, indique quien empieza primero (USTED = 0, MÁQUINA = 1): ");
			opc = sc.nextInt();
		}
		if(opc==0)
		{
			juego.Cambia_Jugador();
			juego.Imprime();
			while(true)
			{
				System.out.print("\nPor favor, indique la posición X de la ficha a mover: ");
				posx1 = sc.nextInt();
				System.out.print("\nPor favor, indique la posición Y de la ficha a mover: ");
				posy1 = sc.nextInt();
				if(juego.ObtenerFichaJugador(posx1, posy1)!=1)
				{
					System.out.print("\nLa ficha escogida no puede ser movida");
					continue;
				}
				System.out.print("\nPor favor, indique la posición X de la posición a mover: ");
				posy2 = sc.nextInt();
				System.out.print("\nPor favor, indique la posición Y de la posición a mover: ");
				posx2 = sc.nextInt();
				int ficha = juego.ObtenerFichaJugador(posx2, posy2);
				if(ficha==1)
				{
					System.out.print("\nLa ficha no puede ser movida a la posición escogida");
					continue;
				}
				MQ_Jugada jugada;
				if(ficha==1)
				{
					jugada = new MQ_Jugada(posx1, posx2, posy1, posy2, 0);
					if(!juego.Comprueba_Jugada(jugada))
					{
						System.out.print("\nLa ficha no puede ser movida a la posición escogida");
						continue;
					}
					juego.Juega_Jugada(jugada);
					partida.Inserta_Jugada(jugada);
				}
				if(ficha==-1)
				{
					jugada = new MQ_Jugada(posx1, posx2, posy1, posy2, 1);
					if(!juego.Comprueba_Jugada(jugada))
					{
						System.out.print("\nLa ficha no puede ser movida a la posición escogida");
						continue;
					}
					juego.Juega_Jugada(jugada);
					partida.Inserta_Jugada(jugada);
				}
				juego.Imprime();
				int fin = juego.CompruebaFin();
				if(fin==-1)
				{
					System.out.print("Felicidades, has ganado!");
					partida.Salva_Partida();
					return;
				}
				juego.Juega(0, partida);
				juego.Imprime();
				fin = juego.CompruebaFin();
				if(fin==1)
				{
					System.out.print("Ohhh, has perdido ... ");
					partida.Salva_Partida();
					return;
				}
				partida.Salva_Partida();
				ruta = partida.Get_ruta();
			}
		}
		else
		{
			juego.Imprime();
			while(true)
			{
				juego.Juega(0, partida);
				juego.Imprime();
				int fin = juego.CompruebaFin();
				if(fin==1)
				{
					System.out.print("La máquina ha ganado");
					partida.Salva_Partida();
					return;
				}
				MQ_Jugada jugada;
				while(true)
				{
					System.out.print("\nPor favor, indique la posición X de la ficha a mover: ");
					posy1 = sc.nextInt();
					System.out.print("\nPor favor, indique la posición Y de la ficha a mover: ");
					posx1 = sc.nextInt();
					if(juego.ObtenerFichaJugador(posx1, posy1)!=1)
					{
						System.out.print("\nLa ficha escogida no puede ser movida");
						continue;
					}
					System.out.print("\nPor favor, indique la posición X de la posición a mover: ");
					posy2 = sc.nextInt();
					System.out.print("\nPor favor, indique la posición Y de la posición a mover: ");
					posx2 = sc.nextInt();
					int ficha = juego.ObtenerFichaJugador(posx2, posy2);
					if(ficha==1)
					{
						System.out.print("\n1.La ficha no puede ser movida a la posición escogida");
						continue;
					}
					if(ficha==0)
					{
						jugada = new MQ_Jugada(posx1, posx2, posy1, posy2, 0);
						if(!juego.Comprueba_Jugada(jugada))
						{
							System.out.print("\n0.La ficha no puede ser movida a la posición escogida");
							continue;
						}
						juego.Juega_Jugada(jugada);
						partida.Inserta_Jugada(jugada);
					}
					if(ficha==-1)
					{
						jugada = new MQ_Jugada(posx1, posx2, posy1, posy2, 1);
						if(!juego.Comprueba_Jugada(jugada))
						{
							System.out.print("\n-1.La ficha no puede ser movida a la posición escogida");
							continue;
						}
						juego.Juega_Jugada(jugada);
						partida.Inserta_Jugada(jugada);
					}
					break;
				}
				juego.Imprime();
				fin = juego.CompruebaFin();
				if(fin==1)
				{
					System.out.print("Has ganado!");
					partida.Salva_Partida();
					return;
				}
			}
		}
	}

	public static void Modo_2Jug(boolean cargado)
	{
		int dim, tam1, tam2, posx1, posx2, posy1, posy2;
		String ruta;
		Scanner sc = new Scanner(System.in);
		if(!cargado)
		{
			System.out.print("\nPor favor, escoja el tamaño del mapa: ");
			dim = sc.nextInt();
			while(true)
			{
				System.out.print("Por favor, escoja la posición X de la reina del jugador 1: ");
				posy1 = sc.nextInt();
				System.out.print("Por favor, escoja la posición Y de la reina del jugador 1: ");
				posx1 = sc.nextInt();
				if((posy1<0)||(posy1>=dim)||(posx1<0)||(posx1>=dim))
				{
					System.out.print("La posición indicada está fuera de rango\n");
					continue;
				}
				break;
			}
			System.out.print("Por favor, escoja la pila de la reina del jugador 1: ");
			tam1 = sc.nextInt();
			while(true)
			{
				System.out.print("Por favor, escoja la posición X de la reina del jugador 2: ");
				posy2 = sc.nextInt();
				System.out.print("Por favor, escoja la posición Y de la reina del jugador 2: ");
				posx2 = sc.nextInt();
				if((posy2<0)||(posy2>=dim)||(posx2<0)||(posx2>=dim))
				{
					System.out.print("La posición indicada está fuera de rango\n");
					continue;
				}
				break;
			}
			System.out.print("Por favor, escoja la pila de la reina del jugador 2: ");
			tam2 = sc.nextInt();
			System.out.print("Por favor, indique el nombre del fichero de juego: ");
			ruta = sc.next();
			partida.Set_Ruta(ruta);

			int valores[] = new int[13];
			valores[0] = dim;
			valores[1] = tam1;
			valores[2] = tam2;
			valores[3] = posx1;
			valores[4] = posy1;
			valores[5] = posx2;
			valores[6] = posy2;
			valores[7] = 0;
			valores[8] = 1;
			valores[9] = 0;
			valores[10] = 0;
			valores[11] = 1;
			valores[12] = 0;
			partida.SetValoresIniciales(valores);
			partida.Salva_Partida();
		}
		else
		{
			int valores[] = new int[7];
			valores = partida.ValoresIniciales();
			dim = valores[0];
			tam1 = valores[1];
			tam2 = valores[2];
			posx1 = valores[3];
			posy1 = valores[4];
			posx2 = valores[5];
			posy2 = valores[6];
			ruta = partida.Get_ruta();
		}
		MQ_Juego juego = new MQ_Juego(dim, 0, 0, tam1, tam2, 0, 0, 0, 0, posx1, posy1, posx2, posy2, 0);
		juego.Imprime();
		while(true)
		{
			System.out.print("\nJugador 1: Por favor, indique la posición X de la ficha a mover: ");
			posy1 = sc.nextInt();
			System.out.print("\nJugador 1: Por favor, indique la posición Y de la ficha a mover: ");
			posx1 = sc.nextInt();
			if(juego.ObtenerFichaJugador(posx1, posy1)!=0)
			{
				System.out.print("\nJugador 1: La ficha escogida no puede ser movida");
				continue;
			}
			System.out.print("\nJugador 1: Por favor, indique la posición X de la posición a mover: ");
			posy2 = sc.nextInt();
			System.out.print("\nJugador 1: Por favor, indique la posición Y de la posición a mover: ");
			posx2 = sc.nextInt();
			int ficha = juego.ObtenerFichaJugador(posx2, posy2);
			if(ficha==0)
			{
				System.out.print("\nJugador 1: La ficha no puede ser movida a la posición escogida");
				continue;
			}
			MQ_Jugada jugada;
			if(ficha==1)
			{
				jugada = new MQ_Jugada(posx1, posx2, posy1, posy2, 0);
				if(!juego.Comprueba_Jugada(jugada))
				{
					System.out.print("\nJugador 1: La ficha no puede ser movida a la posición escogida");
					continue;
				}
				juego.Juega_Jugada(jugada);
				partida.Inserta_Jugada(jugada);
			}
			if(ficha==-1)
			{
				jugada = new MQ_Jugada(posx1, posx2, posy1, posy2, 1);
				if(!juego.Comprueba_Jugada(jugada))
				{
					System.out.print("\nJugador 1: La ficha no puede ser movida a la posición escogida");
					continue;
				}
				juego.Juega_Jugada(jugada);
				partida.Inserta_Jugada(jugada);
			}
			if(ficha==-10)
			{
				System.out.print("\nLa posicion indicada está fuera de rango.");
				continue;
			}
			juego.Imprime();
			int fin = juego.CompruebaFin();
			if(fin==1)
			{
				System.out.print("Ha ganado el jugador 1");
				partida.Salva_Partida();
				return;
			}
			while(true)
			{
				System.out.print("\nJugador 2: Por favor, indique la posición X de la ficha a mover: ");
				posy1 = sc.nextInt();
				System.out.print("\nJugador 2: Por favor, indique la posición Y de la ficha a mover: ");
				posx1 = sc.nextInt();
				if(juego.ObtenerFichaJugador(posx1, posy1)!=1)
				{
					System.out.print("\nJugador 2: La ficha escogida no puede ser movida");
					continue;
				}
				System.out.print("\nJugador 2: Por favor, indique la posición X de la posición a mover: ");
				posy2 = sc.nextInt();
				System.out.print("\nJugador 2: Por favor, indique la posición Y de la posición a mover: ");
				posx2 = sc.nextInt();
				ficha = juego.ObtenerFichaJugador(posx2, posy2);
				if(ficha==1)
				{
					System.out.print("\n0. Jugador 2: La ficha no puede ser movida a la posición escogida");
					continue;
				}
				MQ_Jugada jugada2;
				if(ficha==-1)
				{
					jugada2 = new MQ_Jugada(posx1, posx2, posy1, posy2, 1);
					if(!juego.Comprueba_Jugada(jugada2))
					{
						System.out.print("\n1. Jugador 2: La ficha no puede ser movida a la posición escogida");
						continue;
					}
					juego.Juega_Jugada(jugada2);
					partida.Inserta_Jugada(jugada2);
				}
				if(ficha==0)
				{
					jugada2 = new MQ_Jugada(posx1, posx2, posy1, posy2, 0);
					if(!juego.Comprueba_Jugada(jugada2))
					{
						System.out.print("\n-1. Jugador 2: La ficha no puede ser movida a la posición escogida");
						continue;
					}
					juego.Juega_Jugada(jugada2);
					partida.Inserta_Jugada(jugada2);
				}
				juego.Imprime();
				fin = juego.CompruebaFin();
				if(fin==-1)
				{
					System.out.print("Ha ganado el jugador 2");
					partida.Salva_Partida();
					return;
				}
				break;
			}
			partida.Salva_Partida();
		}
	}
}
