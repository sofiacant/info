
package ParcialStreaming;


public class Estreno {
    private String titulo;
    private String tipoContenido;
    private double recaudacion;
    private int cantVisualizaciones;

    public Estreno(String titulo, String tipoContenido, double recaudacion, int cantVisualizaciones) {
        this.titulo = titulo;
        this.tipoContenido = tipoContenido;
        this.recaudacion = recaudacion;
        this.cantVisualizaciones = cantVisualizaciones;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getTipoContenido() {
        return tipoContenido;
    }

    public double getRecaudacion() {
        return recaudacion;
    }

    public int getCantVisualizaciones() {
        return cantVisualizaciones;
    }
    
    public double gananciaEstreno(){
        return (getRecaudacion()/2);
    }
}
