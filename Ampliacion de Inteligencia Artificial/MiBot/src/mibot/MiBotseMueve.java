package mibot;

import java.util.Vector;
import java.util.Random;
import soc.qase.bot.ObserverBot;
import soc.qase.file.bsp.BSPParser;
import soc.qase.state.Player;
import soc.qase.state.PlayerMove;
import soc.qase.state.World;
import soc.qase.tools.vecmath.Vector3f;
import soc.qase.state.*;
import soc.qase.ai.waypoint.*;
import java.lang.Math;
import jess.*;


//Cualquier bot debe extender a la clase ObserverBot, para hacer uso de sus funcionalidades
public final class MiBotseMueve extends ObserverBot
{
	//Variables 
	private World world = null;
	private Player player = null;
        
        private Vector3f PosPlayer= new Vector3f(0, 0, 0);
        private Vector3f MovPlayer= new Vector3f(1, 1, 1);
	
	//Variable que almacena la posición previa del jugador en 3D, inicializada en 0,0,0
	private Vector3f prevPosPlayer = new Vector3f(0, 0, 0);
	
	//Variable que nos permiten ajustar la lógica y velocidad del movimiento del bot
	private int nsinavanzar = 0, velx = 50 ,vely = 50, cambios = 0, testancado = 0, intentos = 0;
	
	//Acceso a la información del entorno
	private BSPParser mibsp = null;
	
	// Distancia al enemigo que estamos atacando
	private float distanciaEnemigo = Float.MAX_VALUE;
        
        // Ruta al objetivo
        private Waypoint[] ruta;
        private boolean enruta;
        private int nodoactual;
	
	// Motor de inferencia
	private Rete engine;
        
        // Mapa de waypoints
        private WaypointMap map;
        
        int dire = 0;

        /*-------------------------------------------------------------------*/
        /**	Constructor que permite especificar el nombre y aspecto del bot
        /**	@param botName Nombre del bot durante el juego
        /**	@param botSkin Aspecto del bot */
        /*-------------------------------------------------------------------*/
	public MiBotseMueve(String botName, String botSkin, WaypointMap mapa)
	{
		super((botName == null ? "MiBotseMueve" : botName), botSkin);
                map = mapa;
		initBot();
	}

        /*-------------------------------------------------------------------*/
        /**	Constructor que permite además de especificar el nombre y aspecto 
        /**	del bot, indicar si éste analizará manualmente su inventario.
        /**	@param botName Nombre del bot durante el juego
        /**	@param botSkin Aspecto del bot
        s/**	@param trackInv Si true, El agente analizará manualmente su inventario */
        /*-------------------------------------------------------------------*/
	public MiBotseMueve(String botName, String botSkin, boolean trackInv)
	{
		super((botName == null ? "MiBotseMueve" : botName), botSkin, trackInv);
		initBot();
	}
        //Inicialización del bot
	private void initBot()
	{		
		//Autorefresco del inventario
		this.setAutoInventoryRefresh(true);
		try {
			engine = new Rete();
		
			// Inicializacion del motor de inferencias
                        
                        //System.out.println("Velocidad: " + this.velx);
                        //this.setBotMovement(prevPosPlayer, prevPosPlayer, distanciaEnemigo, velx);
                        
                        // Propio
                       engine.executeCommand("(batch c:/Quake/reglasQuake.clp)");
                       // Preparamos el sistema para lanzar las reglas
                       engine.eval("(reset)");
                       // Añadimos los hechos
                       engine.assertString("(color rojo)");
                       // Lanzamos las reglas
                       engine.run();
                       
                       Value v = engine.eval("?*VARGLOB*");
                       System.out.println(v.intValue(engine.getGlobalContext()));

		} catch (JessException je) {
			System.out.println("initBot: Error en la linea " + je.getLineNumber());
			System.out.println("Codigo:\n" + je.getProgramText());
			System.out.println("Mensaje:\n" + je.getMessage());
			System.out.println("Abortado");
			System.exit(1);
		}
                enruta=false;
	}

