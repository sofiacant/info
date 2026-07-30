package ParcialSupermercado;

public class parcialSupermercado {

    public static void main(String[] args) {
        Supermercado s= new Supermercado("Nana","Corrientes 1250",3,3);
        
        Producto p1= new Producto(42123,"Salsa","m",2,350);
        Producto p2= new Producto(756423,"Jugo","m",210,120);
        Producto p3= new Producto(43223,"Sal","m",14,630);
        Producto p4= new Producto(496723,"Azucar","as",23,130);
        Producto p5= new Producto(442323,"Arroz","htf",21,350.5);
        Producto p6= new Producto(41123,"Fideos","mhfg",13,327);
        Producto p7= new Producto(497613,"Galletitas","mkhj",19,930.6);
        Producto p8= new Producto(422633,"Palta","maso",12,268.3);
        Producto p9= new Producto(423987,"Tostadas","psfo",25,925.5);
                
                
                
        s.registrarProducto(p1);
        s.registrarProducto(p2);
        s.registrarProducto(p3);
        s.registrarProducto(p4);
        s.registrarProducto(p5);
        s.registrarProducto(p6);
        s.registrarProducto(p7);
        s.registrarProducto(p8);
        s.registrarProducto(p9);
        
         System.out.println(" Productos marca 'm' en góndola 1 ");
        System.out.println(s.enlistarProductos("m", 1));
        System.out.println("Gondola con mayor cantidad de unidades: "+ s.gondolaMaxUnidades());
        
        System.out.println(s.toString());
}
}
