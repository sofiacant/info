package Practica5.E3;

public abstract class Recital {

    private String nombreBanda;
    private String[] vTemas;
    private int dimL = 0;
    private int dimF = 0;

    public Recital(String nombreBanda, int cantTemas) {
        this.nombreBanda = nombreBanda;
        this.dimF = cantTemas;
        vTemas = new String[dimF];
    }

    public String getNombreBanda() {
        return nombreBanda;
    }

    public void agregarTema(String cancion) {
        if (dimL < dimF) {
            vTemas[dimL] = cancion;
            dimL++;
        }
    }

    public String actuar() {
        String aux = "";
        for (int i = 0; i < this.dimL; i++) {
            aux += "Y ahora tocaremos " + vTemas[i]+ "\n";        
        }
        return aux;
    }

    public abstract double calcularCosto();

}
