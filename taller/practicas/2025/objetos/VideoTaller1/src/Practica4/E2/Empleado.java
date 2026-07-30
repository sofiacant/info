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
public abstract class Empleado {

    private String nombre;
    private double sueldo;
    private int antiguedad;

    public Empleado(String unNombre, double unSueldo, int unaAnt) {
        setNombre(unNombre);
        setSueldo(unSueldo);
        setAntiguedad(unaAnt);
    }

    public void setNombre(String unNombre) {
        this.nombre = unNombre;
    }

    public void setSueldo(double unSueldo) {
        this.sueldo = unSueldo;
    }

    public void setAntiguedad(int unaAnt) {
        this.antiguedad = unaAnt;
    }

    public String getNombre() {
        return nombre;
    }

    public double getSueldo() {
        return sueldo;
    }

    public int getAntiguedad() {
        return antiguedad;
    }

    public double aumentarSueldo(double aumento) {
        return this.sueldo = getSueldo() + aumento;
    }

    public abstract double calcularEfectividad();

    public abstract double calcularSueldoACobrar(); //Ver de que no sea abstracto y calcule una parte del sueldo y luego las subclases realizan el resto del cálculo invocando a este método.

    public String toString() {
        String aux = "Empleado{" + "nombre=" + this.getNombre() + ", sueldo=" + this.getSueldo()
                + " Efectividad:   " + this.calcularEfectividad() + "  } ";
        return aux;
    }

}