        /*-------------------------------------------------------------------*/
        /**	Rutina central del agente para especificar su comportamiento
        /**	@param w Objeto de tipo World que contiene el estado actual del juego */
        /*-------------------------------------------------------------------*/
        public void runAI(World w)
	{
            
            if (mibsp==null)
                mibsp = this.getBSPParser();
            
            //System.out.println("AI...\n");
            //Información del juego almacenada en una variable miembro
            world = w;
            
           /* try
            {
                //engine.retractString("(color rojo)");
                //engine.assertString("(color rojo)");
                //engine.assertString("(color azul)");
                engine.run();
                engine.eval("(facts)");
                
                Value v= engine.eval("?*VARGLOB*");
                //System.out.println(v.intValue(engine.getGlobalContext()));
            }
            catch (JessException je)
            {
			System.out.println("Bucle de Juego: Error en la linea " + je.getLineNumber());
			System.out.println("Codigo:\n" + je.getProgramText());
			System.out.println("Mensaje:\n" + je.getMessage());
			System.out.println("Abortado");
			System.exit(1);           
            }*/
            //Obtiene información del bot
            player = world.getPlayer();
                        
            //System.out.println("Is Running? " + player.isRunning() + "\n");
            //System.out.println("getPosition " + player.getPosition() + "\n");
            //System.out.println("isAlive " + player.isAlive() + "\n");
                
            //System.out.println("Arma visible?..." + BuscaArmaVisible() + "\n");
            //System.out.println("Entidad visible?..." + BuscaEntidad() + "\n");
                    
            
            if(BuscaEnemigoVisible())
            {
                System.out.println("Enemigo a la vista");
                // Si hay enemigo, se comprueba si se está en inferioridad numérica o no
                if(NumEnemigosVisibles()>1)
                {
                    System.out.println("Huyo");
                    Huir();
                }
                else
                    setAction(Action.ATTACK, true);
            }	
            else
            {
                setAction(Action.ATTACK, false);
                if(player.getHealth()<90)
                {
                    // Si no tenemos toda la vida y no estamos en peligro directo de ataque
                    // Se intenta recuperar la vida
                    System.out.println("SE BUSCA: BOTIQUÍN");
                    if(!BuscaBotiquin()&&!enruta)
                    {
                        BuscaArma();
                    }
                }
                else
                    if(!enruta)
                    {
                        BuscaArma();
                    }
            }
            EstableceDirMovimiento();
            // Funciones auxiliares
            //Estado();
            //DistObs();
        }
       
