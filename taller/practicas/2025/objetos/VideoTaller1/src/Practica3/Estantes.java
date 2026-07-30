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
public class Estantes {

    private int dimF = 20;
    private int dimL = 0;
    private Libro[] estante;

    public Estantes() {
        estante = new Libro[dimF];
    }
    
    public Estantes(int N){
        dimF=N;
        estante= new Libro[N];
    }
    
    
    public int cantLibrosAlmacenados() {
        return dimL;
    }

    public boolean siEstaLleno() {
        return (dimL == dimF);
   
    }

    public void agregarLibro(Libro unLibro) {

        if (!siEstaLleno()) {
            estante[dimL] = unLibro;
            dimL++;

        } else {
            System.out.println("No es posible agregar un libro, esta lleno");
        }
    }

    public Libro devolverLibro(String titulo) {
        int i = 0;
        Libro unLibro = null;
        while ((i < dimL) && (unLibro == null)) {
            if (estante[i].getTitulo().equals(titulo)) {
                unLibro = estante[i];
            } else {
                i++;
            }
        }
        return unLibro;
    }

}
