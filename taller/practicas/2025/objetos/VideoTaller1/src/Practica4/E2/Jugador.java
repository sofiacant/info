/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica4.E2;

/**
 *
 * @author Sofia C
 */
public class Jugador extends Empleado {

    private int partidos;
    private int goles;

    public Jugador(int partidos, int goles, String nombre, double sueldo, int antiguedad) {
        super(nombre, sueldo, antiguedad);
        setPartidos(partidos);
        setGoles(goles);
    }

    public void setPartidos(int partidos) {
        this.partidos = partidos;
    }

    public void setGoles(int goles) {
        this.goles = goles;
    }

    public int getPartidos() {
        return partidos;
    }

    public int getGoles() {
        return goles;
    }

    public double calcularEfectividad() {
       return ((double) getGoles() / getPartidos());
    
    }

    public double calcularSueldoACobrar() {
        if (this.calcularEfectividad() > 0.5) {
            return super.getSueldo() * 2;
        } else {
            return super.getSueldo();
        }
    }

    public String toString() {
        String aux = super.toString() + "|Partidos:  " + this.getPartidos() + "|  Goles:  " + this.getGoles();
        return aux;
    }

}
