package Practica5.E2;

import Practica5.E2.Auto;

/**
 * @author Sofia C
 */
public class Estacionamiento {

    private String nombre;
    private String direccion;
    private int horaAper;
    private int horaCierre;
    private Auto[][] est;
    private int pisos;
    private int plazas;

    public Estacionamiento(String nombre, String direccion) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.horaAper = 8;
        this.horaCierre = 21;
        this.pisos=5;
        this.plazas=10;
        this.est = new Auto[pisos][plazas];
    }

    public Estacionamiento(String nombre, String direccion, int horaAper, int horaCierre, int pisoN, int plazaM) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.horaAper = horaAper;
        this.horaCierre = horaCierre;
        this.pisos=pisoN;
        this.plazas=plazaM;
        this.est = new Auto[pisos][plazas];
    }

    public int getPiso() {
        return pisos;
    }

    public int getPlaza() {
        return plazas;
    }

    public void estacionarAuto(Auto A, int X, int Y) {
        est[X-1][Y-1] = A;
    }

    public String buscarAuto(String patente) {
        String aux = "";
        for (int i = 0; i < pisos; i++) {
            for (int j = 0; j < plazas; j++) {
                if ((est[i][j]!= null)&& (est[i][j].getPatente().equals(patente))) {
                    aux += "Nro de piso: " + (i+1) + "Nro de plaza:" + (j+1);
                } else {
                    aux += "Autoinexistente  |\n";
                }
            }
        }
        return aux;
    }

    public String toString() {
        String aux = "Estacionamiento:  ";
        for (int i = 0; i < pisos; i++) {
            for (int j = 0; j < plazas; j++) {
                if (est[i][j] != null) {
                    aux += "Piso " + (i+1) + "Plaza " + (j+1) + est[i][j].toString() + "\n";
                } else {
                    aux += "Piso " + (i+1) + "Plaza " + (j+1) + "libre |" + "\n";
                }

            }

        }
        return aux;
    }
    
    public int cantAutosPlaza(int Y){
      int cant=0; 
      for (int i = 0; i < pisos; i++) {
         if(est[i][Y-1]!= null){
             cant++;
         }
    }
     return cant;
    }
    
}
