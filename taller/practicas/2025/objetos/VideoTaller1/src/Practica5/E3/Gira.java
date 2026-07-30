 package Practica5.E3;

public class Gira extends Recital {

    private String nombre;
    private Fecha fechas[];

    private int dimL=0;
    private int dimF=0;
    private int fechaActual=0;

    public Gira(String nombreBanda, int cantTemas, String nombre, int cantFechas) {
        super(nombreBanda, cantTemas);
        this.nombre = nombre;
        this.dimF = cantFechas;
        this.fechas = new Fecha[dimF];
    }

    public boolean puedoAgregar() {
        return dimL<dimF;
    }

    public void agregarFecha(Fecha fecha) {
        if (puedoAgregar()) {
            fechas[dimL] = fecha;
            dimL++;
            
        }
    }
    
    public String actuar(){
        String aux="Buenas noches "+ fechas[fechaActual].getCiudad()+ " \n";
        fechaActual++;
        aux+= super.actuar();
        return aux;
    }    
        
    public double calcularCosto(){
        double costo=0;
        costo=dimL*30000;
        return costo;
    }    
  
}
