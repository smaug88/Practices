package monkeyqueen;

	/* * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Esta clase guarda una jugada de la partida,       *
	 * siendo una jugada el movimiento del jugador 1.    *
	 * Si en Acci—n tenemos un 1, es un movimiento		 *
	 * simple, si tenemos un 0, es un ataque.			 *	
	 * * * * * * * * * * * * * * * * * * * * * * * * * * */

public class MQ_Jugada
{
	/* * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Las variables de la clase muestran las posiciones *
	 * iniciales y finales de las fichas a mover y la    *
	 * acci—n realizada por cada jugador.                *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public int Pos_x1_JUG1;
	public int Pos_x2_JUG1;
	public int Pos_y1_JUG1;
	public int Pos_y2_JUG1;
	public int Acc_JUG1;
	
	public MQ_Jugada(int px1, int px2, int py1, int py2, int ph)
	{
		Pos_x1_JUG1 = px1;
		Pos_x2_JUG1 = px2;
		Pos_y1_JUG1 = py1;
		Pos_y2_JUG1 = py2;
		Acc_JUG1 = ph;
	}

}
