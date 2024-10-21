package tp10_e4;

public class Corista extends Persona {

    private int tono;

    public Corista(String unNombre, int unDni, int unaEdad, int unTono) {
        super(unNombre, unDni, unaEdad);
        setTono(unTono);
    }

    public void setTono(int unTono) {
        tono=unTono;
    }

    public int getTono() {
        return tono;
    }

    @Override
    public String toString() {
        return super.toString() + "; Tono fundamental: " + getTono();
    }

}