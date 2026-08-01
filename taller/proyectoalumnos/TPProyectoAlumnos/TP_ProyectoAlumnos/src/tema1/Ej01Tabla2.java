
package tema1;
import PaqueteLectura.GeneradorAleatorio;

public class Ej01Tabla2 {

    /**
     * Carga un vector que representa la tabla del 2
     */
    public static void main(String[] args) {
        int DF=11;  
        int [] tabla2 = new int[DF]; // indices de 0 a 10
        int i;
        
        GeneradorAleatorio.iniciar();
        for (i=0;i<DF;i++){
            tabla2[i]=2*i;
            System.out.println("2x" + i + "="+ tabla2[i]);
        }
        
        int num =GeneradorAleatorio.generarInt(12);//valores de 0 a 11
        while(num != 11){
            System.out.println("El resultado de multiplicar "+ num + " es: "+ tabla2[num]);
            num =GeneradorAleatorio.generarInt(12);
        }
        
    }
    
}
