/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialObrateatro;

import PaqueteLectura.GeneradorAleatorio;
public class mainParcialObra {

    public static void main(String[] args) {
       GeneradorAleatorio.iniciar();

        // Obra sin reserva
        ObraSinReserva obra1 = new ObraSinReserva(80, 1500, "Hamlet", "Juan Pérez", 6, 100);
        System.out.println(obra1);
        double precio=0;
        Butaca b=new Butaca(precio);
        
        // Obra con reserva
        ObraConReserva obra2 = new ObraConReserva("Macbeth", "Ana Gómez", 8, 120,b);

        // Ocupo algunas butacas al azar
        for (int i = 0; i < 10; i++) {
            if (GeneradorAleatorio.generarBoolean()) {
                obra2.ocuparButaca(i);
            }
        }

        System.out.println(obra2);
    }
}
    