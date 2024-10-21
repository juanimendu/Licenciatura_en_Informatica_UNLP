package tp9;

public class SistemaAnual extends Sistema {

    public SistemaAnual(Estacion unaEstacion, int unAnioInicial, int cantAnios) {
        super(unaEstacion, unAnioInicial, cantAnios);
    }

    @Override
    public String retornarMedia() {
        String aux="";
        double suma;
        for (int i=0; i<getCantAnios(); i++) {
            suma=0;
            for (int j=0; j<getCantMeses(); j++)
                suma+=getTemp(i,j);
            aux+="Promedio Año " + (getAnioInicial()+i) + ": " + String.format("%.2f", suma/getCantMeses()) + "°C\n";
        }
        return aux;
    }

}