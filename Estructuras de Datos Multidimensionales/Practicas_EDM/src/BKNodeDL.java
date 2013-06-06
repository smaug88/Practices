
import static java.lang.Math.max;
import java.util.*;

public class BKNodeDL
{
	final String palabra;
	final Map<Integer, BKNodeDL> hijos = new HashMap<Integer, BKNodeDL>();
	
	public BKNodeDL(String palabro)
	{
		this.palabra = palabro;
	}
	
	protected BKNodeDL HijoADistancia(int distancia)
	{
		return hijos.get(distancia);
	}
	
	public void insertaHijo(int distancia, BKNodeDL hijo)
	{
		hijos.put(distancia, hijo);
	}
	
	public List<String> busqueda(String palabra, int distanciaMaxima)
	{
		int distancia, distanciaActual = distanciaMaxima;;
		List<String> coincidencias = new LinkedList<String>();
		if (hijos.size() == 0) 
		{
			distancia = distancia(this.palabra, palabra);
			if (distancia <= distanciaMaxima)
					coincidencias.add(this.palabra);
			return coincidencias;
		}
		else 
		{
			distancia = distancia(this.palabra, palabra);
			if (distancia <= distanciaMaxima)
			{
					coincidencias.add(this.palabra);
				distanciaActual = distancia;
			}
		}
		int i = max(1, distancia - distanciaActual);
		for(; i <= distancia + distanciaActual; i++)
		{
			BKNodeDL hijo = hijos.get(i);
			if (hijo == null) 
				continue;
			List<String> coincidenciasHijo = hijo.busqueda(palabra, distanciaActual);
			if (coincidenciasHijo.size() > 0) 
			{
				int distaux = distancia(palabra, coincidenciasHijo.get(0));
				if (distaux<distanciaActual) 
				{
					distanciaActual = distaux;
					coincidencias.clear();
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
}