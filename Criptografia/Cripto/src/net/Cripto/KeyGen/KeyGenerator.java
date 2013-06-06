package net.Cripto.KeyGen;

import java.math.BigInteger;
import net.Cripto.Common.FileInput;
import net.Cripto.Common.SecureRandomNumber;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.util.Log;

public class KeyGenerator extends Activity {

	private static final String LOGTAG = "KeyINIT >> ";
	@Override
	 public void onCreate(Bundle savedInstanceState) {
		Log.i(LOGTAG, "Creado");
        super.onCreate(savedInstanceState);
		Log.i(LOGTAG, "Instanciado");
        setContentView(net.Cripto.R.layout.layoutkeygenerator);
        final CheckBox checkBox = (CheckBox) findViewById(net.Cripto.R.id.checkBox1);
        final EditText editText1 =(EditText) findViewById(net.Cripto.R.id.editText1);
        final EditText editText2 =(EditText) findViewById(net.Cripto.R.id.editText2);
        checkBox.setOnCheckedChangeListener(new OnCheckedChangeListener()
        {
        	// En caso de cambiar el estado de checkBox, cambiamos la visibilidad de los campos de texto
        	public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) { 
        		if (buttonView.isChecked()) { 
        			Log.i(LOGTAG, "Texto no mostrado");
        			editText1.setEnabled(false);
        			editText2.setEnabled(false);
        		} 
        		else 
        		{ 
        			Log.i(LOGTAG, "Texto mostrado");
        			editText1.setEnabled(true);
        			editText2.setEnabled(true);
        		}
        	}
        });
        // Escogemos un fichero para guardar las claves
        final Button ButtonFileOutput = (Button) findViewById(net.Cripto.R.id.button1);
        ButtonFileOutput.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
        		Intent intentFile = new Intent(KeyGenerator.this, FileInput.class);
        		startActivityForResult(intentFile,1);   
			}
		});
		// Mostramos por pantalla las claves
        final Button ButtonScreenOutput = (Button) findViewById(net.Cripto.R.id.button2);
        ButtonScreenOutput.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				if(checkBox.isChecked())
				{
					BigInteger a = new BigInteger(6, SecureRandomNumber.getRandom());
					while(((a.subtract(new BigInteger("13"))).compareTo(BigInteger.ONE) != 1)&&(a.isProbablePrime(64)))
					{
						a = new BigInteger(6, SecureRandomNumber.getRandom());
					}
					int v1 = a.intValue();
					Log.i(LOGTAG, "El valor de v1 es: " + v1);
					BigInteger b = new BigInteger(6, SecureRandomNumber.getRandom());
					while(((b.subtract(new BigInteger("13"))).compareTo(BigInteger.ONE) != 1)&&(b.isProbablePrime(64)))
					{
						b = new BigInteger(6, SecureRandomNumber.getRandom());
					}
					int v2 = b.intValue();
					Log.i(LOGTAG, "El valor de v2 es: " + v2);
					Bundle bundlePass = new Bundle();
					bundlePass.putInt("V1", v1);
					bundlePass.putInt("V2", v2);
					bundlePass.putString("Ruta", null);
					Intent intentPassInput=new Intent(KeyGenerator.this, KeySaved.class);
					intentPassInput.putExtras(bundlePass);
					startActivity(intentPassInput);
				}
				else
				{
					int v1 = Integer.parseInt(editText1.getText().toString());
					int v2 = Integer.parseInt(editText2.getText().toString());
					Bundle bundlePass = new Bundle();
					bundlePass.putInt("V1", v1);
					bundlePass.putInt("V2", v2);
					bundlePass.putString("Ruta", null);
					Intent intentPassInput=new Intent(KeyGenerator.this, KeySaved.class);
					intentPassInput.putExtras(bundlePass);
					startActivity(intentPassInput);
				}
			}
		});

	};
	
	protected void onActivityResult(int requestCode, int resultCode, Intent data){
		if ((data == null) || (resultCode != RESULT_OK)){
			Log.i (LOGTAG, "data was null");
		    return;
		}
		BigInteger a = BigInteger.probablePrime(12, null);
		int v1 = a.intValue();
		BigInteger b = BigInteger.probablePrime(12, null);
		int v2 = b.intValue();
		Bundle bundlePass = new Bundle();
		bundlePass.putInt("V1", v1);
		bundlePass.putInt("V2", v2);
		bundlePass.putString("Ruta", data.getExtras().getString("Path"));
		Intent intentPassInput=new Intent(this, KeySaved.class);
		intentPassInput.putExtras(bundlePass);
		startActivity(intentPassInput);
	}
	
}
