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
public class Circulo {
    private double radio;
    private String colorRelleno;
    private String colorLinea;

    public Circulo(double unradio, String uncolorRelleno, String uncolorLinea) {
        this.radio = unradio;
        this.colorRelleno = uncolorRelleno;
        this.colorLinea = uncolorLinea;
    }

 
    public void setRadio(double radio) {
        this.radio = radio;
    }

    public void setColorRelleno(String colorRelleno) {
        this.colorRelleno = colorRelleno;
    }

    public void setColorLinea(String colorLinea) {
        this.colorLinea = colorLinea;
    }
    
    
    public double getRadio() {
        return radio;
    }

    public String getColorRelleno() {
        return colorRelleno;
    }

    public String getColorLinea() {
        return colorLinea;
    }
    
    double pi=Math.PI;
    public double calcularArea(){
        
        return pi*(radio*radio);
                
    }
    
    public double calcularPerimetro(){
        return 2*pi*radio;
        
    } 
    
}
