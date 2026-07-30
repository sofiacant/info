package Practica5.E1;

public class Investigadorr {

    private String nombreCompleto;
    private int categoria;
    private String especialidad;
     
    private int dimF = 5;
    private int dimL = 0;
    Subsidioo[] vSubsidios;

    public Investigadorr(String nombreCompleto, int categoria, String especialidad) {
        this.nombreCompleto = nombreCompleto;
        setCategoria(categoria);
        this.especialidad = especialidad;
        this.vSubsidios = new Subsidioo[dimF];
    }

    public void setCategoria(int categoria) {
        if ((categoria >= 1) && (categoria <= 5)) {
            this.categoria = categoria;
        }
    }

    public void agregarSubsidio(Subsidioo subsidio) {
        while (dimL < dimF) {
            vSubsidios[dimL] = subsidio;
            vSubsidios[dimL].setOtorgado(true);
            dimL++;
        }
    }

    public double getMontoInv() {
        double montoT = 0;
        for (int i = 0; i < dimL; i++) {
            montoT = vSubsidios[i].getMontoSubsidio();
        }
        return montoT;
    }

    public void otorgarTodos(String nombre_completo) {
        for (int i = 0; i < dimL; i++) {
            if ((!vSubsidios[i].isOtorgado()) && (this.nombreCompleto.equals(nombre_completo))) {
                vSubsidios[i].setOtorgado(true);
            }
        }

    }
    
    public String toString() {
        return "Nombre del investigador{"  + nombreCompleto + ", categoria" + categoria 
                + ", especialidad " + especialidad+ "| \n ";
    }
    
    

}
