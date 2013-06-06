
import java.util.*;

public class BKTreeDIT
{
	private BKNodeDIT raiz;
	
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
		BKNodeDIT nodo = new BKNodeDIT(palabra);
		if (raiz == null) 
		{
			raiz = nodo;
		}
		insertarRecursivo(raiz, nodo);
	}
	
	// Función interna para insertar un nodo en el árbol
	private void insertarRecursivo(BKNodeDIT padre, BKNodeDIT nuevo)
	{
		if (padre.equals(nuevo)) 
		{
			return;
		}
		int distancia = distancia(padre.palabra, nuevo.palabra);
		BKNodeDIT nodo = padre.HijoADistancia(distancia);
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