	/*-------------------------------------------------------------------*/
	/**	Rutina que configura la dirección de avance en el movimiento.    
	/**	Básicamente, si detecta que el bot no avanza durante un tiempo   
	/**	cambia su dirección de movimiento							     */
	/*-------------------------------------------------------------------*/
	private void EstableceDirMovimiento()
	{
		//Mostrar posición del bot
		/*System.out.println("Posición actual: ("+player.getPlayerMove().getOrigin().getX()+","+
				player.getPlayerMove().getOrigin().getY()+","+
				player.getPlayerMove().getOrigin().getZ()+")");	*/
		
		//Calcula la distancia desde la posición previa y la actual
		//double dist = Math.sqrt(Math.pow(prevPosPlayer.y - player.getPlayerMove().getOrigin().getY(),2)+
		//		Math.pow(prevPosPlayer.x - player.getPlayerMove().getOrigin().getX(),2));
                
                double dist = Math.abs((prevPosPlayer.y - player.getPlayerMove().getOrigin().getY())/MovPlayer.y+
                                       (prevPosPlayer.x - player.getPlayerMove().getOrigin().getX())/MovPlayer.x);
                if(MovPlayer.y==0||MovPlayer.x==0)
                        dist = Math.abs((prevPosPlayer.y - player.getPlayerMove().getOrigin().getY())+
                                        (prevPosPlayer.x - player.getPlayerMove().getOrigin().getX()));
                //System.out.println("Distancia: "+dist);
                
                double distobst = this.getObstacleDistance(MovPlayer, 1000.f);
                //System.out.println("Distancia al obstaculo: "+distobst);
                
                if (enruta)
                {
                    if(nodoactual < ruta.length)
                    {
                        System.out.println("Estamos en ruta por el nodo: " + nodoactual);
                        Vector3f siguiente = ruta[nodoactual].getPosition();
                        velx = (int) siguiente.x-player.getPosition().getX();
                        vely = (int) siguiente.y-player.getPosition().getY();
                        nodoactual++;
                    }
                    else
                    {
                        enruta = false;
                    }
                }
                
		//Si la distancia es baja y no es la primera vez que lo preguntamos (nsinavanzar vale 0 en ese caso)
		if ((dist < 35 && nsinavanzar>0)|| distobst < 100 || distobst == Double.NaN)
		{
			nsinavanzar++;
			//Tras 5 veces sin moverse cambia de sentido
			if (nsinavanzar>2)
			{
                                System.out.println("Cambio de sentido");
				//Resetea el número de veces en que ha preguntado y no hubo movimiento
				nsinavanzar=1;
				
				//Incrementa el contador de cambios de dirección
				cambios++;
				
                                Vector3f punto = map.findClosestWaypoint(PosPlayer).getPosition();
                                if (Math.abs((Math.abs(prevPosPlayer.y) - Math.abs(player.getPlayerMove().getOrigin().getY()))/MovPlayer.y) < 0.8)
                                {
                                    vely = (int) ((punto.y - PosPlayer.y));
                                }
                                if (Math.abs((Math.abs(prevPosPlayer.x) - Math.abs(player.getPlayerMove().getOrigin().getX()))/MovPlayer.x) < 0.8)
                                {
                                    velx = (int) ((punto.x - PosPlayer.x));
                                }
                                
                                testancado++;
                                if (testancado == 10)
                                {
                                    vely = -(vely+20);
                                    velx = -(velx+20);
                                    testancado = 1;
                                    System.out.println("Media Vuelta ... AR!");
                                    intentos++;
                                }    
                                if(intentos == 3)
                                {
                                    vely = (int)(Math.random()*20)-10;
                                    velx = (int)(Math.random()*20)-10;
                                }
				System.out.println("Cambio de dirección de movimiento, x = " + velx + ", y = " + vely);
			}		
		}
		else// Se ha movido bastante en relación a la posición previa, guarda la posición actual
		{
			nsinavanzar=1;
                        testancado = 1;
			
			//Actualiza la que será la posición previa para la siguiente iteración
			prevPosPlayer.set(player.getPlayerMove().getOrigin().getX(),
					player.getPlayerMove().getOrigin().getY(),
					player.getPlayerMove().getOrigin().getZ());				
		}
		
		//Crea un vector con la nueva dirección de movimiento
		Vector3f DirMov;
                if(player.isUnderWater())
                    DirMov = new Vector3f(velx, vely, (int)(Math.random()*20)-10);
                else
                    DirMov = new Vector3f(velx, vely, 0);
                
                DirMov.normalize();
				
		//Comanda el movimiento, si el segundo parámetro es null mira al destino, 
		//en otro caso mira en la dirección indicada
		setBotMovement(DirMov, null, 200, PlayerMove.POSTURE_JUMP);
                MovPlayer = DirMov;
		//Otra postura, p.e. agachado PlayerMove.POSTURE_DUCKED
		
		//Código ejemplo alternatico para mirar no al destino sino a una dirección indicada
		//Vector3f DirVista = new Vector3f(0, 1, 0);
		//setBotMovement(DirMov, DirVista, 200, PlayerMove.POSTURE_NORMAL);
           
	}
	
	/*-------------------------------------------------------------------*/
	/**	Rutina que reporta el estado del bot						     */
	/*-------------------------------------------------------------------*/
	private void Estado()
	{
		//Escribe la cantidad de actual
		System.out.println("Vida "+ player.getHealth());
		
		
		System.out.println("mi FRAGS " + player.getPlayerStatus().getStatus(PlayerStatus.FRAGS));
		
		//Muestra el Ã­ndice del arma activa
		int aux=player.getWeaponIndex();
		//System.out.println("Indice arma actual: " + world.getInventory().getItemString(aux));
		//Si el arma activa no es Blaster, escribe su número de municiones
		if (aux!=PlayerGun.BLASTER) System.out.println("Municion arma actual "+ player.getAmmo());
		
		//Parea disponer de información sobre las municiones
		System.out.println("Armadura "+ player.getArmor());
		
	}

