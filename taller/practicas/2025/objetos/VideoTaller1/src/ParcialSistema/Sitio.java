
package ParcialSistema;

public abstract class Sitio {
    private String nombre;
    private String direccionWeb;
    private int cantUsuarios;

    public Sitio(String nombre, String direccionWeb) {
        this.nombre = nombre;
        this.direccionWeb = direccionWeb;
        this.cantUsuarios = 0;
    }

    public int getCantUsuarios() {
        return cantUsuarios;
    }
      
    
    public abstract double cotizarSitio();

 
    public String toString() {
        return "Sitio{" + "nombre: " + nombre + "; direccion Web: " + direccionWeb +" ;Cantidad de usuarios "+ cantUsuarios+ "  ;Cotizacion comercial del sitio: " + this.cotizarSitio();
    }
        
   
}




