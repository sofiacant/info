package Practica4.E4;


public class SistemaAnual extends Sistema {

    public SistemaAnual(Estacion estacion, int A, int N) {
        super(estacion, A, N);
    }

    public String calcularPromedio() {
      String aux = getEstacion().toString() + ":\n";
        for (int i = 0; i < getCantAños(); i++) {
            double suma = 0;
            for (int j = 0; j < 12; j++) {
                suma += obtenerTemperaturas(i, j);
            }
            double promedio = suma / 12;
            aux += "- Año " + (getAñoA() + i) + ": " + promedio + " °C \n";
        }
        return aux;
    }


    public String toString() {
        return super.toString();
    }

}
