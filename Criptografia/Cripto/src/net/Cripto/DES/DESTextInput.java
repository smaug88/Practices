package net.Cripto.DES;

import android.app.Activity;
import android.os.Bundle;
import android.content.Intent;
import android.util.Log;
import android.widget.Button;
import android.widget.EditText;
import android.view.View;
import android.view.View.OnClickListener;

public class DESTextInput extends Activity {
	private static final String LOGTAG = "DESTextInput >> ";
	@Override
	public void onCreate(Bundle savedInstanceState){
		Log.i(LOGTAG, "Creado");
        super.onCreate(savedInstanceState);
        Log.i(LOGTAG, "Intance State Salvado");
        setContentView(net.Cripto.R.layout.layoutdestextinput);
        final EditText editText =(EditText) findViewById(net.Cripto.R.id.TextInputEditText);
        final Button buttonInsertText = (Button) findViewById(net.Cripto.R.id.TextInputButtonInsertText);
        buttonInsertText.setOnClickListener(new OnClickListener(){
        	public void onClick(View v){
        		Intent intentOutputSelection = new Intent(DESTextInput.this, DESOutputSelection.class);
        		Bundle bundleOutput = new Bundle();
        		bundleOutput.putString("Text",editText.getText().toString());
        		intentOutputSelection.putExtras(bundleOutput);
        		startActivity(intentOutputSelection);
        	}
        });
	}
}
