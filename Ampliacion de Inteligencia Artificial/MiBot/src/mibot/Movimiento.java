package mibot;

import soc.qase.ai.waypoint.Waypoint;
import soc.qase.state.Entity;
import soc.qase.state.Player;
import soc.qase.tools.vecmath.Vector3f;

public class Movimiento
{

    Waypoint[] ruta;
    boolean enruta;
    int nodoactual;
    Player player;
    Vector3f PosPrev, AtascoPrev;
    int parado;
    boolean atascado;
    boolean siguiendo;
    Entity MamaPato;

    public Movimiento()
    {
        parado = 0;
        PosPrev = new Vector3f(0, 0, 0);
        AtascoPrev = new Vector3f(0, 0, 0);
        atascado = false;
    }

    public void SetPlayer(Player jugador)
    {
        player = jugador;
    }

    public Vector3f EstableceMovimiento(double DistObstaculo, Vector3f PlayerDirection, Player jugador)
    {
        Vector3f Dir = PlayerDirection;
        if (jugador.isUnderWater())
            Dir.z = 400;
        else
            Dir.z = 0;
        // Si estamos pegados al obstáculo, cambiamos la ruta
        //System.out.println(DistObstaculo);

        int prob = (int) (Math.random() * 100);
        if (Double.isNaN(DistObstaculo) && prob <= 5)
        {
            //System.out.println("Media Vuelta " + prob);
            Dir.x *= -1;
            Dir.y *= -1;
            Dir.normalize();
            return Dir;
        }
        
        if (DistObstaculo <= 50)
        {
            //System.out.println("Estamos demasiado cerca de un obstáculo");
            Dir.x = (int)( Math.random() * 20) - 10;
            Dir.y = (int)( Math.random() * 20) - 10;
            Dir.normalize();
            return Dir;
        }

        //System.out.println(jugador.getPosition().getX() + " - " + PosPrev.x + "; " + jugador.getPosition().getY() + " - " + PosPrev.y + ";  "+ jugador.getPosition().getZ() + " - " + PosPrev.z);
        double dist = (jugador.getPosition().getX() - PosPrev.x) * (jugador.getPosition().getX() - PosPrev.x)
                    + (jugador.getPosition().getY() - PosPrev.y) * (jugador.getPosition().getY() - PosPrev.y);
        // Si no nos hemos movido suficiente, cambiamos la ruta
        if (dist <= 25)
        {
            // Comprobamos si estamos atascados entre dos esquinas
            //System.out.println(jugador.getPosition());
            //System.out.println(PlayerDirection);
            //System.out.println("Algo nos está frenando: " + dist);
            parado++;
            if (AtascoPrev.distance(jugador.getPosition().toVector3f()) < 50)
            {
                if (atascado)
                {
                    switch ((int) (Math.random() * 2))
                    {
                        case 0:
                            Dir.x *= -1;
                            break;
                        case 1:
                            Dir.y *= -1;
                            break;
                        case 2:
                            Dir.x *= -1;
                            Dir.y *= -1;
                            break;
                    }
                    Dir.normalize();
                    return Dir;
                }
                else
                {
                    atascado = true;
                }
            }
            if (parado == 5)
            {
                //System.out.println("GIRAMOS: ");
                Dir.x = (int) Math.random() * 2 - 1;
                Dir.y = (int) Math.random() * 2 - 1;
                Dir.normalize();
                //System.out.println("GIRAMOS: " + PlayerDirection + " -> " + Dir);
                return Dir;
            }
            if (parado >= 10)
            {
                switch ((int) Math.random() * 3)
                {
                    case 0:
                        Dir.x *= -1;
                        break;
                    case 1:
                        Dir.y *= -1;
                        break;
                    case 2:
                        Dir.x *= -1;
                        Dir.y *= -1;
                        break;
                }
                Dir.normalize();
                return Dir;
            }
        }
        else
        {
            if (parado != 0)
                AtascoPrev.set(PosPrev);
            else
                atascado = false;
            parado = 0;
            PosPrev.set(jugador.getPosition().toVector3f());
        }
        // En caso que tengamos una ruta definida, la seguimos
        if (enruta)
        {
            //System.out.println("Estamos en ruta");
            if (nodoactual == -1)
            {
                Dir.sub(ruta[0].getPosition(), player.getPosition().toVector3f());
                Dir.normalize();
                return Dir;
            }
            if (nodoactual < ruta.length - 1)
            {
                // Si estamos más cerca del nodo siguiente que al actual y consideramos que ha llegado al nodo siguiente
                if (ruta[nodoactual].getPosition().distance(player.getPosition().toVector3f()) > ruta[nodoactual + 1].getPosition().distance(player.getPosition().toVector3f())
                        && (Math.abs(ruta[nodoactual + 1].getPosition().distance(player.getPosition().toVector3f())) < 35))
                {
                    nodoactual++;
                }
                Dir.sub(ruta[nodoactual].getPosition(), player.getPosition().toVector3f());
                Dir.normalize();
                return Dir;
            }
            enruta = false;
        }
        if (siguiendo)
        {
            Dir.sub(MamaPato.getOrigin().toVector3f(), jugador.getPosition().toVector3f());
            Dir.normalize();
            return Dir;
        }
        return PlayerDirection;
    }

    public boolean DefineRuta(Waypoint[] nodos)
    {
        if (nodos == null || nodos.length == 0)
        {
            //System.out.println("La ruta está vacía");
            return false;
        }
        ruta = nodos;
        enruta = true;
        nodoactual = -1;
        return true;
    }

    public Vector3f Huir(Vector3f PlayerDirection)
    {
        return new Vector3f(-PlayerDirection.x, -PlayerDirection.y, PlayerDirection.z);
    }

    public void Seguir(Entity amigo, String nombre)
    {
        if(amigo.getName().contains("4"))
        {
            siguiendo = false;
            return;
        }
        if(nombre.contains("1"))
        {
            siguiendo = false;
            return;
        }
        if(nombre.contains("2")&&amigo.getName().contains("3"))
        {
            siguiendo = false;
            return;
        }
        MamaPato = amigo;
        siguiendo = true;
    }
}