	private boolean BuscaBotiquin()
	{
		//Se aplica sólo si se dispone de información del bot
		if (player!=null)
		{
			Entity nearestHealth = null;
			Vector3f pos = null;
			Origin playerOrigin = null;
			
			//Inicializaciones
			pos = new Vector3f(0, 0, 0);
			
			//Posición del jugador que se almacena en un Vector3f
			playerOrigin = player.getPlayerMove().getOrigin();
			pos.set(playerOrigin.getX(), playerOrigin.getY(), playerOrigin.getZ());
			
			//Obtiene el botiquín más cercano
                        Vector posiblesbotiquines = world.getEntities();
                        float dist = 999999;
                        int objetivo = -1;
                        for(int i=0; i<posiblesbotiquines.size(); i++)
                        {
                             Entity maybe = (Entity) posiblesbotiquines.get(i);
                             System.out.println("Tipo de la entidad: " + maybe.getType());
                             if(maybe.getCategory() == "healing")
                             {  
                                System.out.println("BOTIQUÍN Hallado");
                                float distmaybe = (maybe.getOrigin().getX()-player.getPosition().getX())*(maybe.getOrigin().getX()-player.getPosition().getX())+
                                                  (maybe.getOrigin().getY()-player.getPosition().getY())*(maybe.getOrigin().getY()-player.getPosition().getY())+
                                                  (maybe.getOrigin().getZ()-player.getPosition().getZ())*(maybe.getOrigin().getZ()-player.getPosition().getZ());
                                if(distmaybe<dist)
                                {
                                    objetivo = i;
                                    dist = distmaybe;
                                }
                            }
			}
                        if(objetivo != -1)
                        {
                            ruta = map.findShortestPath(PosPlayer, ((Entity) posiblesbotiquines.get(objetivo)).getOrigin().toVector3f());
                            enruta = true;
                            nodoactual = 0;
                            System.out.println("A por el BOTIQUÍN");
                        }
                        else
                        {
                            System.out.println("No hay BOTIQUÍN");
                        }
		}
		
		//En cualquier otro caso retorna false
		return false;
	}
        
	/*-------------------------------------------------------------------*/
	/**	Rutina que busca un enemigo visible							     */
	/*-------------------------------------------------------------------*/
	private boolean BuscaEnemigoVisible()
	{
		setAction(Action.ATTACK, false);
			
		//Hay información del jugador disponible
		if (player!=null)
		{
			//Hay información del entorno disponible
			if (mibsp!=null)
			{
//				Variables
				Entity nearestEnemy = null;
				Entity tempEnemy = null;
				Vector enemies = null;
				Origin playerOrigin = null;
				Origin enemyOrigin = null;
				Vector3f enPos; 
				Vector3f enDir;
				Vector3f pos = null;
				boolean NearestVisible=false;
				float enDist = Float.MAX_VALUE;
				
				//Posición del bot
				pos = new Vector3f(0, 0, 0);
				enDir = new Vector3f(0, 0, 0);
				enPos = new Vector3f(0, 0, 0);
				
				//Posición del jugador que se almacena en un Vector3f
				playerOrigin = player.getPlayerMove().getOrigin();
				pos.set(playerOrigin.getX(), playerOrigin.getY(), playerOrigin.getZ());
				
				
				//Si sólo queremos acceder al enemigo más cercano
				Entity enemy=null;
                                //enemy= this.getNearestOpponent();//Obtiene el enemigo más cercano
				if (enemy!=null)
					System.out.println("Hay enemigo cercano ");
					
                                // Obtiene información de todos los enemigos
				enemies = world.getOpponents();
			
				//Muestra el número de enemigos disponibles
				System.out.println("Enemigos "+ enemies.size());
				
				//Determina el enemigo más interesante siguiendo un criterio de distancia en 2D y visibilidad
				for(int i = 0; i < enemies.size(); i++)//Para cada entidad
				{
					//Obtiene información de la entidad actual
					tempEnemy = (Entity) enemies.elementAt(i);
					
					//Obtiene la posición de la entidad que está siendo analizada
					enemyOrigin = tempEnemy.getOrigin();
					
					//Inicializa un Vector considerando sólo la x e y, es decir despreciando z
					enPos.set(enemyOrigin.getX(), enemyOrigin.getY(),enemyOrigin.getZ());
					
					//Vector que une las posiciones de la entidad y el jugador proyectado en 2D
					enDir.sub(enPos, pos);
					
					//Uso BSPPARSER para saber si la entidad y el observador se "ven", es decir no hay obstáculos entre ellos
					Vector3f a = new Vector3f(playerOrigin);
					Vector3f b = new Vector3f(enemyOrigin);
					
					//Si la entidad es visible (usando la informaicón del bsp) y su distancia menor a la mÃ­nima almacenada (o no habÃ­a nada almacenado), la almacena
					if((nearestEnemy == null || enDir.length() < enDist) && enDir.length() > 0 )
					{
						nearestEnemy = tempEnemy;
						enDist = enDir.length();
                                                
						//Es visible el más cercano
						if (mibsp.isVisible(a,b))
						{
							NearestVisible=true;							
						}
						else
						{
							NearestVisible=false;
						}
						
					}
				}//for
				
				//Para la entidad seleccionada, calcula la dirección de movimiento
				if(nearestEnemy != null)
				{
					//Posición de la entidad
					enemyOrigin = nearestEnemy.getOrigin();
					enPos.set(enemyOrigin.getX(), enemyOrigin.getY(), enemyOrigin.getZ());
		
					//Direción de movimiento en base a la entidad elegida y la posición del jugador
					enDir.sub(enPos, pos);
					//enDir.normalize();
					
					if (NearestVisible)//Si es visible ataca
					{
						System.out.println("Ataca enemigo ");
						this.sendConsoleCommand("Modo ataque");
						
//						Ã�ngulo del arma
						Angles arg0=new Angles(enDir.x,enDir.y,enDir.z);
						player.setGunAngles(arg0);
						
//						Para el movimiento y establece el modo de ataque
						
						setAction(Action.ATTACK, true);		
						
						setBotMovement(enDir, null, 0, PlayerMove.POSTURE_NORMAL);
						// Distancia al enemigo (para el motor de inferencia)
						distanciaEnemigo = enDist;
						return true;
					}
					else//en otro caso intenta ir hacia el enemigo
					{
						System.out.println("Hay enemigo, pero no está visible ");
						distanciaEnemigo = Float.MAX_VALUE;
					}
				}				
			}					
		}
		
		return false;

	}
	
