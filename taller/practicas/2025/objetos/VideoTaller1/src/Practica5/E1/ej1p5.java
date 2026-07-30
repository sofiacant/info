package Practica5.E1;
import Practica5.E1.Proyectoo;
import Practica5.E1.Subsidioo;
import Practica5.E1.Investigadorr;
import PaqueteLectura.GeneradorAleatorio;
public class ej1p5 {

    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        Proyectoo p = new Proyectoo("Proye", 42323, "Maria Sanchez");

        Investigadorr i1 = new Investigadorr("Juan", 2, "Laboratorio");
        Investigadorr i2 = new Investigadorr("Matias", 5, "Analista");
        Investigadorr i3 = new Investigadorr("Soledad", 1, "Investigador");

        Subsidioo sInv1 = new Subsidioo(555, GeneradorAleatorio.generarString(10));
        Subsidioo sInv2 = new Subsidioo(654, GeneradorAleatorio.generarString(10));
        
        i1.agregarSubsidio(sInv1);
        i1.agregarSubsidio(sInv2);
        
        Subsidioo s2 = new Subsidioo(546, GeneradorAleatorio.generarString(10));
        i2.agregarSubsidio(s2);
        
        Subsidioo s3 = new Subsidioo(435, GeneradorAleatorio.generarString(10));
        i3.agregarSubsidio(s3);

        p.agregarInvestigador(i1);
        p.agregarInvestigador(i2);
        p.agregarInvestigador(i3);

        i1.otorgarTodos("Juan");
        System.out.println(p.toString());

    }

}
