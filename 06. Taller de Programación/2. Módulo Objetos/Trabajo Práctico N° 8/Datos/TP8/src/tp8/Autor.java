package tp8;

public class Autor {

    private String nombre;
    private String biografia;
    private String origen;

    public Autor(String unNombre, String unaBiografia, String unOrigen) {
        nombre=unNombre;
        biografia=unaBiografia;
        origen=unOrigen;
    }

    public void setNombre(String unNombre) {
        nombre=unNombre;
    }

    public void setBiografia(String unaBiografia) {
        biografia=unaBiografia;
    }

    public void setOrigen(String unOrigen) {
        origen=unOrigen;
    }

    public String getNombre() {
        return nombre;
    }

    public String getBiografia() {
        return biografia;
    }

    public String getOrigen() {
        return origen;
    }

    @Override
    public String toString() {
        return "El autor se llama " + nombre + ", su biografía es " + biografia + " y su origen es " + origen;
    }

}