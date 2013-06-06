package monkeyqueen;

import java.lang.Math;


	/* * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta clase define el campo de juego y establece   *
	 * el sistema de impresi—n por pantalla.             *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * */

public class MQ_CampoJuego
{
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Las variables del campo de juego son:                 *
	 * 		- Tam: Tama–o de la matriz (tam*tam)             *
	 * 		- pos(x,y)Reina1: Posici—n de la Reina 1         *
	 * 		- pos(x,y)Reina2: Posici—n de la Reina 2         * 
	 * 		- mapa: representaci—n matricial del campo       *
	 * 				de juego. Las piezas del jugador 1       *
	 * 				se representar‡n en positivo y las       *
	 * 				del jugador 2 en negativo. Las reinas    *
	 * 				se representar‡n con la cantidad de      *
	 * 				fichas que disponen.                     *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	private int tam;
	private int posxReina1;
	private int posyReina1;
	private int posxReina2;
	private int posyReina2;
	private int mapa[][];
	private int jugador;
	public boolean tablas;

	public MQ_CampoJuego(int tamano, int xR1, int yR1, int tam1, int xR2, int yR2, int tam2)
	{
		tam = tamano;
		mapa = new int[tam][tam];
		for(int i=0; i<tam; i++)
			for(int j=0; j<tam; j++)
				mapa[i][j] = 0;
		posxReina1 = xR1;
		posyReina1 = yR1;
		posxReina2 = xR2;
		posyReina2 = yR2;
		mapa[posxReina1][posyReina1] = tam1;
		mapa[posxReina2][posyReina2] = tam2*-1;
		jugador = 0;
		tablas = false;
	}
	
	public MQ_CampoJuego(int[][] map, int tamano)
	{
		tam = tamano;
		mapa = new int[tam][tam];
		for(int i=0; i<tam; i++)
		{
			for(int j=0; j<tam; j++)
			{
				mapa[i][j] = map[i][j];
				if(Math.abs(mapa[i][j])>1)
				{
					if(mapa[i][j]<0)
					{
						posxReina2 = i;
						posyReina2 = j;
					}
					else
					{
						posxReina1 = i;
						posyReina1 = j;
					}
				}
			}
		}
		tablas = false;
	}
	
