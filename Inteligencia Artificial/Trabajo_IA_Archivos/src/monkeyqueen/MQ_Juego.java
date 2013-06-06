package monkeyqueen;

import java.util.ArrayList;
import java.util.List;

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta clase se encarga de manejar el flujo de juego,   *
	 * obteniendo las distintas jugadas y calculando el      *
	 * estado actual de cada fase de juego.                  *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

public class MQ_Juego 
{
	private MQ_CampoJuego campo;
	private int prof1;
	private int prof2;
	private int heuristica1;
	private int heuristica2;
	private int tiporesol1;
	private int tiporesol2;
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta es la funci—n que inicializa el juego.			   *
	 * Parametros:											   *
	 * 	mapa[][]: mapa inicial del juego					   *
	 *  dim: dimensi—n del cuadrado de juego				   *
	 *  nuevo: si el mapa ya esta definidio	(1 == si)		   *
	 *  tamX: tama–o de la pila de la reina X				   *
	 *  profuX: profundidad a la que puede bajar el jugador X  *
	 *  heurX: heuristica que utilizara el jugador X		   *
	 *  aiX: Si el jugador es humano (0) o m‡quina (1)		   *
	 *  resolX: tipo de resolucion del arbol expandido		   *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	public MQ_Juego(int[][] mapa, int dim, int nuevo, int tam1, int profu1, int heur1, int resol1,
													  int tam2, int profu2, int heur2, int resol2)
	{
		if(nuevo==1)
			campo = new MQ_CampoJuego(mapa, dim);
		else
			campo = new MQ_CampoJuego(dim, dim/2, 0, tam1, (dim/2)+1, dim-1, tam2);
		prof1 = profu1;
		prof2 = profu2;
		heuristica1 = heur1;
		heuristica2 = heur2;
		tiporesol1 = resol1;
		tiporesol2 = resol2;
	}

	public MQ_Juego(int dim, int ia1, int ia2, int tam1, int tam2, int profu1, int profu2, int resol1, int resol2, 
					int posx1, int posy1, int posx2, int posy2, int jugador)
	{
		campo = new MQ_CampoJuego(dim, posx1, posy1, tam1, posx2, posy2, tam2);
		prof1 = profu1;
		prof2 = profu2;
		heuristica1 = ia1;
		heuristica2 = ia2;
		tiporesol1 = resol1;
		tiporesol2 = resol2;
		if(jugador==1)
			campo.Cambia_Jugador();
	}
	
	public void Imprime()
	{
		campo.Imprime_CampoJuego();
	}
	
	public int ObtenerFichaJugador(int x, int y)
	{
		int tam = campo.Devuelve_Dimension();
		if((x>tam)||(x<0)||(y>tam)||(y<0))
			return -10;
		int m = campo.Devuelve_Valor(x, y);
		if(m<0)
			return 1;
		else
		{
			if(m>0)
				return 0;
			else
				return -1;
		}
	}
	
	public boolean Fin_ganador()
	{
		if((campo.Devuelve_PosXReina2()==-1)&&(campo.Devuelve_PosYReina2()==-1))
			return true;
		return false;
	}
	
	public boolean Fin_perdedor()
	{
		if((campo.Devuelve_PosXReina1()==-1)&&(campo.Devuelve_PosYReina1()==-1))
			return true;
		return false;
	}
	
