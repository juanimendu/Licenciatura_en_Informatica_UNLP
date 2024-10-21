package tp10_e4;

public class Director extends Persona {

    private int antiguedad;

    public Director(String unNombre, int unDni, int unaEdad, int unaAntiguedad) {
        super(unNombre, unDni, unaEdad);
        setAntiguedad(unaAntiguedad);
    }

    public void setAntiguedad(int unaAntiguedad) {
        antiguedad=unaAntiguedad;
    }

    public int getAntiguedad() {
        return antiguedad;
    }

    @Override
    public String toString() {
        return super.toString() + "; Antigüedad: " + getAntiguedad();
    }

}