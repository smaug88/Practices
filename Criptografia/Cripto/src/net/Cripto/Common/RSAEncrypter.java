package net.Cripto.Common;

import java.math.BigInteger;
import java.util.Vector;

import android.util.Log;

public class RSAEncrypter {

	private static final String LOGTAG = "RSAEncripter >>";

	public static String encripta(String mensaje, int e, int n)
	{
		String cifra = "";
		int g;
		char letras[] = mensaje.toCharArray();
		for(int i = 0; i < mensaje.length(); i++) 
		{
			int m = letras[i];
		    if (m > -1) 
		    {
    			BigInteger a = new BigInteger(String.valueOf((m*m)% n));
		    	if ( e % 2 == 0) 
		    	{
		    		g = 1;
		    		for (int ii = 1; ii <= e/2; ii++) 
		    		{
		    			BigInteger b = new BigInteger(String.valueOf(g));
		    			g = Integer.valueOf((a.multiply(b)).mod(new BigInteger(String.valueOf(n))).toString());
				    	Log.i(LOGTAG, "Texto en medio: " + g);
		    		}
		    	} 
		    	else 
		    	{
		    		g = m;
		    		for (int ii = 1; ii <= e/2; ii++) 
		    		{
		    			BigInteger b = new BigInteger(String.valueOf(g));
		    			g = Integer.valueOf((a.multiply(b)).mod(new BigInteger(String.valueOf(n))).toString());
				    	Log.i(LOGTAG, "Texto en medio: " + g + " con m: " + m + " y n: " + n);
		    		}
		    	}
		    	Log.i(LOGTAG, "Text antes: " + m + " despues: " + g);
		    	cifra += " " + g;
		    }
		}
        return cifra.substring(1);
    }
	
	public static String desencripta(String encriptado, int d, int n) 
	{
		String texto = "";
		String valores_texto[] = encriptado.split(" ");
		int g;;
		for(int i = 0; i < valores_texto.length; i++) 
		{
			int m = Integer.parseInt(valores_texto[i]);
		    if (m > -1) 
		    {
    			int a = (m*m)% n;
		    	Log.i(LOGTAG, "A: " + a);
		    	if ( d % 2 == 0) 
		    	{
		    		g = 1;
		    		for (int ii = 1; ii <= d/2; ii++) 
		    		{
		    			g = (a*g)%n;
				    	Log.i(LOGTAG, "Texto: " + g + " con m: " + m + " y n: " + n);
		    		}
		    	} 
		    	else 
		    	{
		    		g = m;
		    		for (int ii = 1; ii <= d/2; ii++) 
		    		{
		    			g = (a*g)%n;
				    	Log.i(LOGTAG, "Texto: " + g + " con m: " + m + " y n: " + n);
		    		}
		    	}
		    	Log.i(LOGTAG, "Text antes: " + m + " despues: " + g);
		    	texto += (char)g;
		    }
		}
        return texto;
    }
	
	public static int[] factorizar(int numero) {
        Vector<Integer> listaPrimos = new Vector<Integer>();
        
        if (numero <= 1) {
            throw new IllegalArgumentException("El número debe ser >= 2");
        }
        
        int aux = numero;
        int i = 2;
        
        while (aux != 1) {
            if (esPrimo(i)) {                
                while (aux % i == 0) {
                    listaPrimos.add(new Integer(i));
                    aux = aux / i;
                }
            }
            i++;
        }
        
        int[] resultado = new int[listaPrimos.size()];
        for (int j = 0; j < listaPrimos.size(); j++) {
            resultado[j] = ((Integer)listaPrimos.get(j)).intValue();
        }
        
        return resultado;
    }
	
	private static boolean esPrimo(int p) {
        
        boolean res = true;
        for (int i = 2; i < p; i++) {
            if (p % i == 0) {
                res = false;
            }
        }
        
        return res;
    }
}
