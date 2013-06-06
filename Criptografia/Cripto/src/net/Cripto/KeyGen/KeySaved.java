package net.Cripto.KeyGen;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigInteger;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import java.util.Arrays;
import java.util.Vector;

public class KeySaved extends Activity{
	private static final String LOGTAG = "KeySaved >> ";
	@Override
	 public void onCreate(Bundle savedInstanceState) {
		Log.i(LOGTAG, "Creado");
        super.onCreate(savedInstanceState);
		Log.i(LOGTAG, "Instanciado");
        setContentView(net.Cripto.R.layout.layoutkeysaved);
        Bundle bundleIn = getIntent().getExtras();
        final TextView finalText =(TextView) findViewById(net.Cripto.R.id.textView1);
        int v1 = bundleIn.getInt("V1");
        int v2 = bundleIn.getInt("V2");
        int n = Math.abs(v1*v2);
		Log.i(LOGTAG, "n = " + n);
        int m = Math.abs((v1-1)*(v2-1));
		Log.i(LOGTAG, "m = " + m);
        int factores[] = factorizar(m);
        Arrays.sort(factores);
		Log.i(LOGTAG, "factores = " + factores);
        int y = factores[factores.length-1];
        y++;
        while(!esPrimo(y))
        {
        	y++;
        }
		Log.i(LOGTAG, "y = " + y);
        BigInteger d = (new BigInteger(String.valueOf(y))).modInverse(new BigInteger(String.valueOf(m)));
        String ruta = bundleIn.getString("Ruta");
        if(ruta!=null)
        {
        	try 
        	{
        		File gpxfile = new File("/mnt", ruta);
	        	FileWriter out = new FileWriter(gpxfile);
	        	out.write(new String(n + y + "\n" + n + d.toString()));
	        	out.close();
			} 
        	catch (FileNotFoundException e) 
			{
				e.printStackTrace();
			} catch (IOException e) 
			{					
				e.printStackTrace();
			}		
       		finalText.setText("El fichero ha sido escrito correctamente en :" + ruta);
        }
        else
        {
        	finalText.setText("La clave pœblica est‡ formada por los siguientes valores:\n" 
        			+ "m—dulo: " + n + "   exponente: " + y + "\n"
        			+ "La clave privada est‡ formada por los siguientes valores:\n"
        			+ "m—dulo: " + n + "   exponente: " + d);
        }
	};
	
	public int[] factorizar(int numero) {
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
	
	private boolean esPrimo(int p) {
        
        boolean res = true;
        for (int i = 2; i < p; i++) {
            if (p % i == 0) {
                res = false;
            }
        }
        
        return res;
    }
}
