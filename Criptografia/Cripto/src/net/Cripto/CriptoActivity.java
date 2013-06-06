package net.Cripto;
 
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.util.Log;
import net.Cripto.Euclides.*;
import net.Cripto.KeyGen.KeyGenerator;
import net.Cripto.RSA.RSAActivity;
import net.Cripto.DES.*;

public class CriptoActivity extends Activity {
    private static final String LOGTAG = "LogMain :";
	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		final Button ButtonMainEuclide = (Button) findViewById(R.id.ButtonMainEuclide);
		ButtonMainEuclide.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				Intent intent = new Intent(CriptoActivity.this, CriptoEuclideActivity.class);
				startActivity(intent);
			}
		});
		final Button ButtonMainDES = (Button) findViewById(R.id.ButtonMainDES);
		ButtonMainDES.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				Intent intent = new Intent(CriptoActivity.this, DESActivity.class);
				startActivity(intent);
			}
		});
		final Button ButtonMainRSA = (Button) findViewById(net.Cripto.R.id.ButtonMainRSA);
		ButtonMainRSA.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				Intent intent = new Intent(CriptoActivity.this, RSAActivity.class);
				startActivity(intent);
			}
		});
		final Button ButtonMainKey = (Button) findViewById(net.Cripto.R.id.ButtonMainKey);
		ButtonMainKey.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				Log.i(LOGTAG, "Direcci—n: KeyGenerator");
				Intent intent = new Intent(CriptoActivity.this, KeyGenerator.class);
				startActivity(intent);
			}
		});
		
	}
	
	
}