package mibot;

import jess.JessException;
import jess.Rete;
import jess.Value;
import soc.qase.bot.ObserverBot;
import soc.qase.file.bsp.BSPParser;
import soc.qase.state.Player;
import soc.qase.state.PlayerMove;
import soc.qase.state.World;
import soc.qase.tools.vecmath.Vector3f;
import soc.qase.state.*;
import soc.qase.ai.waypoint.*;

//Cualquier bot debe extender a la clase ObserverBot, para hacer uso de sus funcionalidades
public final class Bot extends ObserverBot
{
    //Variables 

    private Mapeado mapa;
    private Player player = null;
    private Vector3f PosPlayer = new Vector3f(0, 0, 0);
    private Vector3f MovPlayer = new Vector3f(1, 1, 1);
    //Acceso a la información del entorno
    private BSPParser mibsp = null;
    // Ruta al objetivo
    private Movimiento moving;
    // Motor de inferencia
    private Rete engine;
    // Mapa de waypoints
    private WaypointMap map;
    private String grupo;
    private String nombre;
    int dire = 0;

    /*-------------------------------------------------------------------*/
    /**
     ** Constructor del bot 
     **     botName Nombre del bot durante el juego
     **     botSkin Aspecto del bot
     **     nomine  Nombre del grupo del bot
     **     mapa    WaypointMap compartido entre el grupo
     */
    /*-------------------------------------------------------------------*/

    public Bot(String botName, String botSkin, String nomine, WaypointMap mapa)
    {
        super((botName == null ? "MiBotseMueve" : botName), botSkin);
        mibsp = this.getBSPParser();
        map = mapa;
        initBot();
        moving = new Movimiento();
        grupo = nomine;
        nombre = botName;
    }

    //Inicialización del bot
    private void initBot()
    {
        //Autorefresco del inventario
        this.setAutoInventoryRefresh(true);
        try
        {
            engine = new Rete();
            
            engine.batch("C:/Quake/eleccion.clp");
            engine.eval("(reset)");
            engine.run();
        }
        catch(JessException je)
        {
            System.out.println("initBot: Error en la linea " + je.getLineNumber());
            System.out.println("Codigo:\n" + je.getProgramText());
            System.out.println("Mensaje:\n" + je.getMessage());
            System.out.println("Abortado");
            System.exit(1);
        }
    }

