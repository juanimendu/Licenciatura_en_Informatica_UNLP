package tp9;

public class Trabajador extends Persona {

    private String tarea;

    public Trabajador(String unNombre, int unDni, int unaEdad, String unaTarea) {
        super(unNombre, unDni, unaEdad);
        setTarea(unaTarea);
    }

    public void setTarea(String unaTarea) {
        tarea=unaTarea;
    }

    public String getTarea() {
        return tarea;
    }

    @Override
    public String toString() {
        return super.toString() + " Soy " + getTarea() + ".";
    }

}