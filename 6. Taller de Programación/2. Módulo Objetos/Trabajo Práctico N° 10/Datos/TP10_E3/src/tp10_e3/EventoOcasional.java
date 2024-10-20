package tp10_e3;

public class EventoOcasional extends Recital {

    private String motivo;
    private String nombreContratante;
    private int dia;

    public EventoOcasional(String unNombreRecital, int temasMax, String unMotivo, String unNombreContratante, int unDia) {
        super(unNombreRecital, temasMax);
        setMotivo(unMotivo);
        setNombreContratante(unNombreContratante);
        setDia(unDia);
    }

    public void setMotivo(String unMotivo) {
        motivo=unMotivo;
    }

    public void setNombreContratante(String unNombreContratante) {
        nombreContratante=unNombreContratante;
    }

    public void setDia(int unDia) {
        dia=unDia;
    }

    public String getMotivo() {
        return motivo;
    }

    public String getNombreContratante() {
        return nombreContratante;
    }

    public int getDia() {
        return dia;
    }

    @Override
    public String actuar() {
        String aux="";
        if (getMotivo().equals("Show a Beneficio"))
            aux="Recuerden colaborar con '" + getNombreContratante() + "'";
        else if (getMotivo().equals("Show de TV"))
            aux="Saludos amigos televidentes";
        else if (getMotivo().equals("Show Privado"))
            aux="Un feliz cumpleaños para '" + getNombreContratante() + "'";
        aux+="\n" + super.actuar();
        return aux;
    }

    @Override
    public int calcularCosto() {
        int costo=0;
        if (getMotivo().equals("Show a Beneficio"))
            costo=0;
        else if (getMotivo().equals("Show de TV"))
            costo=50000;
        else if (getMotivo().equals("Show Privado"))
            costo=150000;
        return costo;
    }

}