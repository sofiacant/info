/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica3;

/**
 *
 * @author Sofia C
 */
public class Hotel {

    private Habitacion[] hab;
    private int cantHabitaciones;

    public Hotel(int N) {
        cantHabitaciones = N;
        this.hab = new Habitacion[N];
        for (int i = 0; i < N; i++) {
            hab[i] = new Habitacion();
        }
    }

    public void guardarClientes(Persona C, int X) {
        hab[X].setCliente(C);
        hab[X].setOcupada(true);
    }

    public void aumentarPrecios(double precio) {
        for (int i = 0; i < cantHabitaciones; i++) {
            hab[i].aumentarPrecio(precio);
        }

    }

    @Override

    public String toString() {
        return "Habitaciones " + cantHabitaciones + " " + this.HabtoString();
    }

    public String HabtoString() {
        String str = "";
        for (int i = 0; i < cantHabitaciones; i++) {
            str += "\n"+"Habitacion " + i + hab[i].toString();
        }

        return str;

    }
}
