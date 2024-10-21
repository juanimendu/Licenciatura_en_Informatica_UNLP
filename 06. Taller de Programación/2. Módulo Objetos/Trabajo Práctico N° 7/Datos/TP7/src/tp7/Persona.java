package tp7;

public class Persona {

    private String nombre=null;
    private int dni=-1;
    private int edad=-1;

    public Persona(String unNombre, int unDni, int unaEdad) {
        nombre=unNombre;
        dni=unDni;
        edad=unaEdad; 
    }

    public Persona() {
        
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
        return "Mi nombre es " + nombre + ", mi DNI es " + dni + " y tengo " + edad + " años";
    }

}