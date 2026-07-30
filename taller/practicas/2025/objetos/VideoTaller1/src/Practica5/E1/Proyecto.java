/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica5.E1;

import Practica5.E1.Investigador;

/**
 *
 * @author valen
 */
public class Proyecto {

    private String nombre;
    private int codigo;
    private String nombreCompleto;
    private int DF = 50;
    private int DL = 0;
    Investigador[] vecInv;

    public Proyecto(String unNombre, int unCodigo, String unNombreCompleto) {
        this.nombre = unNombre;
        this.codigo = unCodigo;
        this.nombreCompleto = unNombreCompleto;
        vecInv = new Investigador[this.DF];
    }

    public void agregarInvestigador(Investigador unInvestigador) {
        if (this.DL < this.DF) {
            vecInv[this.DL] = unInvestigador;
            this.DL++;
        }
    }

    public double dineroTotalOtorgado() {
        double total = 0;
        for (int i = 0; i < DL; i++) {

            total = vecInv[i].getTotalSubsidios();

        }
        return total;
    }

    public String toString() {
        String aux = "";
        for (int i = 0; i < DL; i++) {
            aux += vecInv[i].toString() + " Total: " + vecInv[i].getTotalSubsidios()+"\n";
        }
        return "---  "+nombre + " Codigo: "+codigo +" Nombre del Director: "+nombreCompleto+" ---"+ "\n" + aux;
    }

}
