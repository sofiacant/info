package ParcialUniversidad;

/**
 *
 * @author Sofia C
 */
public class Universidad {

    private Alumno[] vAlumnos;
    private int dimF;
    private int dimL;

    public Universidad(int N) {
        this.dimL = 0;
        this.dimF = N;
        this.vAlumnos = new Alumno[N];
    }

    public boolean agregarAlumno(Alumno a) {
        boolean aux = false;
        if (dimL < dimF) {
            vAlumnos[dimL] = a;
            dimL++;
            aux = true;

        }
        return aux;
    }

    public int legajoValido(String legajoIn) {
        int aux = -1;
        for (int i = 0; i < dimL; i++) {
            if (vAlumnos[i].getLegajo().equals(legajoIn)) {
                aux = i;
            }
        }
        return aux;
    }

    public boolean agregarExamen(String legajoIn, Examen e) {
        boolean aux = false;
        int pos = legajoValido(legajoIn);
        if (pos != -1) {
            vAlumnos[pos].setExamen(e);
            aux = true;
        }
        return aux;
    }
    
    public int cantExamenes(int mes, int año, String modalidad){
        int cant=0;
        for(int i=0; i<dimL;i++){
            cant= vAlumnos[i].getExamenesRequeridos(mes,año,modalidad);    
        }
       return cant; 
    }
    
    public String mejorPromedio(){
        String aux="";
        double maxProm=-1;
        double promedio;
        for(int i=0; i<dimL; i++){
            promedio= vAlumnos[i].calcularPromedio();
            if(promedio> maxProm){
                maxProm=promedio;
                aux= vAlumnos[i].toString()+ "promedio "+ maxProm;
            }
        }
        return aux ;
    }
    
    
    
    
}
