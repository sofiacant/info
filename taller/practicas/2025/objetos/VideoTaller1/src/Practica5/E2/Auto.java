
package Practica5.E2;

public class Auto {
    private String nombreDueño;
    private String patente;
    
    
   public Auto(String nombreDueño, String patente){
       this.nombreDueño=nombreDueño;
       this.patente=patente;
   }

    public String getPatente() {
        return patente;
    }

    @Override
    public String toString() {
        return "Auto{" + "Dueño:" + nombreDueño + ", patente:" + patente + '}';
    }

}
