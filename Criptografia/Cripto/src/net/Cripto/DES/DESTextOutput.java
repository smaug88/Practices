package net.Cripto.DES;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.File;
import net.Cripto.Common.DesEncrypter;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class DESTextOutput extends Activity {
	private static final String LOGTAG = "DESTextOutput >>";
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
	        
	        if(bundleIn.getString("Text") != null)
	        {
	        	text = bundleIn.getString("Text");
	        	Log.i(LOGTAG, "Text:" + text);
	        }
	        else 
	        {
	        	if(bundleIn.getString("INFile") != null)
	        	{
		        	Log.i(LOGTAG, "Loading text from file:" + bundleIn.getString("INFile"));
		        	try 
		        	{
						InputStream file = new FileInputStream(bundleIn.getString("INFile"));
						if (file != null) 
						{
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
					} 
		        	catch (FileNotFoundException e) 
		        	{
						e.printStackTrace();
					} 
		        	catch (IOException e) 
		        	{
						e.printStackTrace();
					}				
		        }
	        }
	        try {
				DesEncrypter encriptatron = new DesEncrypter(bundleIn.getString("Pass"));
				if (bundleIn.getBoolean("Encrypt")){ // ENCRIPTAR!
					Log.i(LOGTAG, "DES >> Encriptacion: /n Clave:"+bundleIn.getString("Pass")+"Texto Original: " + text);
					text = encriptatron.encrypt(text);
					Log.i(LOGTAG, "DES >> Encriptacion COMPLETADA Texto encriptado: "+ text);
				}
				else
				{ // DESENCRIPTA!!
					Log.i(LOGTAG, "DES >> Desencriptacion: Clave:"+bundleIn.getString("Pass")+"Texto Encriptado: /n" + text);
					text = encriptatron.decrypt(text);
					Log.i(LOGTAG, "DES >> Desencriptacion COMPLETADA Texto Original: "+ text);
				}
	        
		        if(bundleIn.getString("OUTFile") == null)
		        {
		        	finalText.setText("Texto encriptado:\n"+text);
		        }
		        else
		        {
		        	Log.i(LOGTAG, "Guardando resultado en :" + bundleIn.getString("OUTFile"));
		        	File gpxfile = new File("/mnt", bundleIn.getString("OUTFile"));
		        	FileWriter out = new FileWriter(gpxfile);
		        	out.write(text);
		        	out.close();
		        	finalText.setText("El fichero ha sido escrito correctamente en :" +bundleIn.getString("OUTFile"));
		        }
	        }
	        catch(Exception e)
	        {
				e.printStackTrace();
	        }

		}

}
