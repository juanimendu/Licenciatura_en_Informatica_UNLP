package tp9;

public class Persona {

    private String nombre;
    private int dni;
    private int edad;

    public Persona(String unNombre, int unDni, int unaEdad) {
        setNombre(unNombre);
        setDNI(unDni);
        setEdad(unaEdad);
    }

    public void setDNI(int unDni) {
        dni=unDni;
    }

    public void setEdad(int unaEdad) {
        edad=unaEdad;
    }

    public void setNombre(String unNombre) {
        nombre=unNombre;
    }

    public int getDni() {
        return dni;
    }

    public int getEdad() {
        return edad;
    }

    public String getNombre() {
        return nombre;
    }

    @Override
    public String toString() {
        return "Mi nombre es " + getNombre() + ", mi DNI es " + getDni() + " y tengo " + getEdad() + " años.";
    }

}