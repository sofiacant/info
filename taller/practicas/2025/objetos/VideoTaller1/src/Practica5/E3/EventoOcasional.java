package Practica5.E3;

public class EventoOcasional extends Recital {

    private String motivo;
    private String nombreContratante;
    private int diaEvento;

    public EventoOcasional(String nombreBanda, int cantTemas, String motivo, String nombreContratante, int diaEvento) {
        super(nombreBanda, cantTemas);
        this.motivo = motivo;
        this.nombreContratante = nombreContratante;
        this.diaEvento = diaEvento;
    }

    public String getNombreContratante() {
        return nombreContratante;
    }

    public String getMotivo() {
        return motivo;
    }

    public String actuar() {
        String aux = "";
        if (getMotivo().equals("Beneficiencia")) {
            aux += "Recuerden colaborar con  " + getNombreContratante()+ "\n";
        } else {
            if (getMotivo().equals("Show de tv")) {
                aux += "Saludos amigos televidentes ";

            } else {
                if (getMotivo().equals("Show privado")) {
                    aux += "Un Feliz cumpleaños para " + getNombreContratante();
                }
            }
        }
        aux += "\n" + super.actuar();

        return aux;
    }             
    

    public double calcularCosto() {
        double costo = 0;
        if (getMotivo().equals("Beneficiencia")) {
            costo = 0;
        } else {
            if (getMotivo().equals("Show de tv")) {
                costo = 50000;
            } else {
                if (getMotivo().equals("Show Privado")) {
                    costo = 150000;
                }
            }

        }
        return costo;
    }

}
