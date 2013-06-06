
import java.util.*;

public class BKTreeDL
{
	private BKNodeDL raiz;
	
	// Devuelve las palabras más cercanas a la solicitada
	public List<String> busqueda(String palabra)
	{
		return raiz.busqueda(palabra, 9999);
	}
	
	// Inserta una palabra en el árbol
	public void insertar(String palabra)
	{
		if (palabra == null || palabra.isEmpty()) 
			return;
		BKNodeDL nodo = new BKNodeDL(palabra);
		if (raiz == null) 
		{
			raiz = nodo;
		}
		insertarRecursivo(raiz, nodo);
	}
	
	// Función interna para insertar un nodo en el árbol
	private void insertarRecursivo(BKNodeDL padre, BKNodeDL nuevo)
	{
		if (padre.equals(nuevo)) 
		{
			return;
		}
		int distancia = distancia(padre.palabra, nuevo.palabra);
		BKNodeDL nodo = padre.HijoADistancia(distancia);
		if (nodo == null) 
		{
			padre.insertaHijo(distancia, nuevo);
		}
		else 
		{
			insertarRecursivo(nodo, nuevo);
		}
	}
	
	// Función que calcula la distancia entre dos palabras
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