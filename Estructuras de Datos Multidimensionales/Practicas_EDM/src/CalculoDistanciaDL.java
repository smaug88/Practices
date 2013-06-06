import java.util.*;
import java.io.*;

public class CalculoDistanciaDL
{
	
	private static int minimum(int a, int b, int c) 
	{
        if (a<=b && a<=c)
        {
            return a;
        } 
        if (b<=a && b<=c)
        {
            return b;
        }
        return c;
    }
	
	public long[] Comprueba_Palabras(List<String> palabras_correctas, List<String> palabras_erroneas)
	{
		try
	  	{
			int numCorrectas = 0;
		  	FileWriter ficheroFinal = new FileWriter("FicheroSolucionDL.txt");
	  		BufferedWriter out = new BufferedWriter(ficheroFinal);
			long startTime = System.nanoTime();
		  	for(int i=0; i<palabras_erroneas.size(); i++)
		  	{
		  		List<String> palabras_posibles = new ArrayList<String>();
		  		int DL = 99999;
		  		// Comprobamos la distancia de cada palabra la erronea
		  		for(int j=0; j<palabras_correctas.size(); j++)
		  		{
		  			char [] str1 = palabras_correctas.get(j).toCharArray();
		  			char [] str2 = palabras_erroneas.get(i).toCharArray();
		  			int [][]distance = new int[str1.length+1][str2.length+1];
	 
			        for(int m=0; m<=str1.length; m++)
			        {
			                distance[m][0] = m;
			        }
			        for(int n=0; n<=str2.length; n++)
			        {
			                distance[0][n]=n;
			        }
			        for(int m=1; m<=str1.length; m++)
			        {
			            for(int n=1; n<=str2.length; n++)
			            { 
			                  distance[m][n]= minimum(distance[m-1][n]+1,
			                                        distance[m][n-1]+1,
			                                        distance[m-1][n-1]+
			                                        ((str1[m-1]==str2[n-1])?0:1));
			            }
			        }
			        // Si la palabra tiene la misma distancia que la actual, la a–adimos a la lista
			        if(distance[str1.length][str2.length] == DL)
			        {
			        	palabras_posibles.add(palabras_correctas.get(j));
			        }
			        // Si la palabra tiene menor distancia que la actual, limpiamos la lista, a–adimos la palabra y reducimos la DL
			        if(distance[str1.length][str2.length] < DL)
			        {
			        	DL = distance[str1.length][str2.length];
			        	palabras_posibles.clear();
			        	palabras_posibles.add(palabras_correctas.get(j));
			        }
		  		}
		  		// Almacenamos el resultado en el fichero
	  			out.write(palabras_erroneas.get(i) + " : ");
	  			boolean correcto = false;
	  			for(int k=0; k<palabras_posibles.size()-1; k++)
	  			{
	  				out.write(palabras_posibles.get(k) + ", ");
	  				if(palabras_correctas.indexOf(palabras_posibles.get(k))==i)
	  					correcto = true;
	  			}
	  			out.write(palabras_posibles.get(palabras_posibles.size()-1) + " : DL = " + DL);
	  			if(palabras_correctas.indexOf(palabras_posibles.get(palabras_posibles.size()-1))==i)
	  					correcto = true;
	  			if(correcto)
	  			{
	  				out.write(" --> Correcto = OK");
					numCorrectas++;
	  			}
	  			else
	  				out.write(" --> Correcto = NO");
	  			out.newLine();
		  	}
			out.write("Nœmero de palabras correctas: "+numCorrectas);
			out.newLine();
			long endTime = System.nanoTime();
			out.write("Tiempo de ejecuci—n: " + (endTime - startTime)/1000000000);
		  	out.close();
		  	long[] retorno = new long[2];
		  	retorno[0] = numCorrectas;
		  	retorno[1] = (endTime - startTime)/1000000000;
		  	return retorno;
	  	}
	  	catch (Exception e)
		{//Catch exception if any
  			System.err.println("Error: " + e.getMessage());	
		}
		return null;
	}
}