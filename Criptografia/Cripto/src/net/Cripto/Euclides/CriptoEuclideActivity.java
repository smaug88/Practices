package net.Cripto.Euclides;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.util.Log;

public class CriptoEuclideActivity extends Activity {
	private static final String LOGTAG = "LogEuclide :";
	
	@Override
	 public void onCreate(Bundle savedInstanceState) {
			Log.i(LOGTAG, "Creado");
	        super.onCreate(savedInstanceState);
	        Log.i(LOGTAG, "Intance State Salvado");
	        setContentView(net.Cripto.R.layout.euclides);
	        Log.i(LOGTAG, "Layout asignado");
	        final Button ButtonEuclideanOk = (Button) findViewById(net.Cripto.R.id.ButtonEuclideanOk);
	        final Button ButtonEuclideExtended = (Button) findViewById(net.Cripto.R.id.ButtonEuclideExtended);
	        final Button ButtonEuclideInverted = (Button) findViewById(net.Cripto.R.id.ButtonEuclideInverted);
	        Log.i(LOGTAG, "Boton asignado");
	        final EditText EditTextEuclideNumberA = (EditText) findViewById(net.Cripto.R.id.EditTextEuclideNumberA);
	        Log.i(LOGTAG, "Campo A Asignado");
	        final EditText EditTextEuclideNumberB = (EditText) findViewById(net.Cripto.R.id.EditTextEuclideNumberB);
	        Log.i(LOGTAG, "Campo B Asignado");
	        ButtonEuclideanOk.setOnClickListener(new OnClickListener() {
				public void onClick(View arg0) {
					Log.i(LOGTAG, "Se ha clickado");
					Intent intent = new Intent(CriptoEuclideActivity.this, CriptoEuclideResultActivity.class);
					Bundle BudleEuclide = new Bundle();
					BudleEuclide.putInt("A", Integer.valueOf(EditTextEuclideNumberA.getText().toString()));
					BudleEuclide.putInt("B", Integer.valueOf(EditTextEuclideNumberB.getText().toString()));
					BudleEuclide.putInt("Option", 0); // Option = 0 means, Euclide's Method will be applied.
					intent.putExtras(BudleEuclide);
					Log.i(LOGTAG, "Se ha creado el Intent");
					startActivity(intent);
				}
	        }); 
	        ButtonEuclideExtended.setOnClickListener(new OnClickListener() {
				public void onClick(View arg0) {
					Log.i(LOGTAG, "Se ha clickado");
					Intent intent = new Intent(CriptoEuclideActivity.this, CriptoEuclideResultActivity.class);
					Bundle BudleEuclide = new Bundle();
					BudleEuclide.putInt("A", Integer.valueOf(EditTextEuclideNumberA.getText().toString()));
					BudleEuclide.putInt("B", Integer.valueOf(EditTextEuclideNumberB.getText().toString()));
					BudleEuclide.putInt("Option", 1); // Option = 1 means, Euclide's EXTENDED Method will be applied.
					intent.putExtras(BudleEuclide);
					Log.i(LOGTAG, "Se ha creado el Intent");
					startActivity(intent);
				}
	        }); 
	        ButtonEuclideInverted.setOnClickListener(new OnClickListener() {
				public void onClick(View arg0) {
					Log.i(LOGTAG, "Se ha clickado");
					Intent intent = new Intent(CriptoEuclideActivity.this, CriptoEuclideResultActivity.class);
					Bundle BudleEuclide = new Bundle();
					BudleEuclide.putInt("A", Integer.valueOf(EditTextEuclideNumberA.getText().toString()));
					BudleEuclide.putInt("B", Integer.valueOf(EditTextEuclideNumberB.getText().toString()));
					BudleEuclide.putInt("Option", 2); // Option = 0 means, Euclide's INVERTED Method will be applied.
					intent.putExtras(BudleEuclide);
					Log.i(LOGTAG, "Se ha creado el Intent");
					startActivity(intent);
				}
	        }); 
}
}
