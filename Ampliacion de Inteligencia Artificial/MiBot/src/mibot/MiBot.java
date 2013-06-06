package mibot;

import soc.qase.ai.waypoint.WaypointMap;

public class MiBot
{
    static Bot MiBot1/*, MiBot2, MiBot3, MiBot4*/;

    public static void main(String[] args)
    {
        Init();
    }

    public static void Init()
    {
        String quake2_path = "C:\\Quake\\quake2";
        System.setProperty("QUAKE2", quake2_path);

        WaypointMap map = new WaypointMap();
        System.out.println("Iniciando");
        //Creación del bot (pueden crearse múltiples bots)
        map.unlockMap();
        MiBot1 = new Bot("[Survibot]1Nick", "male/cipher", "[Survibot]", map);
        //MiBot2 = new Bot("[Survibot]2Rochelle", "female/athena", "[Survibot]", map);
        //MiBot3 = new Bot("[Survibot]3Ellis", "male/athena", "[Survibot]", map);	
        //MiBot4 = new Bot("[Survibot]4Coach", "male/flak", "[Survibot]", map);
        
        //Conecta con el localhost (el servidor debe estar ya lanzado para que se produzca la conexión)
        MiBot1.connect("10.22.146.167", 27910);
        //MiBot2.connect("10.22.146.167", 27910);
        //MiBot3.connect("10.22.146.167", 27910);
        //MiBot4.connect("10.22.146.167", 27910);
    }
}
