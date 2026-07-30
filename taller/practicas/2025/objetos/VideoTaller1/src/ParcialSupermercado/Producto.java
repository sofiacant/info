
package ParcialSupermercado;


public class Producto {
    private int codigo;
    private String nombre;
    private String marca;
    private int cantU;
    private double precioUni;

    public Producto(int codigo, String nombre, String marca, int cantU, double precioUni) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.marca = marca;
        this.cantU = cantU;
        this.precioUni = precioUni;
    }

    public String getMarca() {
        return marca;
    }

    public int getCantU() {
        return cantU;
    }

    
    
    @Override
    public String toString() {
        return "Producto{" + "Codigo" + codigo + "-  nombre " + nombre + "- marca " + marca + "- cantidad de unidades exhibidas  " + cantU + "- precio por unidad " + precioUni + '}';
    }
    
    
 
    
}