    /*-------------------------------------------------------------------*/
    /**
     * Rutina central del agente para especificar su comportamiento
     **     w Objeto de tipo World que contiene el estado actual del juego
     */
    /*-------------------------------------------------------------------*/
    @Override
    public void runAI(World w)
    {
        if (mibsp == null)
            mibsp = this.getBSPParser();

        //Información del juego almacenada en una variable miembro
        mapa = new Mapeado(w, grupo);
        moving.SetPlayer(w.getPlayer());

        //Obtiene información del bot
        player = w.getPlayer();
        
        if(!player.isAlive()||(player.getHealth()<=0) || (respawnNeeded))
            respawn();
        
        int numaliados = mapa.NumAliadosCercanos(mibsp);
        int numenemies = mapa.NumEnemigosVisibles(mibsp, MovPlayer);
        double distobst = this.getObstacleDistance(MovPlayer, 1000.f);
        if (numenemies != 0)
        {
            try
            {
                // Insertamos los hechos
                engine.retractString("(enemigos menos)");
                engine.retractString("(enemigos iguales)");
                engine.retractString("(enemigos muchos)");
                engine.retractString("(distanciaObstaculo corta)");
                engine.retractString("(enemigos media)");
                engine.retractString("(enemigos lejos)");
                if(numenemies < numaliados)
                    engine.assertString("(enemigos menos)");
                if(numenemies == numaliados)
                    engine.assertString("(enemigos iguales)");
                if(numenemies > numaliados)
                    engine.assertString("(enemigos muchos)");
                if(distobst<=50)
                    engine.assertString("(distanciaObstaculo corta)");
                if(distobst>50 && distobst <75)
                    engine.assertString("(distanciaObstaculo media)");
                if(distobst>=75)
                    engine.assertString("(distanciaObstaculo lejos)");
                // Ejecutamos la máquina
                engine.run();
                engine.eval("(facts)");
                // Obtenemos la recomendación
                Value v = engine.eval("?*recomendacion*");
                String armas[] = v.toString().split(" ");
                int i=0;
                for(; i<armas.length; i++)
                {
                    if ((w.getInventory().getCount(Integer.parseInt(armas[i]))!=0) && (w.getInventory().getCount(player.getPlayerGun().getAmmoInventoryIndexByGun(Integer.parseInt(armas[i])))>0))
                    {
                        this.changeWeapon(Integer.parseInt(armas[i]));
                        break;
                    }
                }
                // No tenemos el arma recomendada
                // NOS SUPERAN EN NÚMERO
                if(numenemies>numaliados)
                    setBotMovement(moving.Huir(MovPlayer), null, 200, PlayerMove.POSTURE_JUMP);
                else
                {
                    // PODEMOS CON ELLOS, A LAS BARRICADAS
                    Vector3f objetivo = mapa.Objetivo_Enemigo(mibsp, MovPlayer);
                    System.out.println(objetivo);
                    player.setGunAngles(new Angles(objetivo.x, objetivo.y, objetivo.z));
                    setAction(Action.ATTACK, true);
                    Vector3f Dir = new Vector3f(0,0,0);
                    setBotMovement(Dir, objetivo, 200, PlayerMove.POSTURE_CROUCH);
                }
                return;
            }
            catch (JessException je)
            {
                System.out.println("initBot: Error en la linea " + je.getLineNumber());
                System.out.println("Codigo:\n" + je.getProgramText());
                System.out.println("Mensaje:\n" + je.getMessage());
                System.out.println("Abortado");
                System.exit(1);
            }
        }
        else
        {
            setAction(Action.ATTACK, false);
            if (map.getAllNodes()!= null && map.getAllNodes().length > 10)
            {
                if (player.getHealth() < 90)
                {
                    // Si no tenemos toda la vida y no estamos en peligro directo de ataque
                    // Se intenta recuperar la vida
                    Vector3f posBot = mapa.BuscaBotiquinCernano(PosPlayer);
                    if (posBot != null)
                    {
                        Waypoint[] ruta = map.findShortestPath(player.getPosition().toVector3f(), posBot);
                        if (ruta != null)
                        {
                             moving.DefineRuta(ruta);
                        }
                    }
                }
                else
                {
                    // Comprobamos si podemos seguir a un aliado
                    Entity posAliado = mapa.BuscaAliadoCercano();
                    if (posAliado != null)
                    {
                        moving.Seguir(posAliado, nombre);
                    }
                    /*if (!moving.enruta && !moving.siguiendo)
                    {
                        Vector3f posBot = mapa.BuscarCosaCercana(PosPlayer);
                        if (posBot != null)
                        {
                            System.out.println("Se busca la ruta a ese algo " + nombre + " " + posBot);
                            Waypoint[] ruta = map.findShortestPath(map.findClosestWaypoint(player.getPosition().toVector3f()), map.findClosestWaypoint(posBot));
                            System.out.println("Se comprueba que la ruta no es nula " + nombre);
                            if (ruta != null)
                            {
                                System.out.println("Se asigna la ruta " + nombre);
                                moving.DefineRuta(ruta);
                            }
                        }
                    }*/
                }
            }
        }
        setBotMovement(moving.EstableceMovimiento(distobst, MovPlayer, player), null, 200, PlayerMove.POSTURE_JUMP);
        if (map.getAllNodes().length == 0 || (map.findClosestWaypoint(player.getPosition()).getPosition().distance(player.getPosition().toVector3f()) > 30))
        {
            map.addNode(player.getPosition());
        }
    }
}
