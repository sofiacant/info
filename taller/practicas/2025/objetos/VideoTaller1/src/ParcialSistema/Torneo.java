
package ParcialSistema;

public class Torneo {
    private String nombre;
    private int fecha;
    private double montoRecaudado;
    private double montoPremios;

    public Torneo(String nombre, int fecha, double montoRecaudado, double montoPremios) {
        this.nombre = nombre;
        this.fecha = fecha;
        this.montoRecaudado = montoRecaudado;
        this.montoPremios = montoPremios;
    }

    public double getMontoRecaudado() {
        return montoRecaudado;
    }

    public double getMontoPremios() {
        return montoPremios;
    }
    
    public double getMontoRecaudadoPorTorneo(){
        return (getMontoRecaudado()- getMontoPremios());
    }
    
    
}


