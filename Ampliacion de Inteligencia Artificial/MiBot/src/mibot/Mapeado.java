package mibot;

import java.util.Vector;
import soc.qase.ai.waypoint.*;
import soc.qase.file.bsp.BSPParser;
import soc.qase.state.Entity;
import soc.qase.state.Player;
import soc.qase.state.World;
import soc.qase.tools.vecmath.Vector3f;

public class Mapeado
{
    WaypointMap mapa;
    private World mundo;
    String grupo;

    public Mapeado(World world, String nomine)
    {
        mundo = world;
        grupo = nomine;
    }

    public Vector3f BuscarCosaCercana(Vector3f Posicion)
    {
        Vector posiblesarmas = mundo.getEntities(Entity.CAT_WEAPONS, null, null, false);
        posiblesarmas.add(mundo.getEntities(Entity.CAT_OBJECTS, null, null, false));
        if(posiblesarmas.isEmpty())
            return null;
        float distancia = Float.MAX_VALUE;
        int objetivo = -1;
        //System.out.println("Hay " + posiblesarmas.size() + " armas posibles a obtener");
        for (int i = 0; i < posiblesarmas.size()-1; i++)
        {
            Entity maybe = (Entity) posiblesarmas.get(i);
            float distmaybe = maybe.getOrigin().toVector3f().distance(Posicion);
            //System.out.println("La cosa a obtener es " + maybe.getName() + " y está a " + distmaybe);
            if (distmaybe < distancia)
            {
                objetivo = i;
                distancia = distmaybe;
            }
        }
        if (objetivo != -1)
        {
            return ((Entity) posiblesarmas.get(objetivo)).getOrigin().toVector3f();
        }
        return null;
    }

    public Vector3f BuscaBotiquinCernano(Vector3f Posicion)
    {
        //Obtiene el botiquín más cercano
        Vector posiblesbotiquines = mundo.getEntities(null, Entity.TYPE_HEALTH, null, false);
        if(posiblesbotiquines.isEmpty())
            return null;
        float dist = 999999;
        int objetivo = -1;
        for (int i = 0; i < posiblesbotiquines.size(); i++)
        {
            Entity maybe = (Entity) posiblesbotiquines.get(i);
            //System.out.println("Tipo de la entidad: " + maybe.getType());
            if ("healing".equals(maybe.getCategory()))
            {
                //System.out.println("BOTIQUÍN Hallado");
                float distmaybe = maybe.getOrigin().toVector3f().distance(Posicion);
                if (distmaybe < dist)
                {
                    objetivo = i;
                    dist = distmaybe;
                }
            }
        }
        if (objetivo != -1)
        {
            return ((Entity) posiblesbotiquines.get(objetivo)).getOrigin().toVector3f();
        }
        return null;
    }

    public int NumEnemigosVisibles(BSPParser mibsp, Vector3f vista)
    {
        if (mibsp == null)
        {
            return 0;
        }
        Vector enemigos = mundo.getOpponents();
        if(enemigos.isEmpty())
            return 0;
        int numenemies = 0;
        for (int i = 0; i < enemigos.size(); i++)
        {
            Entity posible = (Entity) enemigos.get(i);
            Vector3f v = new Vector3f();
            v.sub(posible.getOrigin().toVector3f(), mundo.getPlayer().getPosition().toVector3f());
            if (!posible.playerDied && !posible.getName().contains(grupo) && mibsp.isVisible(posible.getOrigin().toVector3f(), mundo.getPlayer().getPosition().toVector3f())&&(v.dot(vista)>=0))
            {
                numenemies++;
            }
        }
        return numenemies;
    }

    public Vector3f Objetivo_Enemigo(BSPParser mibsp, Vector3f vista)
    {
        if (mibsp == null)
        {
            return null;
        }
        Vector enemigos = mundo.getOpponents();
        Player jugador = mundo.getPlayer();
        float dist = Float.MAX_VALUE;
        int enemigo = -1;
        if(enemigos.isEmpty())
            return null;
        for (int i = 0; i < enemigos.size(); i++)
        {
            Entity posible = (Entity) enemigos.get(i);
            Vector3f v = new Vector3f();
            v.sub(posible.getOrigin().toVector3f(), mundo.getPlayer().getPosition().toVector3f());
            float distancia = jugador.getPosition().distance(((Entity) enemigos.get(i)).getOrigin());
            if (!posible.getName().contains(grupo) && !((Entity) enemigos.get(i)).playerDied && 
                mibsp.isVisible((posible).getOrigin().toVector3f(), jugador.getPosition().toVector3f()) && (distancia < dist) && (v.dot(vista)>=0))
            {
                enemigo = i;
                dist = distancia;
            }
        }
        if(enemigo == -1)
            return null;
        Vector3f v = new Vector3f();
        v.sub(((Entity) enemigos.get(enemigo)).getOrigin().toVector3f(), jugador.getPosition().toVector3f());
        return v;
    }

    public Entity BuscaAliadoCercano()
    {
        Vector aliados = mundo.getOpponents();
        if(aliados.isEmpty())
            return null;
        Player jugador = mundo.getPlayer();
        float dist = Float.MAX_VALUE;
        int aliado = -1;
        for (int i = 0; i < aliados.size(); i++)
        {
            Entity posible = (Entity) aliados.get(i);
            float distancia = jugador.getPosition().distance((posible).getOrigin());
            if (!posible.playerDied && posible.getName().contains(grupo) && (distancia < dist))
            {
                aliado = i;
                dist = distancia;
            }
        }
        if(aliado == -1)
            return null;
        return ((Entity) aliados.get(aliado));
    }

    public int NumAliadosCercanos(BSPParser mibsp)
    {
        if (mibsp == null)
        {
            return 0;
        }
        Vector aliados = mundo.getOpponents();
        if(aliados.isEmpty())
            return 0;
        int numaliados = 0;
        Player jugador = mundo.getPlayer();
        for (int i = 0; i < aliados.size(); i++)
        {
            Entity posible = (Entity) aliados.get(i);
            if (!posible.playerDied && !posible.getName().contains(grupo) && jugador.getPosition().toVector3f().distance(posible.getOrigin().toVector3f())<200)
            {
                numaliados++;
            }
        }
        return numaliados;
    }
}
