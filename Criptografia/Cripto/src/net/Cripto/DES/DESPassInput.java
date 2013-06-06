package net.Cripto.DES;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class DESPassInput extends Activity {
	private static final String LOGTAG = "DESPassInput >>";
	private static Bundle bundleIn = null;
	TextView textViewKey;
	@Override
	 public void onCreate(Bundle savedInstanceState) {
			Log.i(LOGTAG, "Creado");
	        super.onCreate(savedInstanceState);
	        Log.i(LOGTAG, "Intance State Salvado");
	        setContentView(net.Cripto.R.layout.layoutdespassinput);
	        Log.i(LOGTAG, "Layout asignado");
	        bundleIn = getIntent().getExtras();
	        textViewKey = (TextView)findViewById(net.Cripto.R.id.PassInputKey);
	        Button buttonEncrypt = (Button)findViewById(net.Cripto.R.id.PassInputButtonEncrypt);
	        buttonEncrypt.setOnClickListener(new OnClickListener(){
	        	public void onClick(View v){
	        		Intent intentOutput = new Intent(DESPassInput.this, DESTextOutput.class);
	        		Bundle bundleOutput = bundleIn;
	        		bundleOutput.putString("Pass", textViewKey.getText().toString());
	        		bundleOutput.putBoolean("Encrypt", true);
	        		intentOutput.putExtras(bundleOutput);
	        		startActivity(intentOutput);
	        	}
	        });
	        Button buttonDesencrypt = (Button)findViewById(net.Cripto.R.id.PassInputButtonDesencrypt);
	        buttonDesencrypt.setOnClickListener(new OnClickListener(){
	        	public void onClick(View v){
	        		Intent intentOutput = new Intent(DESPassInput.this, DESTextOutput.class);
	        		Bundle bundleOutput = bundleIn;
	        		bundleOutput.putString("Pass", textViewKey.getText().toString());
	        		bundleOutput.putBoolean("Encrypt", false);
	        		intentOutput.putExtras(bundleOutput);
	        		startActivity(intentOutput);
	        	}
	        });
	       
	        
	        
	}
}
