import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;


public class Practicas_EDM 
{
	public static void main(String [] args)
	{
		List<String> palabras_correctas = new ArrayList<String>();
		List<String> palabras_erroneas = new ArrayList<String>();
	    try
	    {
	    	BufferedReader reader = new BufferedReader(new FileReader("/Users/david/Dropbox/Universidad/EDM/Practicas/DIC10454.txt"));
	    	String line;
	    	while ((line = reader.readLine()) != null)
	    	{
	      		palabras_correctas.add(line);
	    	}
	    	reader.close();

	    	reader = new BufferedReader(new FileReader("/Users/david/Dropbox/Universidad/EDM/Practicas/FicheroErrores.txt"));
	    	line = null;
	    	while ((line = reader.readLine()) != null)
	    	{
	      		palabras_erroneas.add(line);
	    	}
	    	reader.close();
	  	}
	  	catch (Exception e)
	  	{
	    	e.printStackTrace();
	    	return ;
	  	}
	    
	    long[][] valores = new long[4][2];
	    valores[0] = (new CalculoDistanciaDL()).Comprueba_Palabras(palabras_correctas, palabras_erroneas);
	    valores[1] = (new CalculoDistanciaDIT()).Comprueba_Palabras(palabras_correctas, palabras_erroneas);
	    valores[2] = (new CalculoDistanciaBKDL()).Comprueba_Palabras(palabras_correctas, palabras_erroneas);
	    valores[3] = (new CalculoDistanciaBKDIT()).Comprueba_Palabras(palabras_correctas, palabras_erroneas);
	    System.out.println(" Nombre Aciertos Tiempo");
	    System.out.println(" DL " + valores[0][1] + " " + valores[0][0]);
	    System.out.println(" DIT " + valores[1][1] + " " + valores[1][0]);
	    System.out.println(" BK DL " + valores[2][1] + " " + valores[2][0]);
	    System.out.println(" BK DIT " + valores[3][1] + " " + valores[3][0]);
	}
	
	@Test
	public void pruebaGeneral()
	{
		main(null);
	}
}
