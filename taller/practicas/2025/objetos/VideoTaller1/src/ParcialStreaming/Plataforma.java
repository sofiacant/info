package ParcialStreaming;

public class Plataforma {

    private String nombre;
    private int cantSuscriptores;
    private Estreno[][] agendaEstrenos;
    private int filas; //categoria
    private int columnas;//meses  
    private int []dimLxCat;


    public Plataforma(String nombre, int cantSuscriptores, int cantCatC) {
        this.nombre = nombre;
        this.cantSuscriptores = cantSuscriptores;
        this.filas = cantCatC;
        this.columnas = 12;
        this.agendaEstrenos = new Estreno[filas][columnas];
        this.dimLxCat = new int[filas];

    }

    public void registrarEstreno(Estreno e, int categX) {
        int fila= categX-1;
        int col=dimLxCat[fila];
        
        if (col < columnas) {
            agendaEstrenos[fila][col] = e;
            dimLxCat[fila]++;
         }

        }
   

    public String listarEstrenos(int categX) {
        String aux = "";
        for (int j = 0; j < dimLxCat[categX-1] ; j++) {
            if (agendaEstrenos[categX - 1][j] != null) {  //para prueba
            aux += "Titulo :" + agendaEstrenos[categX - 1][j].getTitulo() +
                    "tipo de contenido " + agendaEstrenos[categX - 1][j].getTipoContenido()
                    + "recaudacion :" + agendaEstrenos[categX - 1][j].getRecaudacion()
                    + "cantidad de visualizaciones " + agendaEstrenos[categX - 1][j].getCantVisualizaciones()+"\n";
        }
        }
        return aux;
    }

    public double gananciaTotal() {
        double total = 0;
        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {  //el != null para prueba
                if (agendaEstrenos[i][j] != null && agendaEstrenos[i][j].getTipoContenido().equals("Serie")) {
                    total += agendaEstrenos[i][j].gananciaEstreno();
                }
            }
        }
        return total;
    }

    @Override
    public String toString() {
        String aux = "Plataforma: nombre" + nombre + ", cantSuscriptores=" + cantSuscriptores + "\n";
        for (int f = 0; f < filas; f++) {
            aux += "Categoria " + (f + 1) + ":\n";
            for (int c = 0; c < dimLxCat[f]; c++) {
                aux += "Mes " + (c) + "\n ";
                aux += "Titulo " + agendaEstrenos[f][c].getTitulo() + ", recaudacion "
                        + agendaEstrenos[f][c].getRecaudacion() + ", cantidad de visualizaciones "
                        + agendaEstrenos[f][c].getCantVisualizaciones();

            }

        }
        return aux;
    }
}
