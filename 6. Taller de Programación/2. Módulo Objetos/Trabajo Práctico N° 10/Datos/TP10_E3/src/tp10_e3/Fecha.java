package tp10_e3;

public class Fecha {

    private String ciudad;
    private int dia;

    public Fecha(String unaCiudad, int unDia) {
        setCiudad(unaCiudad);
        setDia(unDia);
    }

    public void setCiudad(String unaCiudad) {
        ciudad=unaCiudad;
    }

    public void setDia(int unDia) {
        dia=unDia;
    }

    public String getCiudad() {
        return ciudad;
    }

    public int getDia() {
        return dia;
    }

}