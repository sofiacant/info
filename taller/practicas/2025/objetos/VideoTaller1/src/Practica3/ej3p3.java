/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica3;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

/**
 *
 * @author Sofia C
 */
public class ej3p3 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        int dimF = 20;
        int dimL = 0;

        Estantes est = new Estantes(5);

        while ((dimL < dimF)) {
            String unTitulo = Lector.leerString();
            String unaEditorial = Lector.leerString();
            int unAño = Lector.leerInt();

            String nombre = Lector.leerString();
            String bio = Lector.leerString();
            String origen = Lector.leerString();
            Autor autor = new Autor(nombre, bio, origen);

            String unIsbn = Lector.leerString();
            double unPrecio = Lector.leerDouble();
            Libro unLibro = new Libro(unTitulo, unaEditorial, unAño, autor, unIsbn, unPrecio);
            est.agregarLibro(unLibro);
            dimL++;
        }

        Libro libroBuscado;
        libroBuscado = est.devolverLibro("Mujercitas");
        if (libroBuscado == null) {
            System.out.println("No se encontro");

        } else {
            System.out.println("El autor es:   " + libroBuscado.getAutor());
        }

    }

}