	public MQ_CampoJuego(MQ_CampoJuego campo)
	{
		tam = campo.Devuelve_Dimension();
		posxReina1 = campo.Devuelve_PosXReina1();
		posyReina1 = campo.Devuelve_PosYReina1();
		posxReina2 = campo.Devuelve_PosXReina2();
		posyReina2 = campo.Devuelve_PosYReina2();
		mapa = new int[tam][tam];
		for(int i=0; i<tam; i++)
			for(int j=0; j<tam; j++)
				mapa[i][j] = campo.Devuelve_Valor(i, j);
		jugador = campo.Devuelve_Jugador();
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta funci—n comprueba si la ficha enemiga objetivo     *
	 * est‡ a tiro, es decir, si ambas fichas est‡n alineadas  *
	 * y si no hay ninguna otra ficha que obstaculice el       *
	 * ataque  	.				                               *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	public boolean Conectados(int x1, int y1, int x2, int y2)
	{
		if(x1 == x2)
		{
			if(y1==y2+1||y1==y2-1)
				return true;
			int alpha;
			if(y1<y2)
				alpha = 1;
			else
				alpha = -1;
			for(int i=alpha;  Math.abs(i)<Math.abs(y2-y1); i+= alpha)
			{
				if(mapa[x1][y1+i]!=0)
					return false;
			}
			return true;
		}
		else
		{
			if(y1 == y2)
			{
				if(x1==x2+1||x1==x2-1)
					return true;
				int alpha;
				if(x1<x2)
					alpha = 1;
				else
					alpha = -1;
				for(int i=alpha; Math.abs(i)<Math.abs(x2-x1); i+= alpha)
				{
					if(mapa[x1+i][y1]!=0)
						return false;
				}
				return true;	
			}
			else
			{
				if(Math.abs((x2-x1)/(float)(y2-y1))!=1)
					return false;
				int alphax;
				int alphay;
				if(x1<x2)
					alphax = 1;
				else
					alphax = -1;
				if(y1<y2)
					alphay = 1;
				else
					alphay = -1;
				int i, j;
				for(i=x1+alphax, j=y1+alphay; Math.abs(i)<Math.abs(x2-x1)&&Math.abs(j)<Math.abs(y2-y1)&&i>=0&&j>=0&&j<tam&&i<tam; i+= alphax, j+= alphay)
				{
					if(mapa[i][j]!=0)
						return false;
				}
				if(i<0||j<0||i>tam||j>tam)
					return false;
				return true;
			}
		}
	}

	public boolean Validar_Movimiento(int x1, int y1, int x2, int y2, int acc)
	{
		if((x1>tam)||(x2>tam)||(y1>tam)||(y2>tam)||(x1<0)||(x2<0)||(y1<0)||(y2<0))
			return false;
		if(mapa[x1][y1]==0)
		{
			return false;
		}
		if(!Conectados(x1, y1, x2, y2))
		{
			return false;
		}
		if(mapa[x1][y1]*mapa[x2][y2]>0)
		{
			return false;
		}
		if(mapa[x1][y1]==1)
		{
			if(Math.sqrt((posxReina2-x1)*(posxReina2-x1)+(posyReina2-y1)*(posyReina2-y1))>=Math.sqrt((posxReina2-x2)*(posxReina2-x2)+(posyReina2-y2)*(posyReina2-y2)))
			{
				return true;
			}
		}
		if(mapa[x1][y1]==-1)
		{
			if(Math.sqrt((posxReina1-x1)*(posxReina1-x1)+(posyReina1-y1)*(posyReina1-y1))>=Math.sqrt((posxReina1-x2)*(posxReina1-x2)+(posyReina1-y2)*(posyReina1-y2)))
			{
				return true;
			}
		}
		if((Math.abs(mapa[x1][y1])>2)||(acc==0))
			return true;
		return false;
	}
	
	public int Devuelve_Dimension()
	{
		return tam;
	}
	
	public int Devuelve_Jugador()
	{
		return jugador;
	}
	
	public void Cambia_Jugador()
	{
		jugador = 1-jugador;
	}
	
	public int Devuelve_PosXReina1()
	{
		return posxReina1;
	}
	
	public int Devuelve_PosYReina1()
	{
		return posyReina1;
	}
	
	public int Devuelve_PosXReina2()
	{
		return posxReina2;
	}
	
	public int Devuelve_PosYReina2()
	{
		return posyReina2;
	}
	
	public int Devuelve_Valor(int x, int y)
	{
		return mapa[x][y];
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta funci—n muestra por pantalla el campo de juego,  *
	 * representando con un # un mono del jugador 1 y @ un   *
	 * mono del jugador 2, adem‡s de reprentar a las reinas  *
	 * N* y N¼, respectivamente                              *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public void Imprime_CampoJuego()
	{
		System.out.print("\n   |");
		for(int i=0; i<tam; i++)
		{
			if(i<10)
				System.out.format(" %d |", i);
			else
				System.out.format(" %d|", i);
		}
		for(int i=0; i<tam; i++)
		{
			if(i<10)
				System.out.format("\n %d |", i);
			else
				System.out.format("\n %d|", i);
			for(int j=0; j<tam; j++)
			{
				if(mapa[i][j]<0)
				{
					if(mapa[i][j] == -1)
						System.out.print(" $ ");
					else
					{
						if(Math.abs(mapa[i][j])<10)
							System.out.format(" %d¼",Math.abs(mapa[i][j]));
						else
							System.out.format("%d¼",Math.abs(mapa[i][j]));
					}
				}
				else
				{
					if(mapa[i][j]>0)
					{
						if(mapa[i][j] == 1)
							System.out.print(" # ");
						else
						{
							if(Math.abs(mapa[i][j])<10)
								System.out.format(" %d*",Math.abs(mapa[i][j]));
							else
								System.out.format("%d*",Math.abs(mapa[i][j]));
						}
					}
					else
					{
						System.out.print(" 0 ");
					}
				}
				System.out.print("|");
			}
		}
		System.out.print("\n");
		System.out.print("\n");
		System.out.print("\n");
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * *
	 *  Esta funci—n lleva a cabo la jugada solicitada,  *
	 *  modificando el mapa de juego y las variables     *
	 *  internas, adem‡s de cambiar de jugador.			 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * */

	public void Hacer_Jugada(MQ_Jugada state)
	{
		MQ_Jugada jugada = state;
		int valor;
		int reina;
		if(jugador == 0)
			valor = -1;
		else
			valor = 1;
		if((jugada.Pos_x2_JUG1==posxReina1)&&(jugada.Pos_y2_JUG1==posyReina1))
		{
			posxReina1=-1;
			posyReina1=-1;
		}
		if((jugada.Pos_x2_JUG1==posxReina2)&&(jugada.Pos_y2_JUG1==posyReina2))
		{
			posxReina2=-1;
			posyReina2=-1;
		}
		if(Math.abs(mapa[jugada.Pos_x1_JUG1][jugada.Pos_y1_JUG1])>1)
		{
			reina = mapa[jugada.Pos_x1_JUG1][jugada.Pos_y1_JUG1];
			if(jugada.Acc_JUG1==1)
			{
				mapa[jugada.Pos_x1_JUG1][jugada.Pos_y1_JUG1] = -valor;
				mapa[jugada.Pos_x2_JUG1][jugada.Pos_y2_JUG1] = reina+valor;
			}
			else
			{
				mapa[jugada.Pos_x1_JUG1][jugada.Pos_y1_JUG1] = 0;
				mapa[jugada.Pos_x2_JUG1][jugada.Pos_y2_JUG1] = reina;
			}
			if(jugador==0)
			{
				posxReina1=jugada.Pos_x2_JUG1;
				posyReina1=jugada.Pos_y2_JUG1;
			}
			else
			{
				posxReina2=jugada.Pos_x2_JUG1;
				posyReina2=jugada.Pos_y2_JUG1;
			}
		}
		else
		{
			if(Math.abs(mapa[jugada.Pos_x1_JUG1][jugada.Pos_y1_JUG1])==1)
			{
				mapa[jugada.Pos_x1_JUG1][jugada.Pos_y1_JUG1] = 0;
				mapa[jugada.Pos_x2_JUG1][jugada.Pos_y2_JUG1] = -valor;
			}
		}
		return;
	}
}
