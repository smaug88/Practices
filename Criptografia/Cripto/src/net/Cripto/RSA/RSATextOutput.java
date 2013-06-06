package net.Cripto.RSA;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.File;
import net.Cripto.Common.RSAEncrypter;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class RSATextOutput extends Activity {
	private static final String LOGTAG = "RSATextOutput >>";
	private static Bundle bundleIn = null;
	private static String text = "";
	@Override
	 public void onCreate(Bundle savedInstanceState) {
			Log.i(LOGTAG, "Creado");
	        super.onCreate(savedInstanceState);
	        Log.i(LOGTAG, "Intance State Salvado");
	        setContentView(net.Cripto.R.layout.layoutdestextoutput);
	        Log.i(LOGTAG, "Layout asignado");
	        bundleIn = getIntent().getExtras();
	        final TextView finalText =(TextView) findViewById(net.Cripto.R.id.TextOutputFinalText);
	        
	        if(bundleIn.getString("Text") != null){
	        	text = bundleIn.getString("Text");
	        	Log.i(LOGTAG, "Text:" + text);
	        }else if(bundleIn.getString("INFile") != null){
	        	Log.i(LOGTAG, "Loading text from file:" + bundleIn.getString("INFile"));
	        	try {
					InputStream file = new FileInputStream(bundleIn.getString("INFile"));
					if (file != null) 
					{
						  text = "";
						  InputStreamReader inputreader = new InputStreamReader(file);
					      BufferedReader buffreader = new BufferedReader(inputreader);
					 
					      String line;
					      line = buffreader.readLine();
					      while ( line != null) 
					      {
					    	  text = text+line;
						      line = buffreader.readLine();
					      }
					}
					file.close();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}				
	        }   
	        String solucion = null;
			Log.i(LOGTAG, "Texto inicial: "+ text);
	        try {
				if (bundleIn.getBoolean("Encrypt")){ // ENCRIPTAR!
					Log.i(LOGTAG, "RSA >> Encriptacion: Clave:"+bundleIn.getString("Pass2")+ " " + bundleIn.getString("Pass1")+" Texto Original: " + text);
					solucion = RSAEncrypter.encripta(text, Integer.parseInt(bundleIn.getString("Pass2")), Integer.parseInt(bundleIn.getString("Pass1")));
					Log.i(LOGTAG, "RSA >> Encriptacion COMPLETADA Texto encriptado: "+ solucion);
				}else{ // DESENCRIPTA!!
					Log.i(LOGTAG, "RSA >> Desencriptacion: Clave:"+bundleIn.getString("Pass2")+ " "+bundleIn.getString("Pass1")+" Texto Encriptado: " + text);
					solucion = RSAEncrypter.desencripta(text, Integer.parseInt(bundleIn.getString("Pass2")), Integer.parseInt(bundleIn.getString("Pass1")));
					Log.i(LOGTAG, "RSA >> Desencriptacion COMPLETADA Texto Original: "+ solucion);
				}
		        if(bundleIn.getString("OUTFile") == null)
		        {
		        	finalText.setText("Texto encriptado:\n" + solucion);
		        }
		        else
		        {
		        	Log.i(LOGTAG, "Guardando resultado en :" + bundleIn.getString("OUTFile"));
		        	File gpxfile = new File("/mnt", bundleIn.getString("OUTFile"));
		        	FileWriter out = new FileWriter(gpxfile);
					Log.i(LOGTAG, "RSA >> texto a insertar: "+ solucion);
		        	out.write(solucion);
		        	out.close();
		        	finalText.setText("El fichero ha sido escrito correctamente en :" +bundleIn.getString("OUTFile")+ " " + solucion);
		        }
	        }
	        catch(Exception e)
	        {
				e.printStackTrace();
			}
		}
}
