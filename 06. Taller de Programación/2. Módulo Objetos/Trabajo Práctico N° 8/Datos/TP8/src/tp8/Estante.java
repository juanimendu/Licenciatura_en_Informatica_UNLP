package tp8;

public class Estante {

    private int librosMax=20;
    private int cantLibros=0;
    private Libro[] libros;

    public Estante() {
        setLibros();
    }

    public Estante(int librosMax) {
        setLibrosMax(librosMax);
        setLibros();
    }

    private void setLibrosMax(int librosMax) {
        this.librosMax=librosMax;
    }

    private void setCantLibros(int cantLibros) {
        this.cantLibros=cantLibros;
    }

    private void setLibros() {
        libros=new Libro[librosMax];
        for (int i=0; i<librosMax; i++)
            libros[i]=null;
    }

    public int getLibrosMax() {
        return librosMax;
    }

    public int getCantLibros() {
        return cantLibros;
    }

    private Libro[] getLibros() {
        return libros;
    }

    private boolean quedaEspacio() {
        return cantLibros<librosMax;
    }

    public void agregarLibro(Libro unLibro) {
        if (quedaEspacio()) {
            libros[cantLibros]=unLibro;
            cantLibros++;
        }
        else
            System.out.println("No es posible agregar más libros al estante");
    }

    public Libro devolverLibro(String unTitulo) {
        int i=0;
        while ((i<cantLibros) && (!libros[i].getTitulo().equals(unTitulo)))
            i++;
        if (i<cantLibros)
            return libros[i];
        else
            return null;
   }

}