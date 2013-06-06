package net.dgc;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.Window;
import android.view.WindowManager;

public class DGCActivity extends Activity {
    Lienzo drawView;
	private float Proporcion = 50;
	static private Bundle bundle = null;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Set full screen view
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, 
                                         WindowManager.LayoutParams.FLAG_FULLSCREEN);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        Figura Cubo = new Figura(
        		new float[]{-1, -1, 3,
        					-1, 1, 3,
        					 1, 1, 3,
        					 1, -1, 3,
        					-1, -1, 1,
        					-1, 1, 1,
        					 1, 1, 1,
        					 1, -1, 1 
        					 }, 
        		new int[]  {0,3,1,
        					1,3,2,
        					4,0,5,
        					0,1,5,
        					6,7,4,
        					4,5,6,
        					2,3,7,
        					7,6,2,
        					4,7,0,
        					0,7,3,
        					2,5,1,
        					6,5,2});
        Cubo.escalar(Proporcion);
        
        Figura Cilindro = new Figura(
        		new float[]{ 0, 2, 0,
        					 1, 1, 1,
        				     1,-1, 1,
        				     0,-2, 0},
        		new int[]{ 0, 1});
        Cilindro.escalar(Proporcion);
        Cilindro.revolucionar(10);
        
        Figura fichero = new Figura("Figuras\figura.dat");
        fichero.escalar(Proporcion);
        
        drawView = new Lienzo(this);
        drawView.addFigura(Cubo);
        drawView.addFigura(Cilindro);
        drawView.addFigura(fichero);
        setContentView(drawView);
        drawView.requestFocus();
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu, menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) 
        {
        	// Activamos o desactivamos la traslacion con un dedo
        case R.id.tras_uno:
        	drawView.setTraslateValue(1);
        	break;
            // Activamos o desactivamos la traslacion con dos dedos
        case R.id.tras_dos:
            drawView.setTraslateValue(2);
        	break;
            // Activamos o desactivamos la rotacion con un dedo
        case R.id.rot_uno:
        	drawView.setRotateValue(1);
        	break;
            // Activamos o desactivamos la rotacion con dos dedos
        case R.id.rot_dos:
            drawView.setRotateValue(2);
        	break;
            // Activamos o desactivamos el escalado con un dedo
        case R.id.esc_uno:
        	drawView.setEscalateValue(1);
        	break;
            // Activamos o desactivamos el escalado con dos dedos
        case R.id.esc_dos:
    		drawView.setEscalateValue(2);
        	break;
        	// Seleccion de figura a trabajar
            // Cargamos la figura basica
        case R.id.basico:
        	drawView.setFigura(0);
           	break;
            // Cargamos la figura de revolucion
       case R.id.revolucion:
       		drawView.setFigura(1);
            break;
            // Cargamos la figura de un fichero
        case R.id.figura:
        	drawView.setFigura(2);
        	break;
        	// Dibujarmos una nueva figura por revolucion
        case R.id.insertar:
        	if(drawView.amountFiguras()< 4)drawView.addFigura(new Figura());
        	drawView.switchInsertar();
        	drawView.setFigura(3);
        	break;
        	// Seleccion de los ejes en los que se trabajara
            // Escogemos los ejes X-Y
        case R.id.ejexy:
        	drawView.setAxisValue(0);
        	break;
            // Escogemos los ejes X-Z
        case R.id.ejexz:
    		drawView.setAxisValue(1);
        	break;
            // Activamos o desactivamos la traslacion
            // Escogemos los ejes Y-Z
        case R.id.ejeyz:
    		drawView.setAxisValue(2);
        	break;
        	// Seleccion de las opciones activas
            // Activamos o desactivamos el Z-buffer
        case R.id.zbuffer:
        	drawView.setZBufferValue(1);
        	break;
            // Activamos o desactivamos la perspectiva
        case R.id.perspectiva:
        	drawView.setPerspectiveValue(1);
        	break;
            // Activamos o desactivamos el relleno
        case R.id.relleno:
        	drawView.setFillValue(1);
        	break;
    	case R.id.proyeccion:
            // Activamos o desactivamos la proyeccion
    		drawView.switchProjection();
    		break;
    	case R.id.foco:
    		// Trabajamos con el foco
    		drawView.switchFocus();
    		break;
    	case R.id.iluminacion:
    		Intent intentIluminacion= new Intent(DGCActivity.this, OpcionesActivity.class);
    		bundle = new Bundle();
    		float[] temp = drawView.getIluminationConstants();
    		bundle.putFloat("ambiental", temp[0]);
    		bundle.putFloat("reflection", temp[1]);
    		bundle.putFloat("focus", temp[2]);
    		intentIluminacion.putExtras(bundle);
    		startActivityForResult(intentIluminacion,1);
    		break;
    	}
        return true;
    }
    protected void onActivityResult(int requestCode, int resultCode, Intent data){
		if ((data == null) || (resultCode != RESULT_OK)){
		    return;
		}
		drawView.setIluminationConstants(data.getExtras().getFloat("ambiental"), 
										 data.getExtras().getFloat("reflection"),
										 data.getExtras().getFloat("focus"));
	}
    
}