        /*-------------------------------------------------------------------*/
        /**     Rutina que devuelve el número de enemigos visibles
        /*-------------------------------------------------------------------*/
        private int NumEnemigosVisibles()
        {
            Vector enemigos = world.getOpponents();
            int total = 0;
            for(int i=0; i<enemigos.size(); i++)
            {
                if(mibsp.isVisible(new Vector3f(player.getPlayerMove().getOrigin()), 
                                   new Vector3f(((Entity) enemigos.elementAt(i)).getOrigin())))
                {
                    total++;
                }
            }
            return total;
        }
        
        private void Huir()
        {
            velx = -velx;
            vely = -vely;
            Vector3f DirMov = new Vector3f(velx, vely, 0);
            setBotMovement(DirMov, null, 200, PlayerMove.POSTURE_NORMAL);
        }
        
        private void BuscaArma()
        {
            if(player!=null)
            {
                //if(mibsp!=null)
                if(true)
                {
                    float dist = 99999;
                    int objetivo = -1;
                    Vector posiblesarmas = world.getEntities();
                    for(int i=0; i<posiblesarmas.size(); i++)
                    {
                        Entity maybe = (Entity) posiblesarmas.get(i);
                        //System.out.println("Tipo de la la posible arma: " + maybe.getCategory() + ", " + maybe.getCategory().length() + ", " + Entity.CAT_WEAPONS + ", " + Entity.CAT_WEAPONS.length());
                        if(maybe.getCategory().equals(Entity.CAT_WEAPONS))
                        {
                            float distmaybe = (maybe.getOrigin().getX()-player.getPosition().getX())*(maybe.getOrigin().getX()-player.getPosition().getX())+
                                              (maybe.getOrigin().getY()-player.getPosition().getY())*(maybe.getOrigin().getY()-player.getPosition().getY())+
                                              (maybe.getOrigin().getZ()-player.getPosition().getZ())*(maybe.getOrigin().getZ()-player.getPosition().getZ());
                            System.out.println("Distancia de la posible arma: " + distmaybe);
                            if(distmaybe<dist)
                            {
                                objetivo = i;
                                dist = distmaybe;
                            }
                        }
                    }
                    if(objetivo!=-1)
                    {
                        System.out.println("Buscamos arma");
                        ruta = map.findShortestPath(PosPlayer, ((Entity) posiblesarmas.get(objetivo)).getOrigin().toVector3f());
                        enruta=true;
                        nodoactual=0;
                    }
                }
            }
        }
}
