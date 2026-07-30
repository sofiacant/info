package ParcialSupermercado;

public class Supermercado {

    private String nombre;
    private String direccion;
    private Producto[][] gondola;
    private int filas;
    private int columnas;
    private int i = 0;
    private int j = 0;

    public Supermercado(String nombre, String direccion, int cantGondolas, int cantEstantes) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.filas = cantGondolas;
        this.columnas = cantEstantes;
        gondola = new Producto[filas][columnas];

    }

    public boolean estaLlenoFila() {
        return j == columnas;
    }

    public boolean estaLlenoColumna() {
        return i < filas;
    }

    public void registrarProducto(Producto p) {
        if(i<filas){
            gondola[i][j]=p;
            j++;
            if(j==columnas){
                i++;
                j=0;
            }
        }
    }

    public String enlistarProductos(String m, int x) {
        String aux = " ";
        for (int col = 0; col < columnas; col++) {
            if (gondola[x - 1][col].getMarca().equals(m)) {
                aux += gondola[x - 1][col].toString() + "\n";
            }
        }
        return aux;
    }

    public int gondolaMaxUnidades() {
        int maxG = -1;
        int maxProd = -1;
        int suma;
        for (int f = 0; f < filas; f++) {
            suma = 0;
            for (int c = 0; c < columnas; c++) {
                if (gondola[f][c] != null) {
                     suma += gondola[f][c].getCantU();
                }
            }
            if (suma > maxProd) {
                maxProd = suma;
                maxG = f+1;
            }
        }
        return maxG;
    }
    


    public String toString() {
        String aux = "Supermercado:" + "nombre " + nombre + "; direccion " + direccion + "\n";
        for (int f = 0; f < filas; f++) {
            aux += "Gondola " + (f+1) + "\n";
            for (int c = 0; c < columnas; c++) {
                aux += "Estante " + (c+1) + ": Producto{ " + gondola[f][c].toString()+ "\n";
            }
        }
        return aux;
    }

}
