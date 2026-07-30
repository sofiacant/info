package Practica4.E4;
import  PaqueteLectura.GeneradorAleatorio;
public class ej4p4 {

    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        
        Estacion est =new Estacion("La plata",-34.921 , -57.955 );
        Estacion est2 =new Estacion("Mar del Plata", -38.002 ,-57.556 );
        
        SistemaAnual sistAnual = new SistemaAnual(est,2021,3);
        
        SistemaMensual sistMensual= new SistemaMensual(est2,2020,4);
        
        // cargamos temperaturas simuladas
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 12; j++) {
                sistAnual.registroTemperaturas(20 + Math.random() * 10, j + 1, 2021 + i);
            }
        }
        
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 12; j++) {
                sistMensual.registroTemperaturas(15 + Math.random() * 15, j + 1, 2020 + i);
            }
        }
        
       
   
        System.out.println("Mayor temperatura registrada: " + sistAnual.mayorTemperatura());
        
        
     
        System.out.println("Mayor temperatura registrada: " + sistMensual.mayorTemperatura());
        
    }
    
}
