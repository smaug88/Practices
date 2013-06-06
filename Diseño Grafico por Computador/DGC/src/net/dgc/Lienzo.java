package net.dgc;


import java.util.ArrayList;
import java.lang.Math;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.FloatMath;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;

public class Lienzo extends View implements OnTouchListener 
{
	Paint paint = new Paint();
	Bitmap lienzoTemp;
	private float oldX = 0;
	private float oldY = 0;
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Los valores en entero reperesentan si estan activos o no  *
	 * y en algunos casos, si se utilizan con uno o dos dedos    *
	 * 		0: inactivo											 *
	 * 		1: con un dedo										 *
	 * 		2: con dos dedos									 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	private int rotate = 2;
	private int traslate = 1;
	private int escalate = 0;
	private boolean zbuffer = true;
	private boolean fill = false;
	private boolean perspective = true;	
	private boolean insertarPuntos = false;
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Variable que establece los ejes de coordenadas en los que *
	 * se muestra y trabaja:									 *
	 * 		0: eje X-Y											 *
	 * 		1: eje X-Z											 *
	 * 		2: eje Y-Z											 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	private int axis = 0;

	/* * * * * * * * * * * * *
	 * Variables de control  *
	 * * * * * * * * * * * * */
	private float movX = 0;
	private float movY = 0;
	private float movZ = 0;
	private float rotX = 0;
	private float rotY = 0;
	private float rotZ = 0;
	private float scalX = 1;
	private float scalY = 1;
	private float scalZ = 1;
	private float Distance = 100;
	private boolean IsProjecting = false;
	private float minZ, maxZ;
	private float ZLimit=-50f;
	private boolean mode_focus = false;
	/* * * * * * * * * * * * * * * * * *
	 * Variables de gestion de figuras *
	 * * * * * * * * * * * * * * * * * */
	private ArrayList<Figura> Figuras = new ArrayList<Figura>();
	private ArrayList<Figura> InitFiguras = new ArrayList<Figura>();
	private int indice = 0;
	private float[][] ZBuffer = new float[1][1];
	private float[] M = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 };

	/* * * * * * * * * * * * * * * * * * * *
	 * Variables de gestion de intensidad  *
	 * * * * * * * * * * * * * * * * * * * */
	
	private int nFocos = 1;
	private float Focos[][];
	private float I_a = 1;
	private float I_l[];
	private float K_a = 1;
	private float K_d = 2;
	private float K_s = 2;
	private float K = 0;
	private float n = 3;
	
	private int[] Colores = new int[] {Color.RED, Color.RED, 
									   Color.GREEN, Color.GREEN, 
									   Color.BLUE, Color.BLUE,
									   Color.YELLOW, Color.YELLOW,
									   Color.GRAY, Color.GRAY,
									   Color.WHITE, Color.WHITE};
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * addFigura: se a�ade una figura a la lista de figuras disponibles  *
	 * 	- Figura: figura a a�adir										 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	public int addFigura(Figura F)
	{
		int Indice = InitFiguras.size();
		InitFiguras.add(F);
		//Log.v("DGC","Se ha a�adido una figura");
		invalidate();
		return Indice;
	}

	/* * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * paintTriangle: algoritmo de pintado de triangulos *
	 * 	- Ax, Ay: punto A								 *
	 *  - Bx, By: punto B								 *
	 *  - Cx, Cy: punto C								 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * */
	private void paintTriangle(int Ax, int Ay, float Az, int Bx, int By,
			float Bz, int Cx, int Cy, float Cz, Canvas canvas) 
	{
		if(((Ax==Bx)&&(Ay==By)&&(Az==Bz))||((Ax==Cx)&&(Cy==By)&&(Cz==Bz))||((Cx==Bx)&&(Cy==By)&&(Cz==Bz)))
			return;
		if(!fill) // si no vamos a rellenar, pintamos solo los bordes
		{
			canvas.drawLine(Ax, Ay, Bx, By, paint);
			canvas.drawLine(Cx, Cy, Bx, By, paint);
			canvas.drawLine(Ax, Ay, Cx, Cy, paint);
			float Nx = (By-Ay)*(Cz-Az) - (Bz-Az)*(Cy-Ay);
			float Ny = (Bz-Az)*(Cx-Ax) - (Bx-Ax)*(Cz-Az);
			float Nz = (Bx-Ax)*(Cy-Ay) - (By-Ay)*(Cx-Ax);
			float NMod = FloatMath.sqrt(Nx*Nx+Ny*Ny+Nz*Nz);
			canvas.drawLine((Ax+Bx+Cx)/3, (Ay+By+Cy)/3, (Ax+Bx+Cx)/3+30*Nx/NMod, (Ay+By+Cy)/3+30*Ny/NMod, paint);
			canvas.drawCircle((Ax+Bx+Cx)/3+30*Nx/NMod, (Ay+By+Cy)/3+30*Ny/NMod, 5, paint);
			return;
		}
		minZ = Az;
		maxZ = Az;
		if(Bz < minZ) minZ = Bz;
		if(Cz < minZ) minZ = Cz;
		if(Bz > maxZ) maxZ = Bz;
		if(Cz > maxZ) maxZ = Cz;
		int x0, y0, x1, y1, x2, y2;
		float z0, z1, z2;
		// V = B-A    W = C-A
		float Nx = (By-Ay)*(Cz-Az) - (Bz-Az)*(Cy-Ay);
		float Ny = -(Bx-Ax)*(Cz-Az) + (Bz-Az)*(Cx-Ax);
		float Nz = (Bx-Ax)*(Cy-Ay) - (By-Ay)*(Cx-Ax);
		float NMod = FloatMath.sqrt(Nx*Nx+Ny*Ny+Nz*Nz);
		int green = Color.green(paint.getColor());
		int red = Color.red(paint.getColor());
		int blue = Color.blue(paint.getColor());
		
		// Ordenamos los puntos de menor a mayor
		if (Ay < Cy) 
		{	
			if (Ay < By) 
			{
				x0 = Ax;
				y0 = Ay;
				z0 = Az;
				if (By < Cy) 
				{
					x1 = Bx;
					y1 = By;
					z1 = Bz;

					x2 = Cx;
					y2 = Cy;
					z2 = Cz;
				} 
				else 
				{
					x1 = Cx;
					y1 = Cy;
					z1 = Cz;

					x2 = Bx;
					y2 = By;
					z2 = Bz;
				}
			} 
			else 
			{
				x0 = Bx;
				y0 = By;
				z0 = Bz;

				x1 = Ax;
				y1 = Ay;
				z1 = Az;

				x2 = Cx;
				y2 = Cy;
				z2 = Cz;
			}
		} 
		else 
		{
			if (Cy < By) 
			{
				x0 = Cx;
				y0 = Cy;
				z0 = Cz;
				if (Ay < By) 
				{
					x1 = Ax;
					y1 = Ay;
					z1 = Az;

					x2 = Bx;
					y2 = By;
					z2 = Bz;
				} 
				else 
				{
					x1 = Bx;
					y1 = By;
					z1 = Bz;

					x2 = Ax;
					y2 = Ay;
					z2 = Az;
				}
			} 
			else 
			{
				x0 = Bx;
				y0 = By;
				z0 = Bz;

				x1 = Cx;
				y1 = Cy;
				z1 = Cz;

				x2 = Ax;
				y2 = Ay;
				z2 = Az;
			}
		}
		int y = y0;
		float alfax1, alfax2, alfaz1, alfaz2;

		if (y0 == y1) 
		{
			drawLine(x0, x1, y0, y1, z0, z1,  
					Nx, Ny, Nz, NMod, green, red, blue, canvas);
			y = y1;
		} 
		else 
		{
			alfax1 = (float)(x1-x0)/(float)(y1-y0);
			alfaz1 = (z1-z0)/(float)(y1-y0);
			alfax2 = (float)(x2-x0)/(float)(y2-y0);
			alfaz2 = (z2-z0)/(float)(y2-y0);
			
			while (y != y1) 
			{
				drawLine((int) ((y - y0) * alfax1 + x0), 
						(int) ((y - y0)	* alfax2 + x0), 
						y,
						y,
						(y - y0) * alfaz1 + z0, 
						(y - y0) * alfaz2 + z0, 
						Nx, Ny, Nz, NMod, green, red, blue, 
						canvas);
				y++;
			}
		}
		if (y2 == y1) 
		{
			drawLine(x2, x1, y2, y1, z2, z1,  
					Nx, Ny, Nz, NMod, green, red, blue, canvas);
		} 
		else 
		{ 
			alfax1 = (float)(x2-x1)/(float)(y2-y1);
			alfaz1 = (z2-z1)/(float)(y2-y1);
			alfax2 = (float)(x2-x0)/(float)(y2-y0);
			alfaz2 = (z2-z0)/(float)(y2-y0);

			while (y != y2)
			{
				drawLine((int) ((y - y1) * alfax1 + x1), 
						 (int) ((y - y0) * alfax2 + x0), 
						 y, y, (y - y1) * alfaz1 + z1, 
						 (y - y0) * alfaz2 + z0,  
						 Nx, Ny, Nz, NMod, green, red, blue, canvas);
				y++;
			}
		}
	}

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * drawLine: pinta una linea									 *
	 * 	- x0: x inicial 											 *
	 * 	- x1: x final 												 *
	 * 	- y0: y inicial 											 *
	 * 	- y1: y final  												 *
	 * 	- z0: z inicial 											 *
	 * 	- z1: z final 												 *
	 * 	- d: distancia entre el observador y el plano de proyeccion  *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	private void drawLine(int x0, int x1, int y0, int y1, float z0, float z1, 
						float Nx, float Ny, float Nz, float NMod, int green, int red, int blue, Canvas canvas) 
	{
		// Algoritmo de Bresenhan
		// calculamos el gradiente para hallar la z de cada punto
		float alfa;
		boolean chivato = true;
		if (y1 == y0) 
		{
			alfa = (z1 - z0) /(float) (x1 - x0);
			chivato = false;
		} 
		else
			alfa = (z1 - z0) / (float)(y1 - y0);

		int x, y, p, A, B, stepx, stepy;
		int dx = (x1 - x0);
		int dy = (y1 - y0);

		// determinamos que punto usamos para empezar y cual para terminar
		if (dy < 0) 
		{
			stepy = -1;
			dy = -dy;
		} 
		else
			stepy = 1;
		if (dx < 0) 
		{
			stepx = -1;
			dx = -dx;
		} 
		else
			stepx = 1;

		x = x0;
		y = y0;
		drawPoint(x0, y0, z0, Nx, Ny, Nz, NMod,green, red, blue, canvas);
		// iteramos hasta llegar al extremo de la linea
		if (dx > dy) 
		{
			p = 2 * dy - dx;
			A = 2 * dy;
			B = 2 * (dy - dx);
			while (x != x1) 
			{
				x += stepx;
				if (p < 0)
					p += A;
				else 
				{
					y += stepy;
					p += B;
				}
				if (chivato)
				{
					drawPoint(x, y, ((float)(y - y0)) * alfa + z0, Nx, Ny, Nz, NMod,green, red, blue, canvas);
				}
				else
				{
					drawPoint(x, y, ((float)(x - x0)) * alfa + z0, Nx, Ny, Nz, NMod,green, red, blue, canvas);
				}
			}
		} 
		else 
		{
			p = 2 * dx - dy;
			A = 2 * dx;
			B = 2 * (dx - dy);
			while (y != y1) 
			{
				y += stepy;
				if (p < 0)
					p += A;
				else 
				{
					x += stepx;
					p += B;
				}
				if (chivato)
				{
					drawPoint(x, y, ((float)(y - y0)) * alfa + z0, Nx, Ny, Nz, NMod,green, red, blue, canvas);
				}
				else
				{
					drawPoint(x, y, ((float)(x - x0)) * alfa + z0, Nx, Ny, Nz, NMod,green, red, blue, canvas);
				}
			}
		}
		drawPoint(x1, y1, z1, Nx, Ny, Nz, NMod,green, red, blue, canvas);
	}

	/* * * * * * * * * * * * * * * * * * * * * * * *
	 * drawPoint: pinta un punto				   *
	 * 	- X, Y, Z: coordenadas del punto a pointar *
	 * 	- canvas: entorno donde pintaremos         *
	 * * * * * * * * * * * * * * * * * * * * * * * */
	
	private void drawPoint(int X, int Y, float Z, float Nx, float Ny, float Nz, float NMod, int green, int red, int blue, Canvas canvas) 
	{
		if (checkZBuffer(X, Y, Z)) 
		{
			float I = intensidad(X,Y,(int)Z,Nx,Ny,Nz,NMod);
			green*=I;
			red*=I;
			blue*=I;
			paint.setARGB(255, red, green, blue);
			//canvas.drawPoint(X, Y, paint);
			lienzoTemp.setPixel(X, Y, paint.getColor());
		}
	}

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * checkZBuffer: comprobamos si el punto ha de ser pintado o no  *
	 *  - X, Y, Z: punto a comprobar								 *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	private boolean checkZBuffer(int X, int Y, float Z) 
	{
		if(Z<ZLimit)
			return false;
		if (X >= 0 && Y >= 0) 
		{
			if(!zbuffer)
				return true;
			if (Y < ZBuffer.length && X < ZBuffer[0].length) 
			{
				if (ZBuffer[Y][X] > Z) 
				{ // Si en ZBuffer[X,Y] -> la z es menor
					ZBuffer[Y][X] = Z;
					return true;
				}
			}
		}
		return false;
	}

	/* * * * * * * * * * * * * * * * * * * * * * * * *
	 * clearZBuffer: reseteamos la matriz de ZBuffer *
	 * 	- Height, Width: dimensiones de la matriz	 *
	 * * * * * * * * * * * * * * * * * * * * * * * * */
	
	private void clearZBuffer(int Height, int Width) 
	{
		// El ZBuffer tiene que ser inicializado

		if ((ZBuffer.length != Height) || (ZBuffer[0].length != Width)) 
		{
			ZBuffer = new float[Height][Width];
		}
		
		for (int j = 0; j < ZBuffer.length; j++)
			for (int i = 0; i < ZBuffer[0].length; i++) 
			{
				ZBuffer[j][i] = Float.POSITIVE_INFINITY;
			}
	}
	
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Intensidad: calcula la intensidad de color del punto obtenido.  *
	 * 	- x, y, z: Coordenadas del punto							   *
	 *  - Nx, Ny, Nz: Normal al punto								   *
	 *  - NMod: Modulo de la normal									   *
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
	
	private float intensidad(int x, int y, int z, float Nx, float Ny, float Nz, float NMod)
	{
		float cose[] = new float[nFocos];
		float cosn[] = new float[nFocos];
		float mod[] = new float[nFocos];
		for(int i=0; i<nFocos; i++)
		{
			mod[i]=FloatMath.sqrt((Focos[i][0]-x)*(Focos[i][0]-x)+
					 			  (Focos[i][1]-y)*(Focos[i][1]-y)+
					 			  (Focos[i][2]-z)*(Focos[i][2]-z));
			cose[i] = (Nx*(Focos[i][0]-x)+Ny*(Focos[i][1]-y)+Nz*(Focos[i][2]-z))/(NMod*mod[i]);
			cosn[i] = (Nx*(Focos[i][0]-x)+Ny*(Focos[i][1]-y)+Nz*(Focos[i][2]-z))/(NMod*mod[i]);
			if(cosn[i]==0)
			{
				continue;
			}
			for(int j=1; j<n; j++)
			{
				cosn[i]*=cosn[i];
			}
		}
		float sumatorio=0;
		
		for(int i=0; i<nFocos; i++)
		{
			if(Nx*(Focos[i][0]-x)+Ny*(Focos[i][1]-y)+Nz*(Focos[i][2]-z)>0)
				sumatorio+=(I_l[i]/(K+mod[i]))*(K_d*cose[i] + K_s*cosn[i]);
			//Log.i("DGC", "Nx*(Focos[i][0]-x)+Ny*(Focos[i][1]-y)+Nz*(Focos[i][2]-z): "+(Nx*(Focos[i][0]-x)+Ny*(Focos[i][1]-y)+Nz*(Focos[i][2]-z)));
		}
		if(I_a*K_a + sumatorio > 1)
			return 1;
		if(I_a*K_a + sumatorio < 0)
			return 0;
		return (I_a*K_a + sumatorio);
	}
	
	private void drawTriangles(Canvas canvas, int Indice) 
	{

		int i = 0;
		while (i < Figuras.get(Indice).Aristas.size()) 
		{
			paint.setColor(Colores[(i/3)%Colores.length]);
			paintTriangle(Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i) * 3).intValue(),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i) * 3 + 1).intValue(),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i) * 3 + 2),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i + 1) * 3).intValue(),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i + 1) * 3 + 1).intValue(),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i + 1) * 3 + 2),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i + 2) * 3).intValue(),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i + 2) * 3 + 1).intValue(),
						  Figuras.get(Indice).Vertices.get(Figuras.get(Indice).Aristas.get(i + 2) * 3 + 2),
						  canvas);
			i += 3;
		}
	}

	/* * * * * * * * * * * * * * * * * * * * *
	 * rotate: rota la figura				 *
	 * parametros:							 *
	 * 		- angle: angulo de rotacion		 *
	 * 		- X: esta variable se modifica	 *
	 * 		- Y: esta variable se modifica	 *
	 * 		- Z: esta variable se modifica	 *
	 * 		- Indice: figura que se modifica *
	 * * * * * * * * * * * * * * * * * * * * */
	
	private void rotate(double angle, int X, int Y, int Z, int Indice) 
	{
		@SuppressWarnings("unchecked")
		ArrayList<Float> VertTemp = (ArrayList<Float>) Figuras.get(Indice).Vertices.clone();

		float c = (float) Math.cos(Math.toRadians(angle));
		float s = (float) Math.sin(Math.toRadians(angle));

		for (int i = 0; i < Figuras.get(Indice).Vertices.size(); i += 3) 
		{
			Figuras.get(Indice).Vertices.set(i, (float) ((X * X * (1 - c) + c) * VertTemp.get(i)
					+ (X * Y * (1 - c) - Z * s) * VertTemp.get(i + 1) 
					+ (X * Z* (1 - c) + Y * s)* VertTemp.get(i + 2)));
			Figuras.get(Indice).Vertices.set(i + 1,
					(float) ((Y * X * (1 - c) + Z * s) * VertTemp.get(i)
							+ (Y * Y * (1 - c) + c) * VertTemp.get(i + 1) 
							+ (Y * Z * (1 - c) - X * s) * VertTemp.get(i + 2)));
			Figuras.get(Indice).Vertices.set(i + 2,
					(float) ((X * Z * (1 - c) - Y * s) * VertTemp.get(i)
							+ (Y * Z * (1 - c) + X * s) * VertTemp.get(i + 1)
							+ (Z * Z * (1 - c) + c) * VertTemp.get(i + 2)));
		}
	}

	/* * * * * * * * * * * * * * * * * * * * *
	 * scalate: escala la figura			 *
	 * parametros:							 *
	 * 		- X: esta variable se modifica	 *
	 * 		- Y: esta variable se modifica	 *
	 * 		- Z: esta variable se modifica	 *
	 * 		- Indice: figura que se modifica *
	 * * * * * * * * * * * * * * * * * * * * */
	
	private void scalate(float X, float Y, float Z, int Indice) 
	{
		@SuppressWarnings("unchecked")
		ArrayList<Float> VertTemp = (ArrayList<Float>) Figuras.get(Indice).Vertices.clone();

		for (int i = 0; i < Figuras.get(Indice).Vertices.size(); i += 3) 
		{
			Figuras.get(Indice).Vertices.set(i, (float) (X * VertTemp.get(i)));
			Figuras.get(Indice).Vertices.set(i + 1, (float) (Y * VertTemp.get(i + 1)));
			Figuras.get(Indice).Vertices.set(i + 2, (float) (Z * VertTemp.get(i + 2)));
		}
	}
	
	private void lookAt(float eyeX, float eyeY, float eyeZ, float centerX,
			float centerY, float centerZ, float upX, float upY, float upZ) 
	{
		// Formacion de la matriz de perspectiva segun:
		// http://pyopengl.sourceforge.net/documentation/manual/gluLookAt.3G.htm

		float[] F = { centerX - eyeX, centerY - eyeY, centerZ - eyeZ };
		float[] Up = { upX, upY, upZ };
		float NormF = (float) Math.sqrt(F[0] * F[0] + F[1] * F[1] + F[2] * F[2]);
		float NormUp = (float) Math.sqrt(Up[0] * Up[0] + Up[1] * Up[1] + Up[2] * Up[2]);
		for (int i = 0; i < 3; i++) 
		{
			F[i] = F[i] / NormF;
			Up[i] = Up[i] / NormUp;
		}
		float[] s = { 0, 0, 0 };
		float[] u = { 0, 0, 0 };
		for (int i = 0; i < 3; i++)
			s[i] = F[i] * Up[i];
		for (int i = 0; i < 3; i++)
			u[i] = s[i] * F[i];
		M[0] = s[0];
		M[1] = s[1];
		M[2] = s[2];
		M[0] = u[0];
		M[1] = u[1];
		M[2] = u[2];
		M[0] = -F[0];
		M[1] = -F[1];
		M[2] = -F[2];
	}

	private void perspectiva() 
	{
		/*
		 * float[] VertTemp = Vertices.clone(); for (int i = 0; i <
		 * Vertices.length; i += 3) { Vertices[i] = M[0] * Vertices[i] + M[1] *
		 * Vertices[i] + M[2] Vertices[i]; Vertices[i + 1] = M[4] * Vertices[i +
		 * 1] + M[5] * Vertices[i + 1] + M[6] * Vertices[i + 1]; Vertices[i + 2]
		 * = M[8] * Vertices[i + 2] + M[9] * Vertices[i + 2] + M[10] *
		 * Vertices[i + 2];
		 * 
		 * }
		 */
	}

	private void proyeccion(float d) 
	{
		for (int Indice = 0; Indice < Figuras.size(); Indice ++)
		{
			for (int i = 0; i < Figuras.get(Indice).Vertices.size(); i += 3) 
			{			
				Figuras.get(Indice).Vertices.set(i,
						(float) Figuras.get(Indice).Vertices.get(i)*d/(Figuras.get(Indice).Vertices.get(i+2)));
				Figuras.get(Indice).Vertices.set(i+1, 
						(float) Figuras.get(Indice).Vertices.get(i+1)*d/(Figuras.get(Indice).Vertices.get(i+2)));
			}
		}
	}

	private void translate(float X, float Y, float Z, int Indice) 
	{
		for (int i = 0; i < Figuras.get(Indice).Vertices.size(); i += 3) 
		{
			Figuras.get(Indice).Vertices.set(i, Figuras.get(Indice).Vertices.get(i) + X);
			Figuras.get(Indice).Vertices.set(i + 1, Figuras.get(Indice).Vertices.get(i + 1) + Y);
			Figuras.get(Indice).Vertices.set(i + 2, Figuras.get(Indice).Vertices.get(i + 2) + Z);
		}
	}

	private float[] center(int Indice) 
	{
		float X = 0;
		float Y = 0;
		float Z = 0;
		int N = 0;
		for (int i = 0; i < Figuras.get(Indice).Vertices.size(); i += 3) 
		{
			X += Figuras.get(Indice).Vertices.get(i);
			Y += Figuras.get(Indice).Vertices.get(i + 1);
			Z += Figuras.get(Indice).Vertices.get(i + 2);
			N++;
		}
		if (N != 0) 
		{
			X = X / N;
			Y = Y / N;
			Z = Z / N;
		}
		return new float[] { X, Y, Z };

	}

	public void rotateFigure(float x, float y, float z) 
	{
		rotX += x / 100;
		rotY += y / 100;
		rotZ += z / 100;
		rotX = rotX % 360;
		rotY = rotY % 360;
		rotZ = rotZ % 360;
	}

	public void moveFigure(float x, float y, float z) 
	{
		movX += x / 100;
		movY += y / 100;
		movZ += z / 10;
	}
	
	public void scalateFigure(float x, float y, float z)
	{
		scalX += x/200;
		scalY += x/200;
		scalZ += x/200;
	}

	public Lienzo(Context context) 
	{
		super(context);
		setFocusable(true);
		setFocusableInTouchMode(true);
		this.setOnTouchListener(this);
		paint.setColor(Color.WHITE);
		Focos = new float[nFocos][3];
		Focos[0][0] = 10;
		Focos[0][1] = 10;
		Focos[0][2] = 100;
		I_l = new float[nFocos];
		I_l[0] = 100;
		invalidate();
	}
	
	ArrayList<Float> Aux = new ArrayList<Float>();
	@Override
	public void onDraw(Canvas canvas) 
	{
		Log.v("DGC", "Creando bitMap");
		lienzoTemp = Bitmap.createBitmap(canvas.getWidth(), canvas.getHeight(), Bitmap.Config.ARGB_8888);
		Log.v("DGC", "bitMap creado");
		lienzoTemp.eraseColor(Color.BLACK);
		clearZBuffer(canvas.getHeight(), canvas.getWidth());
		Figuras.clear();
		for(int i = 0; i < InitFiguras.size(); i++)
			Figuras.add(new Figura(InitFiguras.get(i)));
		if(Figuras.size()> 0)
		{
			if(!insertarPuntos)
			{
				float[] C = center(indice);
				translate(-C[0], -C[1], -C[2], indice);
				rotate(rotX, 0, 1, 0, indice);
				rotate(rotY, 1, 0, 0, indice);
				rotate(rotZ, 0, 0, 1, indice);
				scalate(scalX, scalY, scalZ, indice);
				translate(C[0], C[1], C[2], indice);
				if(perspective)	perspectiva();  // IM SO CLEVER!! DERP!!
				if(IsProjecting)proyeccion(Distance);
				C = center(indice);
				translate(canvas.getWidth() / 2 - C[0], canvas.getHeight() / 2 - C[1],0,indice);
				paint.setColor(Color.WHITE);
				
				translate(movX, movY, movZ,indice);
				drawTriangles(canvas,indice);
				if(fill){
				Log.v("DGC", "Dibujando BitMap");
				canvas.drawBitmap(lienzoTemp, 0, 0, null);
				Log.v("DGC", "BitMap Dibujado");
				}
				for(int i=0; i<nFocos; i++)
					canvas.drawCircle(Focos[i][0]*Distance/Focos[i][2], Focos[i][1]*Distance/Focos[i][2], 10, paint);
			}
			else
			{
				for(int i = 0; i < Figuras.get(indice).Vertices.size(); i+=3)
				{
					paint.setColor(Color.RED);
					//drawPoint(Float.floatToIntBits(Figuras.get(indice).Vertices.get(i)),Float.floatToIntBits(Figuras.get(indice).Vertices.get(i+1)),Float.floatToIntBits(Figuras.get(indice).Vertices.get(i+2)),canvas);
					canvas.drawLine(Figuras.get(indice).Vertices.get(i)-5, Figuras.get(indice).Vertices.get(i+1), Figuras.get(indice).Vertices.get(i)+5, Figuras.get(indice).Vertices.get(i+1), paint);
					canvas.drawLine(Figuras.get(indice).Vertices.get(i), Figuras.get(indice).Vertices.get(i+1)-5, Figuras.get(indice).Vertices.get(i), Figuras.get(indice).Vertices.get(i+1)+5, paint);
				}
			}
			
			paint.setColor(Color.BLACK);
			canvas.drawLine(0, canvas.getHeight()/2, canvas.getWidth(), canvas.getHeight()/2, paint);
			canvas.drawLine(canvas.getWidth()/2, 0, canvas.getWidth()/2,canvas.getHeight() , paint);
		}
		else 
		{
			Log.i("DGC", "No hay Figuras");
		}	
	}

	public boolean onTouch(View view, MotionEvent event) 
	{
		if(!insertarPuntos)
		{
			if ((event.getAction() == MotionEvent.ACTION_DOWN)) 
			{
				oldX = event.getX();
				oldY = event.getY();
			}
			float movx = event.getX() * event.getXPrecision() - oldX;
			float movy = event.getY() * event.getYPrecision() - oldY;
			switch(axis)
			{
			case 0: // EJE X-Y
				if(((rotate==1)&&(event.getPointerCount() == 1))||((rotate==2)&&(event.getPointerCount() == 2)))
				{
					rotateFigure(movx, movy, 0);
				}
				if(((traslate==1)&&(event.getPointerCount() == 1))||((traslate==2)&&(event.getPointerCount() == 2)))
				{
					if(mode_focus)
					{
						Focos[0][0]+=movx/100;
						Focos[0][1]+=movy/100;
					}
					else
						moveFigure(movx, movy, 0);	 
				}
				if(((escalate==1)&&(event.getPointerCount() == 1))||((escalate==2)&&(event.getPointerCount() == 2)))
				{
					if(mode_focus)
					{
						I_l[0]+=movx/200;
					}
					else
						scalateFigure(movx, movy, 0);	 
				}
				break;
			case 1: // EJE X-Z
				if(((rotate==1)&&(event.getPointerCount() == 1))||((rotate==2)&&(event.getPointerCount() == 2)))
				{
					rotateFigure(movx, 0, movy);
				}
				if(((traslate==1)&&(event.getPointerCount() == 1))||((traslate==2)&&(event.getPointerCount() == 2)))
				{
					if(mode_focus)
					{
						Focos[0][0]+=movx/100;
						Focos[0][2]+=movy/100;
					}
					else
						moveFigure(movx, 0, movy);	 
				}
				if(((escalate==1)&&(event.getPointerCount() == 1))||((escalate==2)&&(event.getPointerCount() == 2)))
				{
					if(mode_focus)
					{
						I_l[0]+=movx/200;
					}
					else
						scalateFigure(movx, 0, movy);	 
				}
				break;
			case 2: // EJE Y-Z
				if(((rotate==1)&&(event.getPointerCount() == 1))||((rotate==2)&&(event.getPointerCount() == 2)))
				{
					rotateFigure(0, movx, movy);
				}
				if(((traslate==1)&&(event.getPointerCount() == 1))||((traslate==2)&&(event.getPointerCount() == 2)))
				{
					if(mode_focus)
					{
						Focos[0][1]+=movx/100;
						Focos[0][2]+=movy/100;
					}
					else
						moveFigure(0, movx, movy); 
				}
				if(((escalate==1)&&(event.getPointerCount() == 1))||((escalate==2)&&(event.getPointerCount() == 2)))
				{
					if(mode_focus)
					{
						I_l[0]+=movx/200;
					}
					else
						scalateFigure(0, movx, movy);
				}
				break;
			}			
			
		}
		else
		{
			if(event.getPointerCount()!= 1)
			{
				//Log.i("DGC","Fin insertar puntos");
				insertarPuntos = false;
				InitFiguras.get(indice).revolucionar(4);
			} 
			else
			{
				if ((event.getAction() == MotionEvent.ACTION_DOWN)) 
				{
				
					//Log.i("DGC","Punto a�adido: "+ event.getX()+ " "+ event.getY());
					InitFiguras.get(indice).addVertice(event.getX(), event.getY(), 150);
					rotX=0;
					rotY=0;
					rotZ=0;
				}
			}
		}
		invalidate();
		return true;
	}

	// Funciones dependientes del menu
	public void setRotateValue(int x)
	{
		if(x!=0)
		{
			if(traslate==x)
				traslate = 0;
			if(escalate==x)
				escalate = 0;
		}
		rotate = x;
		invalidate();
	}
	
	public void setTraslateValue(int x)
	{
		if(x!=0)
		{
			if(rotate==x)
				rotate = 0;
			if(escalate==x)
				escalate = 0;
		}
		traslate = x;
		invalidate();
	}

	public void setEscalateValue(int x)
	{
		if(x!=0)
		{
			if(traslate==x)
				traslate = 0;
			if(rotate==x)
				rotate = 0;
		}
		escalate = x;
		invalidate();
	}

	public void setZBufferValue(int x)
	{
		zbuffer = !zbuffer;
		invalidate();
	}	
	
	public void setFillValue(int x)
	{
		fill = !fill;
		invalidate();
	}

	public void switchProjection()
	{
		IsProjecting = !IsProjecting;
		invalidate();
	}
	public void setPerspectiveValue(int x)
	{
		perspective = !perspective;
		invalidate();
	}
	
	public void setAxisValue(int x)
	{
		axis = x;
		invalidate();
	}
	
	public void setFigura(int x)
	{
		indice = x;
		invalidate();
	}
	public void switchInsertar()
	{
		insertarPuntos= !insertarPuntos;
		InitFiguras.get(3).Aristas.clear();
		InitFiguras.get(3).Vertices.clear();
		invalidate();
	}
	public int amountFiguras()
	{
		return Figuras.size();
	}
	public void switchFocus()
	{
		mode_focus = !mode_focus;
	}
	public float[] getIluminationConstants(){
		float[] result = new float[3];
		result[0]= K_a;
		result[1]= K_s;
		result[2]= K_d;
		return result;
	}
	public void setIluminationConstants(float ambiental, float reflection, float focus){
		K_a = ambiental;
		K_s = reflection;
		K_d = focus;
		invalidate();
	}
	
}

