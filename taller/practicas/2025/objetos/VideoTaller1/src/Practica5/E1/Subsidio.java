/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica5.E1;

/**
 *
 * @author valen
 */
public class Subsidio {
    private double monto;
    private String motivo;
    private boolean otorgado;

    public Subsidio (double unMonto, String unMotivo){
        this.monto=unMonto;
        this.motivo=unMotivo;
        setOtorgado(otorgado);
    }

    public void setOtorgado(boolean fueOtorgado){
        this.otorgado=fueOtorgado;
    }
    public double getMonto() {
        return monto;
    }

    public boolean isOtorgado() {
        return otorgado;
    }

    @Override
    public String toString() {
        return "Subsidio " + "| monto= " + monto + ", motivo=" + motivo + ", otorgado=" + otorgado + '}';
    }

}
