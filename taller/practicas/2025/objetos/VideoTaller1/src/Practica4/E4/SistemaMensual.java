
package Practica4.E4;

public class SistemaMensual extends Sistema {

    private String[] meses = new String[]{"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};

    public SistemaMensual(Estacion estacion, int A, int N) {
        super(estacion, A, N);
    }

     public String calcularPromedio() {
        String aux = getEstacion().toString() + ":\n";
        for (int j = 0; j < 12; j++) {
            double suma = 0;
            for (int i = 0; i < getCantAños(); i++) {
                suma += obtenerTemperaturas(i,j);
            }
            double promedio = suma / getCantAños();
            aux += "- " + meses[j] + ": " +  promedio + " °C \n";
        }
        return aux;
    }

    public String toString() {
        return super.toString();
    }

}
