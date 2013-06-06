package net.Cripto.RSA;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class RSAPassInput extends Activity {
	private static final String LOGTAG = "RSAPassInput >>";
	private static Bundle bundleIn = null;
	TextView textViewKey1, textViewKey2;
	@Override
	 public void onCreate(Bundle savedInstanceState) {
			Log.i(LOGTAG, "Creado");
	        super.onCreate(savedInstanceState);
	        Log.i(LOGTAG, "Intance State Salvado");
	        setContentView(net.Cripto.R.layout.layoutrsapassinput);
	        Log.i(LOGTAG, "Layout asignado");
	        bundleIn = getIntent().getExtras();
	        textViewKey1 = (TextView)findViewById(net.Cripto.R.id.PassInputKey);
	        textViewKey2 = (TextView)findViewById(net.Cripto.R.id.PassInputKey2);
	        Button buttonEncrypt = (Button)findViewById(net.Cripto.R.id.PassInputButtonEncrypt);
	        buttonEncrypt.setOnClickListener(new OnClickListener(){
	        	public void onClick(View v){
	        		Intent intentOutput = new Intent(RSAPassInput.this, RSATextOutput.class);
	        		Bundle bundleOutput = bundleIn;
	        		bundleOutput.putString("Pass1", textViewKey1.getText().toString());
	        		bundleOutput.putString("Pass2", textViewKey2.getText().toString());
	        		bundleOutput.putBoolean("Encrypt", true);
	    	        Log.i(LOGTAG, "Claves: "+ textViewKey1.getText().toString() + " " + textViewKey2.getText().toString());
	        		intentOutput.putExtras(bundleOutput);
	        		startActivity(intentOutput);
	        	}
	        });
	        Button buttonRSAencrypt = (Button)findViewById(net.Cripto.R.id.PassInputButtonDesencrypt);
	        buttonRSAencrypt.setOnClickListener(new OnClickListener(){
	        	public void onClick(View v){
	        		Intent intentOutput = new Intent(RSAPassInput.this, RSATextOutput.class);
	        		Bundle bundleOutput = bundleIn;
	        		bundleOutput.putString("Pass1", textViewKey1.getText().toString());
	        		bundleOutput.putString("Pass2", textViewKey2.getText().toString());
	    	        Log.i(LOGTAG, "Claves: "+ textViewKey1.getText().toString() + " " + textViewKey2.getText().toString());
	        		bundleOutput.putBoolean("Encrypt", false);
	        		intentOutput.putExtras(bundleOutput);
	        		startActivity(intentOutput);
	        	}
	        });
	       
	        
	        
	}
}
