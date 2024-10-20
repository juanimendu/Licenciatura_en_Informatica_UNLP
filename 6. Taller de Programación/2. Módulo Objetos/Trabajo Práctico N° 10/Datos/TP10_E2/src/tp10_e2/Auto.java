package tp10_e2;

public class Auto {

    private String nombre;
    private String patente;

    public Auto(String unNombre, String unaPatente) {
        setNombre(unNombre);
        setPatente(unaPatente);
    }

    public void setNombre(String unNombre) {
        nombre=unNombre;
    }

    public void setPatente(String unaPatente) {
        patente=unaPatente;
    }

    public String getNombre() {
        return nombre;
    }

    public String getPatente() {
        return patente;
    }

    @Override
    public String toString() {
        return "El nombre del dueño del auto es " + getNombre() + " y la patente es " + getPatente();
    }

}