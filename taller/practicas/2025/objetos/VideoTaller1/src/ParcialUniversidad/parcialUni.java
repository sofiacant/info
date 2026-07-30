/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialUniversidad;
import PaqueteLectura.Lector;
/**
 *
 * @author Sofia C
 */
public class parcialUni {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
            String nombre;
        String apellido;
        String legajo;
                
        int mes;
        int año;
        double nota;
        String modalidad;
               
        
        Universidad uni=new Universidad (1000);
        
        System.out.println("--- ALUMNO 1 ---");
        // ALUMNO 1
        System.out.println("Ingresar el nombre");
        nombre=Lector.leerString();
        System.out.println("Ingresar el apellido");
        apellido=Lector.leerString();
        System.out.println("Ingresar el legajo");
        legajo= Lector.leerString();
        Alumno alu1=new Alumno(nombre, apellido, legajo, 10);
        uni.agregarAlumno(alu1);
        
        // EXAMEN 1 DEL ALUMNO 1
        System.out.println("Ingresar el legajo del alumno rindio examen");
        String legajoExamen1= Lector.leerString();
        System.out.println("-- Ingresar los datos del examen-- ");
        System.out.println("Mes: ");
        mes=Lector.leerInt();
        System.out.println("AÃ±o: ");
        año=Lector.leerInt();        
        System.out.println("Nota: ");
        nota=Lector.leerDouble();
        System.out.println("Modalidad: ");
        modalidad=Lector.leerString();
        Examen E1alu1= new Examen(mes, año, nota, modalidad);
        uni.agregarExamen(legajoExamen1, E1alu1);
        
        
        // EXAMEN 2 DEL ALUMNO 1
        System.out.println("Ingresar el legajo del alumno rindio examen");
        String legajoExamen2= Lector.leerString();
        System.out.println("-- Ingresar los datos del examen-- ");
        System.out.println("Mes: ");
        mes=Lector.leerInt();
        System.out.println("AÃ±o: ");
        año=Lector.leerInt();        
        System.out.println("Nota: ");
        nota=Lector.leerDouble();
        System.out.println("Modalidad: ");
        modalidad=Lector.leerString();
        Examen E2alu1= new Examen(mes, año, nota, modalidad);
        uni.agregarExamen(legajoExamen1, E2alu1);
        
        // GUARDO AL ALUMNO 1 CON SUS 2 EXAMANES
        
        
        
        System.out.println("--- ALUMNO 2 ---");
        // ALUMNO 2
        System.out.println("Ingresar el nombre");
        nombre=Lector.leerString();
        System.out.println("Ingresar el apellido");
        apellido=Lector.leerString();
        System.out.println("Ingresar el legajo");
        legajo= Lector.leerString();
        Alumno alu2=new Alumno(nombre, apellido, legajo, 10);
        uni.agregarAlumno(alu2);
        // EXAMEN 1 DEL ALUMNO 1
        System.out.println("Ingresar el legajo del alumno rindio examen");
        legajoExamen1= Lector.leerString();
        System.out.println("-- Ingresar los datos del examen-- ");
        System.out.println("Mes: ");
        mes=Lector.leerInt();
        System.out.println("AÃ±o: ");
        año=Lector.leerInt();        
        System.out.println("Nota: ");
        nota=Lector.leerDouble();
        System.out.println("Modalidad: ");
        modalidad=Lector.leerString();
        Examen E1alu2= new Examen(mes, año, nota, modalidad);
        uni.agregarExamen(legajoExamen1, E1alu2);
        
        // EXAMEN 2 DEL ALUMNO 2
        System.out.println("Ingresar el legajo del alumno rindio examen");
        legajoExamen2= Lector.leerString();
        System.out.println("-- Ingresar los datos del examen-- ");
        System.out.println("Mes: ");
        mes=Lector.leerInt();
        System.out.println("AÃ±o: ");
        año=Lector.leerInt();        
        System.out.println("Nota: ");
        nota=Lector.leerDouble();
        System.out.println("Modalidad: ");
        modalidad=Lector.leerString();
        Examen E2alu2= new Examen(mes, año, nota, modalidad);
        uni.agregarExamen(legajoExamen2, E2alu2);
        
        // GUARDO AL ALUMNO 2 CON SUS 2 EXAMANES
        
        
        //-------------------------------------------
        System.out.println("\n");
        System.out.println("Cantidad de examenes rendidos bajo cierta modalidad: "+uni.cantExamenes(10, 2025, "escrito"));
                
        
        System.out.println("Alumno con mejor promedio:" +uni.mejorPromedio());
        
    }
}
    
