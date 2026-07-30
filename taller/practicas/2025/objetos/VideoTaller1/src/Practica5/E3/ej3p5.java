
package Practica5.E3;


public class ej3p5 {

    
    public static void main(String[] args) {
        EventoOcasional eO= new EventoOcasional("Sumo",12,"Beneficiencia","Sofia",12);
        Gira g= new Gira("Soda",15,"Nos veran",5);
        
        eO.agregarTema("Jijiji");
        eO.agregarTema("Un ángel para tu soledad");
        eO.agregarTema("La bestia pop");
        eO.agregarTema("De música ligera");
        eO.agregarTema("Persiana americana");

        System.out.println(" ------------EVENTO OCASIONAL ---------");
        System.out.println(eO.actuar());
        System.out.println("Costo del evento: $" + eO.calcularCosto());
        System.out.println();
        
      
        // Cargamos las fechas
        Fecha f1 = new Fecha("Buenos Aires", 1);
        Fecha f2 = new Fecha("Córdoba", 5);
        Fecha f3 = new Fecha("Rosario", 10);
        g.agregarTema("De música ligera");
        g.agregarTema("Persiana americana");

        g.agregarFecha(f1);
        g.agregarFecha(f2);
        g.agregarFecha(f3);

        System.out.println("------ GIRA -------------");
        System.out.println("Costo total de la gira: $" + g.calcularCosto());
        System.out.println();

        // Actuar en cada ciudad (3 fechas)
        System.out.println(g.actuar());
        System.out.println(g.actuar());
        System.out.println(g.actuar());
      // una más, muestra que terminó la gira
    }
}
        
    
    

