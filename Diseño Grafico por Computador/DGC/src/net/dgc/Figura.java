package net.dgc;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

import android.util.FloatMath;
import android.util.Log;

public class Figura {
	public ArrayList<Float> Vertices = new ArrayList<Float>();
	public ArrayList<Integer> Aristas = new ArrayList<Integer>();
	
	public Figura(){
		
	}
	// TODO: Controlar que se meten vertices correctos(3 coordenadas)
	// TODO: Error cuando no sean correctos
	public Figura(float[] V, int[] A){
		for(int i= 0; i< V.length; i++) Vertices.add(V[i]);
		for(int i= 0; i< A.length; i++) Aristas.add(A[i]);
	}
	public Figura(Figura Original){
		for(int i= 0; i< Original.Vertices.size(); i++) Vertices.add(Original.Vertices.get(i));
		for(int i= 0; i< Original.Aristas.size(); i++) Aristas.add(Original.Aristas.get(i));
		IsRevolutioned = Original.IsRevolutioned;
	}
	
	@SuppressWarnings("unused")
	public Figura(String ruta) {
		try {
			Log.i("DGC", "Cargando figura");
			InputStream file = new FileInputStream(ruta);
			if (file != null) {
				InputStreamReader inputreader = new InputStreamReader(file);
				BufferedReader buffreader = new BufferedReader(inputreader);
				String line;
				line = buffreader.readLine();
				int Num = Integer.parseInt(line);
				Log.i("DGC", "Cargando figura");
				Log.i("DGC", "Puntos:" + Num);
				while (Num != 0) {
					line = buffreader.readLine();
					if (line.isEmpty()) {
						Log.e("DGC", "Faltan puntos! " + Num);
						return;
					}
					int Aux = line.indexOf(' ');
					int Aux2 = line.indexOf(' ', Aux + 1);
					String Temp = line.substring(0, Aux);
					Vertices.add(Float.valueOf(Temp));
					Temp = line.substring(Aux + 1, Aux2 - 1);
					Vertices.add(Float.valueOf(Temp));
					Temp = line.substring(Aux2 + 1, line.length() - 1);
					Vertices.add(Float.valueOf(Temp));
					Num--;
				}
				line = buffreader.readLine();
				Num = Integer.parseInt(line);
				Log.i("DGC", "Poligonos:" + Num);
				while (Num != 0) {
					line = buffreader.readLine();
					// Log.i("DGC", "Pol:" +line);
					if (line.isEmpty()) {
						Log.e("DGC", "Faltan puntos! " + Num);
						return;
					}
					int Aux = line.indexOf(' ');
					int Aux2 = line.indexOf(' ', Aux + 1);
					String Temp = line.substring(0, Aux);
					Aristas.add(Integer.valueOf(Temp));
					Temp = line.substring(Aux + 1, Aux2);
					Aristas.add(Integer.valueOf(Temp));
					Temp = line.substring(Aux2 + 1, line.length());
					Aristas.add(Integer.valueOf(Temp));
					Num--;
				}
				// while (line != null) {
				// texto = texto + line;
				// line = buffreader.readLine();
				// }
				file.close();
				return;
			} 
			else 
			{
				Log.i("DGC", "No se encontro  el fichero");
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	private float[] center() {
		float X = 0;
		float Y = 0;
		float Z = 0;
		int N = 0;
		for (int i = 0; i < Vertices.size(); i += 3) {
			X +=Vertices.get(i);
			Y +=Vertices.get(i + 1);
			Z +=Vertices.get(i + 2);
			N++;
		}
		if (N != 0) {
			X = X /(float) N;
			Y = Y /(float) N;
			Z = Z /(float) N;
		}
		return new float[] { X, Y, Z };
	}

	public float[] dimension(){
		float maxX = Vertices.get(0);
		float minX = maxX;
		float maxY = Vertices.get(1);
		float minY = maxY;
		float maxZ = Vertices.get(2);
		float minZ = maxZ;
		
		for(int i = 1; i < Vertices.size(); i+=3){
			if(Vertices.get(i)>maxX) maxX = Vertices.get(i);
			else if(Vertices.get(i)<minX)minX = Vertices.get(i);
			if(Vertices.get(i)>maxY) maxY = Vertices.get(i);
			else if(Vertices.get(i)<minY)minY = Vertices.get(i);
			if(Vertices.get(i)>maxZ) maxZ = Vertices.get(i);
			else if(Vertices.get(i)<minZ)minZ = Vertices.get(i);
		}
		
		return new float[] {minX, maxX, minY, maxY, minZ, maxZ};
	}
	
	public void traslate(float X, float Y, float Z){
		for (int i = 0; i <Vertices.size(); i += 3) {
			Vertices.set(i, Vertices.get(i) + X);
			Vertices.set(i + 1, Vertices.get(i + 1) + Y);
			Vertices.set(i + 2, Vertices.get(i + 2) + Z);
		}
	}
	
	public void addVertice(float X, float Y, float Z){
		Vertices.add(X);
		Vertices.add(Y);
		Vertices.add(Z);
	}
	
	public void addAristas(int A1, int A2, int A3){
		Aristas.add(A1);
		Aristas.add(A2);
		Aristas.add(A3);
	}
	
	public void addArista(int A){
		Aristas.add(A);
	}
	public void escalar(float E){
		for(int i= 0; i< Vertices.size(); i++) Vertices.set(i,Vertices.get(i)*E);
	}
	
	public boolean IsRevolutioned = false;
	
	public void revolucionar(int segmentos){
		if (IsRevolutioned)return;
		IsRevolutioned = true;
		int NumCoordenadas=Vertices.size();
		int NumVertices = NumCoordenadas/3;
		int UltimaArista = 0;
		int AristaAnterior = 0;
		Aristas.clear();
		if(Vertices.get(1)<Vertices.get(4))
		{
			for(int j = 1; j < segmentos; j++)
			{  // Por cada segmento
				float angle = j* 360/ segmentos;
				float c = (float) Math.cos(Math.toRadians(angle));
				float s = (float) Math.sin(Math.toRadians(angle));
				for (int i = 0; i < NumCoordenadas  ; i += 3) 
				{ // A�adir los puntos del nuevo segmento
					Vertices.add((float) (c*Vertices.get(i)-s*Vertices.get(i+2)));
					Vertices.add(Vertices.get(i + 1));
					Vertices.add((float) (s*Vertices.get(i)+ c*Vertices.get(i+2)));
				}
				
				UltimaArista = NumVertices*(j);
				AristaAnterior = NumVertices*(j-1);
				
				for(int i = 1; i < NumVertices-1; i++)
				{
					Aristas.add(AristaAnterior+i);	// Triangulo 1
					Aristas.add(AristaAnterior+i+1);
					Aristas.add(UltimaArista+i+1);
	
					Aristas.add(UltimaArista+i); // Triangulo 2
					Aristas.add(AristaAnterior+i);
					Aristas.add(UltimaArista+i+1);
				}
			}
			// Ahora toca cerrar la figura
			
			for(int i = 0; i < NumVertices-1; i++)
			{
				Aristas.add(UltimaArista+i);	// Triangulo 1
				Aristas.add(UltimaArista+i+1);
				Aristas.add(i+1);
	
				Aristas.add(i); // Triangulo 2
				Aristas.add(UltimaArista+i);
				Aristas.add(i+1);
			}
			traslate(0,0,200f);
		}
		else
		{
			for(int j = 1; j < segmentos; j++)
			{  // Por cada segmento
				float angle = j* 360/ segmentos;
				float c = (float) Math.cos(Math.toRadians(angle));
				float s = (float) Math.sin(Math.toRadians(angle));
				for (int i = 0; i < NumCoordenadas  ; i += 3) 
				{ // A�adir los puntos del nuevo segmento
					Vertices.add((float) (c*Vertices.get(i)-s*Vertices.get(i+2)));
					Vertices.add(Vertices.get(i + 1));
					Vertices.add((float) (s*Vertices.get(i)+ c*Vertices.get(i+2)));
				}
				
				UltimaArista = NumVertices*(j);
				AristaAnterior = NumVertices*(j-1);
				
				for(int i = 0; i < NumVertices-1; i++)
				{
					Aristas.add(AristaAnterior+i);	// Triangulo 1
					Aristas.add(UltimaArista+i);
					Aristas.add(AristaAnterior+i+1);

					Aristas.add(UltimaArista+i); // Triangulo 2
					Aristas.add(UltimaArista+i+1);
					Aristas.add(AristaAnterior+i+1);
				}
			}
			// Ahora toca cerrar la figura
			
			for(int i = 0; i < NumVertices-1; i++)
			{
				Aristas.add(UltimaArista+i);	// Triangulo 1
				Aristas.add(i);
				Aristas.add(UltimaArista+i+1);
	
				Aristas.add(i); // Triangulo 2
				Aristas.add(i+1);
				Aristas.add(UltimaArista+i+1);
			}

			traslate(0,0,200f);
		}
	}

}
