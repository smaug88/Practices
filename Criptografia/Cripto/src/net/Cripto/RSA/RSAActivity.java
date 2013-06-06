package net.Cripto.RSA;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;
import net.Cripto.Common.FileInput;

public class RSAActivity extends Activity {
	private static final String LOGTAG = "RSAActivity >>";
	TextView textView1 = null;
    Button buttonInsertText = null;
    Button buttonInsertFile = null;
    static int Contador = 0;

	@Override
	 public void onCreate(Bundle savedInstanceState) {
			Log.i(LOGTAG, "Creado");
	        super.onCreate(savedInstanceState);
	        Log.i(LOGTAG, "Intance State Salvado");
	        setContentView(net.Cripto.R.layout.layoutrsaactivity);
	        Log.i(LOGTAG, "Layout asignado");
	        textView1 = (TextView) findViewById(net.Cripto.R.id.textView1);
	        buttonInsertText = (Button)findViewById(net.Cripto.R.id.InsertText);
	        buttonInsertText.setOnClickListener(new OnClickListener(){
	        	public void onClick(View arg0){
	        		Log.i(LOGTAG, "Click on Insert Text Button");
	        		Intent intentText = new Intent(RSAActivity.this, RSATextInput.class);
	        		startActivity(intentText);        		
	        	}
	        });
	        buttonInsertFile = (Button)findViewById(net.Cripto.R.id.InsertFile);
	        buttonInsertFile.setOnClickListener(new OnClickListener(){
	        	public void onClick(View arg0){
	        		Log.i(LOGTAG, "Click on Insert File Button");
	        		Intent intentFile = new Intent(RSAActivity.this, FileInput.class);
	        		startActivityForResult(intentFile,1);        	
	        	}
	        });
	        Log.i(LOGTAG, "Objetos del Layout Asignado");
	}
protected void onActivityResult(int requestCode, int resultCode, Intent data){
	if ((data == null) || (resultCode != RESULT_OK)){
		Log.i (LOGTAG, "data was null");
	    return;
	}
	Intent intentOutputSelection = new Intent(this, RSAOutputSelection.class);
	Bundle bundleRuta = new Bundle();
	bundleRuta.putString("INFile", data.getExtras().getString("Path"));
	intentOutputSelection.putExtras(bundleRuta);
	startActivity(intentOutputSelection);
	} 
	
}