	public int CompruebaFin()
	{
		if(Fin_ganador())
			return 1;
		if(Fin_perdedor())
			return -1;
		return 0;
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta funcion lleva a cabo todas las comprobaciones    *
	 * y llamadas pertinentes para cada jugada automatica.	 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public void Juega(int jugador, MQ_Partida partida)
	{
		List<MQ_Jugada> posibles = new ArrayList<MQ_Jugada>();;
		int valor;
		if(jugador == 0)
			valor = 1;
		else
			valor = -1;
		int tam = campo.Devuelve_Dimension();
		for(int i=0; i<tam; i++)
		{
			for(int j=0; j<tam; j++)
			{
				if(campo.Devuelve_Valor(i, j)*valor>0)
				{
					posibles.addAll(Posibles_Jugadas(i, j, campo));
				}
			}
		}
		if(posibles.size()==0)
		{
			campo.tablas = true;
			return;
		}
		MQ_Jugada jugada = Mejor_Jugada(posibles, jugador);
		campo.Hacer_Jugada(jugada);
		partida.Inserta_Jugada(jugada);
		campo.Cambia_Jugador();
		return;
	}
	
	public boolean Comprueba_Jugada(MQ_Jugada jugada)
	{
		return campo.Validar_Movimiento(jugada.Pos_x1_JUG1, jugada.Pos_y1_JUG1, jugada.Pos_x2_JUG1, jugada.Pos_y2_JUG1, jugada.Acc_JUG1);
	}
	
	public void Juega_Jugada(MQ_Jugada jugada)
	{
		campo.Hacer_Jugada(jugada);
		campo.Cambia_Jugador();
	}
	
	public void Cambia_Jugador()
	{
		campo.Cambia_Jugador();
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta funcion devuelve todas las posibles jugadas de la  *
	 * ficha actual con el jugador actual, comprobando que las * 
	 * restricciones del juego se cumplan.                     *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public List<MQ_Jugada> Posibles_Jugadas(int x1, int y1, MQ_CampoJuego campodejuego)
	{
		List<MQ_Jugada> posibles = new ArrayList<MQ_Jugada>();
		int tam = campodejuego.Devuelve_Dimension();
		for(int i=0; i<tam; i++)
		{
			for(int j=0; j<tam; j++)
			{
				if((x1==i)&&(y1==j))
				{
					continue;
				}
				if(campodejuego.Conectados(x1, y1, i, j))
				{
					int xa = campodejuego.Devuelve_Valor(x1, y1);
					int xb = campodejuego.Devuelve_Valor(i, j);
					if((xa*xb>0)) // -x*-x == x*x != -x*x
					{
						continue;
					}
					else
					{
						MQ_Jugada jugada;
						if(xb!=0)
						{
							if(!(campo.Validar_Movimiento(x1, y1, i, j, 0)))
							{
								continue;
							}
							jugada = new MQ_Jugada(x1, i, y1, j, 0);
						}
						else
						{
							if(!(campo.Validar_Movimiento(x1, y1, i, j, 1)))
							{
								continue;
							}
							jugada = new MQ_Jugada(x1, i, y1, j, 1);
						}
						posibles.add(jugada);
					}
				}
			}
		}
		return posibles;
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta funcion devuelve la jugada que minimice la       *
	 * heur’stica, es decir, que tienda a vencer al enemigo  *
	 * en funci—n a la heuristica escogida.					 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public boolean Empatado()
	{
		return campo.tablas;
	}
	
	public MQ_Jugada Mejor_Jugada(List<MQ_Jugada> todas, int jugador)
	{
		if(todas.size()==0)
		{
			return null;
		}
		int profundidad = (jugador == 0) ? prof1 : prof2;
		if(profundidad==0)
		{
			return todas.get((int) (Math.random()%todas.size()));
		}
		for(int i=0; i<todas.size(); i++)
		{
			MQ_CampoJuego aux = new MQ_CampoJuego(campo);
			aux.Hacer_Jugada(todas.get(i));
			MQ_Heuristica heuris = new MQ_Heuristica();
			float k;
			if(jugador==0)
				k = heuris.getHeuristicValue(aux, heuristica1, jugador);
			else
				k = heuris.getHeuristicValue(aux, heuristica2, jugador);
			if(k==10000000)
				return todas.get(i);
			if(k==-1000000)
			{
				/*
				 * ATENCION !!! EN CASO DE NO HABER MOVIMIENTO POSIBLE SE USA EL òLTIMO
				 */
				if(todas.size()>1)
				{
					todas.remove(i);
					i--;
				}
				continue;
			}
		}
		int resol = (jugador == 0) ? tiporesol1 : tiporesol2;
		int herencias[][][] = new int[profundidad][570][19000]; // <-- faltan los valores de los ’ndices
		for(int i=0; i<todas.size(); i++)
			herencias[0][0][i] = 1;
		int i=1;	
		int valor = (jugador == 0) ? 1 : -1;
		List<MQ_Jugada> posibles = todas;
		MQ_CampoJuego camposheredados[][] = new MQ_CampoJuego[profundidad][570];// <-- falta el valor del ’ndice
		int hijazos[] = new int[profundidad];
		MQ_CampoJuego campojuego = new MQ_CampoJuego(campo);
		int total = todas.size();
		hijazos[0] = total;
		// Bucle que lleva a cabo la obtenci—n del vector base del ‡rbol
		while(i<profundidad)
		{
			List<MQ_Jugada> auxiliar = new ArrayList<MQ_Jugada>();
			int numaux = 0;
			for(int j=0; j<posibles.size(); j++)
			{
				MQ_CampoJuego aux = new MQ_CampoJuego(campojuego);
				aux.Hacer_Jugada(posibles.get(j));
				MQ_CampoJuego campoaux = new MQ_CampoJuego(aux);
				for(int k=0; k<campoaux.Devuelve_Dimension(); k++)
				{
					for(int l=0; l<campoaux.Devuelve_Dimension(); l++)
					{
						herencias[i][j][auxiliar.size()] = 0;
						if(campoaux.Devuelve_Valor(k, l)*valor>0)
						{
							int naux = auxiliar.size();
							auxiliar.addAll(Posibles_Jugadas(k, l, campoaux));
							if(auxiliar.size()!=0)
							{
								for(; naux<auxiliar.size(); naux++)
								{
									herencias[i][j][naux-numaux] = 1;
								}
							}
						}
					}
				}
				numaux = auxiliar.size();
				camposheredados[i][j] = campoaux;
			}
			hijazos[i] = auxiliar.size();
			posibles = auxiliar;
			valor *= -1;
			i++;
		}
		// Creamos el vector con las heur’sticas de la base del ‡rbol
		float valoresh[] = new float[posibles.size()+1];
		int padresherencia = (profundidad == 1) ? 0 : hijazos[profundidad-2];
		int j=0;
		for(i=0; i<padresherencia; i++)
		{
			int k=0;
			while(herencias[profundidad-1][i][k]!=0)
			{
				MQ_Heuristica heuris = new MQ_Heuristica();
				MQ_CampoJuego aux = new MQ_CampoJuego(camposheredados[profundidad-1][i]);
				aux.Hacer_Jugada(posibles.get(j));
				if(campo.Devuelve_Jugador()==0)
					valoresh[j] = heuris.getHeuristicValue(aux, heuristica1, jugador);
				else
					valoresh[j] = heuris.getHeuristicValue(aux, heuristica2, jugador);
				j++;
				k++;
			}
		}
		// Subimos por el ‡rbol, llevando a cabo la estrategia definida (minimax o alfa-beta)
		
		/*
		 * MINIMAX
		 */
		int finalista = 0;
		if(resol == 0)
		{
			total = posibles.size();
			for(i=profundidad-2; i>=0; i--)
			{
				for(j=0; j<hijazos[i]; j++)
				{
					int k=0;
					float bueno = (i%2==0) ? -1000000 : 1000000;
					int m=0;
					while(herencias[i][j][k]==1)
					{
						if(i%2==1) // Es impar -> minimizamos
						{
							if(valoresh[m]<bueno)
							{
								bueno = valoresh[m];
								finalista = m;
							}
							else
							{
								if(valoresh[m]==bueno)
								{
									if(Math.random()%2==0)
									{
										bueno = valoresh[m];
										finalista = m;
									}	
								}
							}
						}
						else // es par -> maximizamos
						{
							if(valoresh[m]>bueno)
							{
								bueno = valoresh[m];
								finalista = m;
							}
							else
							{
								if(valoresh[m]==bueno)
								{
									if(Math.random()%2==0)
									{
										bueno = valoresh[m];
										finalista = m;
									}	
								}
							}
						}
						m++;
						k++;
					}
					valoresh[j] = bueno;
				}
			}
		}
		
		/*
		 * ALFABETA
		 */
		if(resol == 1)
		{
			int[] inicio = new int[profundidad];
			for(i=0; i<profundidad; i++)
				inicio[i] = 0;
			finalista = (int)alpha_beta(herencias, hijazos, valoresh, 0, 0, profundidad, -10000000, 1000000, true, inicio);
		}
		return todas.get(finalista);
	}
	
	public float alpha_beta(int[][][] herencias, int hijazos[], float[] heuristicas, int prof_actual, int hijo_actual, 
							int profundidad, float alpha, float beta, boolean padre, int[] vinicio)
	{
		float var;
		if(profundidad==prof_actual||padre==false) // Nodo hoja
		{
			var = heuristicas[0];
			return var;
		}
		if(profundidad==prof_actual+1) // Nodo padre final
		{
			int finalista = 0;
			for(int i=0; i<hijazos[0]; i++)
			{
				float[] h = new float[1];
				h[0] = heuristicas[i];
				var = alpha_beta(herencias, hijazos, h, prof_actual+1, i, profundidad, alpha, beta, false, vinicio);
				if(prof_actual%2==0)
				{
					if(alpha<var)
					{
						alpha = var;
						finalista = i;
					}
					else
						if(alpha==var)
							if(Math.random()%2==1)
							{
								alpha = var;
								finalista = i;
							}
					if(alpha>=beta)
					{
						if(prof_actual == 0)
						{
							return finalista;
						}
						return alpha;
					}
				}
				else
				{
					if(beta>var)
					{
						beta = var;
						finalista = i;
					}
					else
						if(beta==var)
							if(Math.random()%2==1)
							{
								beta = var;
								finalista = i;
							}
					if(alpha>=beta)
					{
						if(prof_actual == 0)
						{
							return finalista;
						}
						return beta;
					}
				}
			}
			if(prof_actual == 0)
			{
				return finalista;
			}
			if(prof_actual%2==0)
			{
				return alpha;
			}
			else
			{
				return beta;
			}
		}
		
		int[] inicio0 = new int[profundidad-prof_actual];
		inicio0 = vinicio;
		int finalista = 0;
		for(int m = 0; m<hijazos[0]; m++)
		{
			int[] inicio = new int[profundidad-prof_actual];
			for(int i=0; i<profundidad-prof_actual; i++)
				inicio[i] = inicio0[i];
			int[] hijos = new int[profundidad-prof_actual];
			int numpadritos = 1;
			for(int i=prof_actual+1; i<profundidad; i++)
			{
				int padrito = vinicio[i];
				int num = 0;
				for(int n=padrito; n<numpadritos; n++)
				{
					int k=0;
					while(herencias[i][inicio0[i]+n][k]==1&&k<hijazos[i-prof_actual])
					{
						num++;
						k++;
					}
				}
				numpadritos = num;
				inicio[i-prof_actual] += numpadritos+1;
				hijos[i-prof_actual-1] = numpadritos+1;
				padrito = inicio0[i-prof_actual];
			}
			float[] heuristics = new float[inicio[profundidad-prof_actual-1]-inicio0[profundidad-prof_actual-1]];
			for(int i=inicio0[profundidad-prof_actual-1]; i<inicio[profundidad-prof_actual-1]; i++)
			{
				heuristics[i-inicio0[profundidad-prof_actual-1]] = heuristicas[i];
			}
			if(profundidad-prof_actual==1)
				var = alpha_beta(herencias, hijos, heuristics, prof_actual+1, m, profundidad, alpha, beta, false, inicio);
			else
				var = alpha_beta(herencias, hijos, heuristics, prof_actual+1, m, profundidad, alpha, beta, true, inicio);
			if(prof_actual%2==0)
			{
				if(alpha<var)
				{
					alpha = var;
					finalista = m;
				}
				else
					if(alpha==var)
						if(Math.random()%2==1)
						{
							alpha = var;
							finalista = m;
						}
				if(alpha>=beta)
				{
					if(prof_actual == 0)
					{
						return finalista;
					}
					return alpha;
				}
			}
			else
			{
				if(beta>var)
				{
					beta = var;
					finalista = m;
				}
				else
					if(beta==var)
						if(Math.random()%2==1)
						{
							beta = var;
							finalista = m;
						}
				if(alpha>=beta)
				{
					if(prof_actual == 0)
					{
						return finalista;
					}
					return beta;
				}
			}
			inicio0 = inicio;
		}
		if(prof_actual == 0)
		{
			return finalista;
		}
		if(prof_actual%2==0)
		{
			return alpha;
		}
		else
		{
			return beta;
		}
	}
}
