
package Practica4.E4;

public abstract class Sistema {

    private Estacion estacion;
    private int añoA;
    private int cantAños;
    private double[][] sistema; //matriz[año][mes]

    public Sistema(Estacion estacion, int añoA, int cantAños) {
        this.estacion = estacion;
        this.añoA = añoA;
        this.cantAños = cantAños;
        sistema = new double[cantAños][12];

        for (int i = 0; i < cantAños; i++) {
            for (int j = 0; j < 12; j++) {
                sistema[i][j] = 55;
            }
        }

    }

    public void registroTemperaturas(double temp, int mes, int año) {
        int fila = año - añoA;
        this.sistema[fila][mes - 1] = temp;

    }

    public double obtenerTemperaturas(int mes, int año) {
       
        return this.sistema[año-añoA][mes - 1];
    }

    public String mayorTemperatura() {
        double max = 0;
        int añoMax = -1;
        int mesMax = -1;

        for (int i = 0; i < cantAños; i++) {
            for (int j = 0; j < 12; j++) {
                if (sistema[i][j] > max) {
                    max = sistema[i][j];
                    añoMax = i ;
                    mesMax = j;
                }
            }
        
        }
        return "La temp maxima fue en el Mes " + (mesMax+1) + " - Año " + (añoMax+this.añoA);
    }
    

    public Estacion getEstacion() {
        return estacion;
    }

    public void setEstacion(Estacion estacion) {
        this.estacion = estacion;
    }

    public int getAñoA() {
        return añoA;
    }

    public void setAñoA(int añoA) {
        this.añoA = añoA;
    }

    public int getCantAños() {
        return cantAños;
    }

    public void setCantAños(int cantAños) {
        this.cantAños = cantAños;
    }

    public abstract String calcularPromedio();
    
    @Override
    public String toString() {
        return estacion + calcularPromedio();
    }

    
}
