package 

Practica4.E1;

import Practica4.E1.Figura;

public class Triangulo extends Figura {

    private double lado1;
    private double lado2;
    private double lado3;

    public Triangulo(double lado1, double lado2, double lado3,
            String unColorR, String unColorL) {
        super(unColorR, unColorL);
        setLados(lado1, lado2, lado3);
    }

    public double getLado1() {
        return lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public double getLado3() {
        return lado3;
    }

    public String toString() {
        String aux = super.toString() + "Lado 1:    " + getLado1() + "       "
                + "Lado 2:     " + getLado2() + "         "
                + "Lado 3:      " + getLado3();
        return aux;
    }

    public void setLados(double lado1, double lado2, double lado3) {
        this.lado1 = lado1;
        this.lado2 = lado2;
        this.lado3 = lado3;
    }

    public double calcularPerimetro() {
        return lado1 + lado2 + lado3;
    }

    public double calcularArea() {
        double s = calcularPerimetro() / 2;
        return Math.sqrt(s * (s - lado1) * (s - lado2) * (s - lado3));
    }
}
