package Practica2;

import PaqueteLectura.Lector;

public class ej5p2 {

    public static void main(String[] args) {
        int max_partidos = 20;
        String fin = "ZZZ";
        Partido par;
        Partido[] vector = new Partido[max_partidos];
        int ganaRiver = 0;
        int golesBoca = 0;

        par = new Partido();

        System.out.println("Ingrese el nombre del visitante");
        String Visitante = (Lector.leerString());

        int i = 0;
        while ((i < max_partidos) && (!Visitante.equals(fin))) {
            
            System.out.println("Ingrese el nombre del local");
            String Local = (Lector.leerString());
            System.out.println("Ingrese cantidad de goles del local");
            int GolesLocal = (Lector.leerInt());
            System.out.println("Ingrese la cantidad de goles del visitante");
            int GolesVisitante = (Lector.leerInt());

            par = new Partido(Local,Visitante,GolesLocal,GolesVisitante);
            vector[i] = par;
          
            i++;
        }
        int cantPartidos = i;

        for (i = 0; i < cantPartidos; i++) {
            Partido p = vector[i];
            String part = "{ " + p.getLocal() + "  " + p.getGolesLocal() + "  VS  " + p.getVisitante() + "  " + p.getGolesVisitante() + " } ";
            System.out.println(part);
            if (p.getLocal().equals("River") || p.getVisitante().equals("River")) {
                if (p.hayGanador() && p.getGanador().equals("River")) {
                    ganaRiver++;
                }
            }
            if (p.getLocal().equals("Boca")) {
                golesBoca += p.getGolesLocal();
            }
        }
        System.out.println("La cantidad de partidos que gano River:  " + ganaRiver);
        System.out.println("La cantidad de goles que realizo Boca jugando de local: " + golesBoca);

    }

}
