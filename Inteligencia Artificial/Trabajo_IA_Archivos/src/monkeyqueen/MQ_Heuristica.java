package monkeyqueen;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Esta clase se encarga de manejar las cuatro distintas heur’sticas.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

public class MQ_Heuristica
{
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	 * 																		 *
	 * Funci—n que se encarga de manejar las heur’sticas					 *
	 * 																		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	public float getHeuristicValue (MQ_CampoJuego campo, int heuristica, int jugador)
	{
		if(heuristica==0)
			return (float)Math.random()%100-50;
		if(isGoalState(campo, jugador))
			return 10000000;
		if(isLooserState(campo, jugador))
			return -1000000;
		// Se env’a a la funci—n de heur’stica deseada heuristicaX()
		switch(heuristica)
		{
		case 1:
			return heuristica1(campo);
		case 2:
			return heuristica2(campo);
		case 3:
			return heuristica3(campo);
		case 4:
			return heuristica4(campo);
		default:
			return (float)Math.random()%100-50;
		}
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	 * Rodeamos a la reina enemiga:											 * 
	 * 																		 *
	 * (NMonos aliados - NMonos enemigos + 1)/Dist Med a la reina enemiga	 *
	 * 																		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public float heuristica1(Object state)
	{
		MQ_CampoJuego campo = (MQ_CampoJuego)state;
		int naliados = 0;
		int nenemi = 0;
		int dist = 0;
		int valor;
		int posxReina;
		int posyReina;
		if(campo.Devuelve_Jugador()==0)
		{
			posxReina = campo.Devuelve_PosXReina2();
			posyReina = campo.Devuelve_PosYReina2();
			valor = 1;
		}
		else
		{
			posxReina = campo.Devuelve_PosXReina1();
			posyReina = campo.Devuelve_PosYReina1();
			valor = -1;
		}
		for(int i=0; i<campo.Devuelve_Dimension(); i++)
		{
			for(int j=0; j<campo.Devuelve_Dimension(); j++)
			{
				int actual = campo.Devuelve_Valor(i, j)*valor;
				if(actual<0)
				{
					nenemi++;
				}
				if(actual>0)
				{
					naliados++;
					dist += Math.sqrt((i-posxReina)*(i-posxReina) + (j-posyReina)*(j-posyReina));
				}
			}
		}
		dist /= (float)naliados;
		if(naliados>3)
			return (naliados - nenemi + 1)/(float)dist;
		else
		{
			int posatac = 0;
			for(int i=0; i<campo.Devuelve_Dimension(); i++)
			{
				for(int j=0; j<campo.Devuelve_Dimension(); j++)
				{
					int actual = campo.Devuelve_Valor(i, j)*valor;
					if(actual<0)
					{
						if(campo.Conectados(i, j, posxReina, posyReina))
								posatac++;
					}
				}
			}
			if(posatac==0)
				return (naliados - nenemi + 1);
			return (naliados - nenemi + 1)/(float)posatac;
		}
	}

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	 * Evitamos cercos a la reina aliada:									 * 
	 * 																		 *
	 * (NMonos aliados - NMonos enemigos + 1)*Dist Med a la reina aliada	 *
	 * 																		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */	
	public float heuristica2(Object state)
	{
		MQ_CampoJuego campo = (MQ_CampoJuego)state;
		int naliados = 0;
		int nenemi = 0;
		int dist = 0;
		int valor;
		int posxReina;
		int posyReina;
		if(campo.Devuelve_Jugador()==0)
		{
			posxReina = campo.Devuelve_PosXReina1();
			posyReina = campo.Devuelve_PosYReina1();
			valor = 1;
		}
		else
		{
			posxReina = campo.Devuelve_PosXReina2();
			posyReina = campo.Devuelve_PosYReina2();
			valor = -1;
		}
		for(int i=0; i<campo.Devuelve_Dimension(); i++)
		{
			for(int j=0; j<campo.Devuelve_Dimension(); j++)
			{
				int actual = campo.Devuelve_Valor(i, j)*valor;
				if(actual<0)
				{
					nenemi++;
					dist += Math.sqrt((i-posxReina)*(i-posxReina) + (j-posyReina)*(j-posyReina));
				}
				if(actual>0)
				{
					naliados++;
				}
			}
		}
		dist /= (float)nenemi;
		return (naliados - nenemi + 1)*dist;
	}

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	 * Posiblidad de ataque enemigo:										 * 
	 * 																		 *
	 * (NMonos aliados - NMonos enemigos + 1)/(NPos atac reina aliada + 1)	 *
	 * 																		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	public float heuristica3(Object state)
	{
		MQ_CampoJuego campo = (MQ_CampoJuego)state;
		int naliados = 0;
		int nenemi = 0;
		int posatac = 1;
		int valor;
		int posxReina;
		int posyReina;
		if(campo.Devuelve_Jugador()==0)
		{
			posxReina = campo.Devuelve_PosXReina1();
			posyReina = campo.Devuelve_PosYReina1();
			valor = 1;
		}
		else
		{
			posxReina = campo.Devuelve_PosXReina2();
			posyReina = campo.Devuelve_PosYReina2();
			valor = -1;
		}
		for(int i=0; i<campo.Devuelve_Dimension(); i++)
		{
			for(int j=0; j<campo.Devuelve_Dimension(); j++)
			{
				int actual = campo.Devuelve_Valor(i, j)*valor;
				if(actual>0)
				{
					naliados++;
				}
				else
				{
					if(actual<0)
					{
						nenemi++;
						if(campo.Conectados(i, j, posxReina, posyReina))
							posatac++;
					}
				}
			}
		}
		return (naliados - nenemi + 1)/(float)posatac;
	}

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	 * Posiblidad de ataque aliado:											 * 
	 * 																		 *
	 * (Aliados - Enemigos + 1)*NPos atac reina enemiga						 *
	 * 																		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	public float heuristica4(Object state)
	{
		MQ_CampoJuego campo = (MQ_CampoJuego)state;
		int naliados = 0;
		int nenemi = 0;
		int posatac = 0;
		int valor;
		int posxReina;
		int posyReina;
		if(campo.Devuelve_Jugador()==0)
		{
			posxReina = campo.Devuelve_PosXReina2();
			posyReina = campo.Devuelve_PosYReina2();
			valor = 1;
		}
		else
		{
			posxReina = campo.Devuelve_PosXReina1();
			posyReina = campo.Devuelve_PosYReina1();
			valor = -1;
		}
		for(int i=0; i<campo.Devuelve_Dimension(); i++)
		{
			for(int j=0; j<campo.Devuelve_Dimension(); j++)
			{
				int actual = campo.Devuelve_Valor(i, j)*valor;
				if(actual<0)
				{
					nenemi++;
				}
				else
				{
					if(actual>0)
					{
						naliados++;
						if(campo.Conectados(i, j, posxReina, posyReina))
							posatac++;
					}
				}
			}
		}
		return (naliados - nenemi + 1)*posatac;
	}
	

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	 * isGoalState:															 * 
	 * 																		 *
	 * Comprueba si estamos ante una jugada ganadora						 *
	 * 																		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	public boolean isGoalState(Object state, int jugador)
	{
		MQ_CampoJuego campo = (MQ_CampoJuego) state;
		if(jugador==0)
		{
			if(campo.Devuelve_PosXReina2()==-1&&campo.Devuelve_PosYReina2()==-1)
				return true;
		}
		else
		{
			if(campo.Devuelve_PosXReina1()==-1&&campo.Devuelve_PosYReina1()==-1)
				return true;
		}	
		return false;
	}	

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	 * isLooserState:														 * 
	 * 																		 *
	 * Comprueba si estamos ante una jugada perdedora						 *
	 * 																		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public boolean isLooserState(Object state, int jugador)
	{
		MQ_CampoJuego campo = (MQ_CampoJuego) state;
		int posxReina, posyReina, valor;
		if(jugador==0)
		{
			if(campo.Devuelve_PosXReina1()==-1&&campo.Devuelve_PosYReina1()==-1)
				return true;

			posxReina = campo.Devuelve_PosXReina1();
			posyReina = campo.Devuelve_PosYReina1();
			valor = 1;
		}
		else
		{
			if(campo.Devuelve_PosXReina2()==-1&&campo.Devuelve_PosYReina2()==-1)
				return true;

			posxReina = campo.Devuelve_PosXReina2();
			posyReina = campo.Devuelve_PosYReina2();
			valor = -1;
		}
		if(campo.Conectados(campo.Devuelve_PosXReina1(), campo.Devuelve_PosYReina1(), campo.Devuelve_PosXReina2(), campo.Devuelve_PosYReina2()))
			return true;	
		for(int i=0; i<campo.Devuelve_Dimension(); i++)
		{
			for(int j=0; j<campo.Devuelve_Dimension(); j++)
			{
				if(campo.Devuelve_Valor(i, j)*valor<0)
				{
					if (campo.Conectados(i,j,posxReina,posyReina))
					{
						return true;
					}
				}
			}
		}	
		return false;
	}
}
