package net.dgc;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.SeekBar;

public class OpcionesActivity extends Activity {
	static private SeekBar seekbarReflection;
	static private SeekBar seekbarFocus;
	static private SeekBar seekbarAmbient ;
	@Override
	public void onCreate(Bundle savedInstanceState){
    	super.onCreate(savedInstanceState);
    	setContentView(net.dgc.R.layout.menu_iluminacion);
    	seekbarAmbient = (SeekBar)findViewById(R.id.seekBarAmbiental);
    	seekbarReflection= (SeekBar)findViewById(R.id.seekBarRefractada);
    	seekbarFocus= (SeekBar)findViewById(R.id.seekBarFoco);
    	seekbarAmbient.setMax(50);
    	seekbarReflection.setMax(50);
    	seekbarFocus.setMax(50);
    	Bundle bundle = getIntent().getExtras();
    	seekbarAmbient.setProgress((int)(bundle.getFloat("ambiental")*10));
    	seekbarReflection.setProgress((int)(bundle.getFloat("reflection")*10));
    	seekbarFocus.setProgress((int)(bundle.getFloat("focus")*10));
    	
    	Button buttonOutputText = (Button)findViewById(net.dgc.R.id.buttonAceptar);
    	buttonOutputText.setOnClickListener(new OnClickListener(){
    		public void onClick(View arg0){
    			Intent intentResult = new Intent();
				Bundle BundleResult = new Bundle();
				BundleResult.putFloat("ambiental", seekbarAmbient.getProgress()/10);
				BundleResult.putFloat("reflection", seekbarReflection.getProgress()/10);
				BundleResult.putFloat("focus", seekbarFocus.getProgress()/10);
				intentResult.putExtras(BundleResult);
				setResult(RESULT_OK,intentResult);
				finish();
    		}    		
    	});
	}
}
