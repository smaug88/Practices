
import static java.lang.Math.max;
import java.util.*;

public class BKNodeDIT
{
	final String palabra;
	final Map<Integer, BKNodeDIT> hijos = new HashMap<Integer, BKNodeDIT>();
	
	public BKNodeDIT(String palabro)
	{
		this.palabra = palabro;
	}
	
	protected BKNodeDIT HijoADistancia(int distancia)
	{
		return hijos.get(distancia);
	}
	
	public void insertaHijo(int distancia, BKNodeDIT hijo)
	{
		hijos.put(distancia, hijo);
	}
	
	public List<String> busqueda(String palabra, int distanciaMaxima)
	{
		int distanciaDIM = DistanciaDIM(this.palabra, palabra);
		int distancia, distMax = distanciaMaxima, distanciaActual = distanciaMaxima;
		List<String> coincidencias = new LinkedList<String>();
		if (hijos.size() == 0) 
		{
			if(distanciaDIM <= distanciaActual)
			{
				distancia = distancia(this.palabra, palabra);
				if (distancia <= distMax)
					coincidencias.add(this.palabra);
			}
			return coincidencias;
		}
		else 
		{
			if(distanciaDIM <= distanciaActual)
			{
				distancia = distancia(this.palabra, palabra);
				if (distancia <= distMax)
				{
					coincidencias.add(this.palabra);
					distMax = distancia;
				}
				distanciaActual = distanciaDIM;
			}
		}
		int i = max(1, distanciaDIM - distanciaActual);
		for(; i <= distanciaDIM + distanciaActual; i++)
		{
			BKNodeDIT hijo = hijos.get(i);
			if (hijo == null) 
				continue;
			List<String> coincidenciasHijo = hijo.busqueda(palabra, distanciaActual);
			if (coincidenciasHijo.size() > 0) 
			{
				int distaux = DistanciaDIM(palabra, coincidenciasHijo.get(0));
				if (distaux < distanciaActual) 
				{
					int distaux2 = distancia(palabra, coincidenciasHijo.get(0));
					if (distaux2<distMax) 
					{
						distMax = distaux2;
						coincidencias.clear();
					}
					distanciaActual = distaux;
				}
				coincidencias.addAll(coincidenciasHijo);
			}
		}
		return coincidencias;
	}
	
	public int distancia(String	palabraA, String palabraB)
	{
		char [] str1 = palabraA.toCharArray();
		char [] str2 = palabraB.toCharArray();
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
				distance[m][n]= minimo(distance[m-1][n]+1,
									   distance[m][n-1]+1,
									   distance[m-1][n-1]+
									   ((str1[m-1]==str2[n-1])?0:1));
			}
		}
		return distance[str1.length][str2.length];
	}
	
	private int minimo(int a, int b, int c)
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
	
	private static int DistanciaDIM(String ristra1, String ristra2)
	{
		char [] str1 = ristra1.toCharArray();
		char [] str2 = ristra2.toCharArray();
		char [] letras = "abcdefghijklmnñopqrstuvwxyz".toCharArray();
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
}