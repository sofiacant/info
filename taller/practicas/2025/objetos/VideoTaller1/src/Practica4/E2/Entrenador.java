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
public class Entrenador extends Empleado {

    private int campeonatos;

    public Entrenador(int campeonatos, String unNombre, double unSueldo, int unaAnt) {
        super(unNombre, unSueldo, unaAnt);
        setCampeonatos(campeonatos);
    }

    public void setCampeonatos(int campeonatos) {
        this.campeonatos = campeonatos;
    }

    public int getCampeonatos() {
        return campeonatos;
    }

    public double calcularEfectividad() {
        
        return ((double) getCampeonatos() / super.getAntiguedad());

    }

    public double calcularSueldoACobrar() {
        double aumento = 0;
        if (getCampeonatos() >= 1 && getCampeonatos() <= 4) {
            aumento = (5000);
        } else {
            if (getCampeonatos() >= 5 && getCampeonatos() <= 10) {
                aumento = (30000);
            } else {
                if (getCampeonatos() > 10) {
                    aumento = (50000);
                }
            }

        }
        return super.aumentarSueldo(aumento);
    }

    public String toString() {
        String aux = super.toString() + "|Campeonatos:  " + getCampeonatos();
        return aux;
    }

}
