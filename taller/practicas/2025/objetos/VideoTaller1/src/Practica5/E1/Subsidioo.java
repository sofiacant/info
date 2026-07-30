
package Practica5.E1;


public class Subsidioo {
    private double monto;
    private String motivo;
    private boolean otorgado;
    
    
    public Subsidioo(double monto, String motivo){
        this.monto= monto;
        this.motivo=motivo;
        this.otorgado = false;
    }

    public double getMontoSubsidio() {
        return monto;
    }

    public boolean isOtorgado() {
        return otorgado;
    }

    public void setOtorgado(boolean otorgado) {
        this.otorgado = otorgado;
    }
    
   
}
