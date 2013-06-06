
import java.util.*;
import java.io.*;

public class CalculoDistanciaBKDL
{

	public long[] Comprueba_Palabras(List<String> palabras_correctas, List<String> palabras_erroneas)
	{
		BKTreeDL arbol = new BKTreeDL();
		for(int i=0; i<palabras_correctas.size(); i++)
			arbol.insertar(palabras_correctas.get(i));
		try
        {
			int num_Correctas = 0;
            FileWriter ficheroFinal = new FileWriter("FicheroSolucionBKDL.txt");
            BufferedWriter out = new BufferedWriter(ficheroFinal);
            long startTime = System.nanoTime();
            for(int i=0; i<palabras_erroneas.size(); i++)
            {
                List<String> palabras_posibles = arbol.busqueda(palabras_erroneas.get(i));
				if (palabras_posibles.size() == 0)
					continue;
                out.write(palabras_erroneas.get(i) + " : ");
                boolean correcto = false;
                for(int k=0; k<palabras_posibles.size()-1; k++)
                {
                    out.write(palabras_posibles.get(k) + ", ");
                    if(palabras_correctas.indexOf(palabras_posibles.get(k))==i)
                        correcto = true;
                }
                out.write(palabras_posibles.get(palabras_posibles.size()-1));
                    if(palabras_correctas.indexOf(palabras_posibles.get(palabras_posibles.size()-1))==i)
                        correcto = true;
                if(correcto)
				{
                    out.write(" --> Correcto = OK");
					num_Correctas++;
				}
                else
                    out.write(" --> Correcto = NO");
                out.newLine();
            }
			out.write("Nœmero de palabras correctas: " + num_Correctas);
			out.newLine();
			double endTime = Double.valueOf(System.nanoTime() - startTime);
			endTime /= 1000000000;
			out.write("Tiempo de ejecuci—n: " + endTime);
			out.newLine();
		  	out.close();
		  	long[] retorno = new long[2];
		  	retorno[0] = num_Correctas;
		  	retorno[1] = (long) (endTime);
		  	return retorno;
        }
        catch (Exception e)
        {
            System.err.println("Error: " + e.getMessage()); 
        }
		return null;
	}
}