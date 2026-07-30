
package ParcialSistema;

public class SitioTAmateur extends Sitio {
    private int cantTorneos;
    private int cantClicks;

    public SitioTAmateur( String nombre, String direccionWeb) {
        super(nombre, direccionWeb);
        this.cantTorneos = 0;
        this.cantClicks = 0;
    }

    public void setCantTorneos(int cantTorneos) {
        this.cantTorneos = cantTorneos;
    }

    public void setCantClicks(int cantClicks) {
        this.cantClicks += cantClicks;
    }
    
    
    public double cotizarSitio(){
        double cotizacion= ((10* this.cantClicks)+(50 * getCantUsuarios()));
        return cotizacion;
    }        
    
    public void registrarTorneoAmateur(int cantC){
        setCantClicks(cantC);
        cantTorneos++;
    }
    
    
}
