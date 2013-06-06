package net.Cripto.Euclides;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;


public class CriptoEuclideResultActivity extends Activity {
	@Override
	public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(net.Cripto.R.layout.euclides_result);
        final TextView TextViewEuclideResult= (TextView)findViewById(net.Cripto.R.id.textViewEuclidesResult);
        Bundle BundleIn = getIntent().getExtras();
        switch(BundleIn.getInt("Option")){
        	case 0 :
        		int Result = CriptoEuclidesFunctions.a_Euclides(BundleIn.getInt("A"), BundleIn.getInt("B"));
        		TextViewEuclideResult.setText("Segun el metodo de Euclide para " 
						+ BundleIn.getInt("A") 
						+ " y "
						+ BundleIn.getInt("B")
						+ "\nel maximo comun divisor es "
						+ Result);
        		break;
        	case 1:
        		int[] ResultExtended = CriptoEuclidesFunctions.ea_Euclides(BundleIn.getInt("A"), BundleIn.getInt("B"));
        		TextViewEuclideResult.setText("Segun el metodo de Euclide extendedido siendo\nA = " 
						+ BundleIn.getInt("A") 
						+ " y B = "
						+ BundleIn.getInt("B")
						+ "\ny siendo su Maximo Comun Divisor, C = "
						+ ResultExtended[0]
						+ "\nEntonces:\n"
						+ "A*(" + ResultExtended[1] + ") + B*(" + ResultExtended[2] + ") = C"
						);
        	break;
        	
        	case 2:
        		int ResultEuclideInverted = CriptoEuclidesFunctions.MOD_MULT_Inverse(BundleIn.getInt("A"), BundleIn.getInt("B"));
				if(ResultEuclideInverted == -1){
					TextViewEuclideResult.setText(
					"NO existe INVERSO MODULAR para " +
					+ BundleIn.getInt("A") 
					+ " y "
				    + BundleIn.getInt("B") 
					);
				}else{
					TextViewEuclideResult.setText(
					"El inverso modular para " +
					+ BundleIn.getInt("A") 
					+ " y "
				    + BundleIn.getInt("B") 
				    + "\nEs igual a  "
				    + ResultEuclideInverted
					);
				}
        	break;
        
        }
        
	}
}
