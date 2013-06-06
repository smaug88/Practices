import java.util.*;
import java.io.*;

public class CalculoDistanciaDIT
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
	
	private static int DistanciaDL(String ristra1, String ristra2)
	{
		char [] str1 = ristra1.toCharArray();
		char [] str2 = ristra2.toCharArray();
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
		return distance[str1.length][str2.length];
	}
	
	private static int DistanciaDIM(String ristra1, String ristra2)
	{
		char [] str1 = ristra1.toCharArray();
		char [] str2 = ristra2.toCharArray();
		char [] letras = "abcdefghijklmn–opqrstuvwxyz".toCharArray();
		int sumador = 0;
		for (int i=0; i<27; i++) 
		{
			int contador = 0;
			for (int j=0; j<str1.length; j++) 
			{
				if (str1[j]==letras[i]) 
				{
					contador++;
				}
			}
			for (int j=0; j<str2.length; j++) 
			{
				if (str2[j]==letras[i]) 
				{
					contador--;
				}
			}
			sumador+= Math.abs(contador);
		}
		return (sumador+Math.abs(str1.length-str2.length));
	}
	
	public long[] Comprueba_Palabras(List<String> palabras_correctas, List<String> palabras_erroneas)
	{
		try
	  	{
		  	FileWriter ficheroFinal = new FileWriter("FicheroSolucionDIT.txt");
	  		BufferedWriter out = new BufferedWriter(ficheroFinal);
			long startTime = System.nanoTime();
			int correctas = 0;
		  	for(int i=0; i<palabras_erroneas.size(); i++)
		  	{
		  		List<String> palabras_posibles = new ArrayList<String>();
		  		int DL = 99999;
		  		// Comprobamos la distancia de cada palabra la erronea
		  		for(int j=0; j<palabras_correctas.size(); j++)
		  		{
					int DIM = DistanciaDIM(palabras_correctas.get(j), palabras_erroneas.get(i));
					if (DIM <= DL*2) 
					{
						int DLtemp = DistanciaDL(palabras_correctas.get(j), palabras_erroneas.get(i));
						// Si la palabra tiene la misma distancia que la actual, la a–adimos a la lista
						if(DLtemp == DL)
						{
							palabras_posibles.add(palabras_correctas.get(j));
						}
						// Si la palabra tiene menor distancia que la actual, limpiamos la lista, a–adimos la palabra y reducimos la DL
						if(DLtemp < DL)
						{
							DL = DLtemp;
							palabras_posibles.clear();
							palabras_posibles.add(palabras_correctas.get(j));
						}
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
				if(correcto || palabras_correctas.indexOf(palabras_posibles.get(palabras_posibles.size()-1))==i)
				{
					out.write(" --> Correcto = OK");
					correctas++;
				}
	  			else
	  				out.write(" --> Correcto = NO");
	  			out.newLine();
		  	}
			out.write("Nœmero de palabras correctas: "+correctas);
			out.newLine();
			long endTime = System.nanoTime();
			out.write("Tiempo de ejecuci—n: " + (endTime - startTime)/Math.pow(10.0,9.0));
		  	out.close();
		  	long[] retorno = new long[2];
		  	retorno[0] = correctas;
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