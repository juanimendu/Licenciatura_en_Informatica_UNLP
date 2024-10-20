package tp8;

public class Cliente {

    private String nombre;
    private int dni;
    private int edad;
    
    public Cliente(String unNombre, int unDni, int unaEdad) {
        nombre=unNombre;
        dni=unDni;
        edad=unaEdad;
    }

    public void setNombre(String unNombre) {
        nombre=unNombre;
    }

    public void setDni(int unDni) {
        dni=unDni;
    }

    public void setEdad(int unaEdad) {
        edad=unaEdad;
    }

    public String getNombre() {
        return nombre;
    }

    public int getDni() {
        return dni;
    }

    public int getEdad() {
        return edad;
    }

    @Override
    public String toString() {
        return "Cliente " + nombre + ", con DNI " + dni + " y edad " + edad;
    }

}