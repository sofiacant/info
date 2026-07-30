
package Practica4.E1;

import Practica4.E1.Figura;

public class Circulo extends Figura {
    
    private double radio;
    
    public Circulo(double radio, String unColorR, String unColorL){
        super(unColorR,unColorL);
        setRadio(radio);
    }
    
    public void setRadio(double unRadio){
        radio=unRadio;
    }
    
    public double getRadio(){
        return radio;
        
    }
    
    double pi=Math.PI;
    public double calcularArea(){
        return pi*(getRadio()*getRadio());     
    }
    
    public double calcularPerimetro(){
        return 2*pi*getRadio();   
    }
    public String toString(){
        String aux= super.toString() + "Radio:  " +getRadio();
        return aux;
    }
    
}
