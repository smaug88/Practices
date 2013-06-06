package net.Cripto.DES;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import net.Cripto.Common.FileInput;

public class DESOutputSelection extends Activity {
	private static final String LOGTAG = "DESOutputSelection >>";
	private static Bundle bundleIn = null;
	@Override
	public void onCreate(Bundle savedInstanceState){
		Log.i(LOGTAG, "Creado");
    	super.onCreate(savedInstanceState);
    	Log.i(LOGTAG, "Intance State Salvado");
    	setContentView(net.Cripto.R.layout.layoutdesoutputselection);
    	Log.i(LOGTAG, "Layout asignado");
    	bundleIn = getIntent().getExtras();
    	Button buttonOutputText = (Button)findViewById(net.Cripto.R.id.OutputSelectionbuttonOutputText);
    	buttonOutputText.setOnClickListener(new OnClickListener(){
    		public void onClick(View arg0){
    			Log.i(LOGTAG, "Click on Output Text Button");
    			Intent intentPass = new Intent(DESOutputSelection.this, DESPassInput.class);    			
    			intentPass.putExtras(bundleIn);
    			startActivity(intentPass);
    		}    		
    	});
    	Button buttonOutputFile = (Button)findViewById(net.Cripto.R.id.OutputSelectionbuttonOutputFile);
    	buttonOutputFile.setOnClickListener(new OnClickListener(){
    		public void onClick(View arg0){
    			Log.i(LOGTAG, "Click on Output File Button");
    			Intent intentFile = new Intent(DESOutputSelection.this, FileInput.class);
    			startActivityForResult(intentFile,1);
    		}    		
    	});	
	}
	protected void onActivityResult(int requestCode, int resultCode, Intent data){
		if ((data == null) || (resultCode != RESULT_OK)){
			Log.i (LOGTAG, "data was null");
		    return;
		}
		Bundle bundlePass = bundleIn;
		Intent intentPassInput=new Intent(this, DESPassInput.class);
		bundlePass.putString("OUTFile", data.getExtras().getString("Path"));
		intentPassInput.putExtras(bundlePass);
		startActivity(intentPassInput);
	}

}
