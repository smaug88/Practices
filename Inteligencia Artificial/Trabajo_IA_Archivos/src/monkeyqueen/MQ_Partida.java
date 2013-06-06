package monkeyqueen;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Esta clase representa el registro de la partida a lo  *
 * largo del tiempo. Permite guardar su estado en un     *
 * fichero o reutilizar una partida anterior a partir    *
 * de un fichero ya existente.                           *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

public class MQ_Partida 
{
	private List<MQ_Jugada> Partida;
	private int nJugadas;
	private int[] valores_iniciales;
	private String ruta;
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Constructor de la clase. Inicialmente est‡ vacio. *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public MQ_Partida()
	{
		Partida = new ArrayList<MQ_Jugada>();
		nJugadas = 0;
		valores_iniciales = new int[13];
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * *
	 * Inserta una jugada en la partida completa *
	 * * * * * * * * * * * * * * * * * * * * * * */
	
	public void Set_Ruta(String Ruta)
	{
		ruta = Ruta;
	}
	
	public String Get_ruta()
	{
		return ruta;
	}
	
	public void Inserta_Jugada(MQ_Jugada Jugada)
	{
		Partida.add(Jugada);
		nJugadas++;
		return;
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * *
	 * Guarda la partida en el fichero cuya ruta     *
	 * se le pasa por par‡metro. Devuelve el tama–o  *
	 * del fichero. Si no hay jugadas, se devuelve	 *
	 * un -1. En caso de fallo, -1.            		 *
	 * * * * * * * * * * * * * * * * * * * * * * * * */
	
	public int Salva_Partida()
	{
		FileWriter fichero = null;
		PrintWriter pw = null;
		try
		{
			fichero = new FileWriter(ruta);
			pw = new PrintWriter(fichero);
			
			pw.println(valores_iniciales[0] + " " + valores_iniciales[1] + " " + valores_iniciales[2] + " " + valores_iniciales[3]
											+ " " + valores_iniciales[4] + " " + valores_iniciales[5] + " " + valores_iniciales[6]
											+ " " + valores_iniciales[7] + " " + valores_iniciales[8] + " " + valores_iniciales[9]
							 				+ " " + valores_iniciales[10] + " " + valores_iniciales[11] + " " + valores_iniciales[12]);
			pw.println(nJugadas);
			for(int i=0; i<nJugadas; i++)
			{
				pw.println(Partida.get(i).Pos_x1_JUG1 + " " + Partida.get(i).Pos_y1_JUG1 + " "
					+ Partida.get(i).Pos_x2_JUG1 + " " + Partida.get(i).Pos_y2_JUG1 + " " + Partida.get(i).Acc_JUG1);
			}

		} catch (Exception e) {
			return -1;
		} finally {
			try {
				// Nuevamente aprovechamos el finally para 
				// asegurarnos que se cierra el fichero.
				if (null != fichero)
				fichero.close();
	       } catch (Exception e2) {
	    	    return -1;
	       }
	    }
		return 0 ;
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * *
	 * Carga la partida desde un fichero cuya ruta   *
	 * se le pasa por par‡metro. Devuelve el nœmero  *
	 * de jugadas hechas. En caso de no haber		 *
	 * partidas, se devolver‡ -2. En caso de 		 *
	 * fallo, -1.     								 *
	 * * * * * * * * * * * * * * * * * * * * * * * * */

	public int[] ValoresIniciales()
	{
		return valores_iniciales;
	}

	public void SetValoresIniciales(int valores[])
	{
		valores_iniciales = valores;
	}
	
	public int NumeroJugadas()
	{
		return nJugadas;
	}
	
	public MQ_Jugada ObtenerJugada(int indice)
	{
		return Partida.get(indice);
	}
	
	public int Carga_Partida(String ruta)
	{ 
		File archivo = null;
	    FileReader fr = null;
	    BufferedReader br = null;
	
	    try 
	    {
	       // Apertura del fichero y creacion de BufferedReader para poder
	       // hacer una lectura comoda (disponer del metodo readLine()).
	       archivo = new File (ruta);
	       fr = new FileReader (archivo);
	       br = new BufferedReader(fr);
	
	       // Lectura del fichero
	       String linea;
    	   linea = br.readLine();
    	   String[] valores_init = linea.split(" ");
    	   valores_iniciales[0] = Integer.parseInt(valores_init[0]);
    	   valores_iniciales[1] = Integer.parseInt(valores_init[1]);
    	   valores_iniciales[2] = Integer.parseInt(valores_init[2]);
    	   valores_iniciales[3] = Integer.parseInt(valores_init[3]);
    	   valores_iniciales[4] = Integer.parseInt(valores_init[4]);
    	   valores_iniciales[5] = Integer.parseInt(valores_init[5]);
    	   valores_iniciales[6] = Integer.parseInt(valores_init[6]);
    	   valores_iniciales[7] = Integer.parseInt(valores_init[7]);
    	   valores_iniciales[8] = Integer.parseInt(valores_init[8]);
    	   valores_iniciales[9] = Integer.parseInt(valores_init[9]);
    	   valores_iniciales[10] = Integer.parseInt(valores_init[10]);
    	   valores_iniciales[11] = Integer.parseInt(valores_init[11]);
    	   valores_iniciales[12] = Integer.parseInt(valores_init[12]);
	       nJugadas = Integer.parseInt(br.readLine());
	       if(nJugadas==0)
	    	   return -2;
	       for(int i=0; i<nJugadas; i++)
	       {
	    	   linea = br.readLine();
	    	   String[] valores = linea.split(" ");
	    	   MQ_Jugada jugada = new MQ_Jugada(Integer.parseInt(valores[0]),
	    			   				  			Integer.parseInt(valores[1]),
	    			   				  			Integer.parseInt(valores[2]),
	    			   				  			Integer.parseInt(valores[3]),
	    			   				  			Integer.parseInt(valores[4]));
	    	   Partida.add(jugada);
	       }
	    }
	    catch(Exception e){
	    	return -1;
	    }finally{
	       // En el finally cerramos el fichero, para asegurarnos
	       // que se cierra tanto si todo va bien como si salta 
	       // una excepcion.
	       try{                    
	          if( null != fr ){   
	             fr.close();     
	          }                  
	       }catch (Exception e2){ 
	          return -1;
	       }
	    }
		return 0;
	}
}
