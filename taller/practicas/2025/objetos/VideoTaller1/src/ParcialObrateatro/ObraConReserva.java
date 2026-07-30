package ParcialObrateatro;

public class ObraConReserva extends Obra {

    private Butaca[] vButacas;
    private int dimF;

    public ObraConReserva(String nombre, String nombreDirector, int cantActores, int capacidadMax, Butaca b) {
        super(nombre, nombreDirector, cantActores, capacidadMax);

        this.dimF = capacidadMax;
        this.vButacas = new Butaca[dimF];

        for (int i = 0; i < this.dimF; i++) {
            vButacas[i] = b;
            vButacas[i].setPrecio();
        }
    }

    public boolean ocuparButaca(int i) {
        boolean aux = false;
        if (!vButacas[i].isOcupada()) {
            vButacas[i].setOcupada();
            aux = true;
        }

        return aux;
    }

    public void vaciarObra() {
        for (int i = 0; i < this.dimF; i++) {
            vButacas[i].desocupar();
        }
    }

    public double calcularRecaudacion() {
        double total = 0;
        for (int i = 0; i < this.dimF; i++) {
            if (vButacas[i].isOcupada()) {
                total += vButacas[i].getPrecio();
            }
        }
        return total;
    }

}
