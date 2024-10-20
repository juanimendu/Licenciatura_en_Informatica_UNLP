package tp10_e4;

public class Persona {

    private String nombre;
    private int dni;
    private int edad;

    public Persona(String unNombre, int unDni, int unaEdad) {
        nombre=unNombre;
        dni=unDni;
        edad=unaEdad; 
    }

    public void setDni(int unDni) {
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
        return "Nombre: " + getNombre() + "; DNI: " + getDni() + "; Edad: " + getEdad();
    }

}