package tp10_e4;

public abstract class Coro {

    private String nombreCoro;
    private Director director;

    public Coro(String unNombreCoro, Director unDirector) {
        setNombreCoro(unNombreCoro);
        setDirector(unDirector);
    }

    public void setNombreCoro(String unNombreCoro) {
        nombreCoro=unNombreCoro;
    }

    public void setDirector(Director unDirector) {
        director=unDirector;
    }

    public String getNombreCoro() {
        return nombreCoro;
    }

    public Director getDirector() {
        return director;
    }

    public abstract void agregarCorista(Corista unCorista);
    public abstract boolean estaLleno();
    public abstract boolean estaBienFormado();

    @Override
    public String toString() {
        return "NOMBRE DEL CORO: " + getNombreCoro() + "\nDIRECTOR:\n" + getDirector().toString() + "\nCORISTAS:\n";
    }

}