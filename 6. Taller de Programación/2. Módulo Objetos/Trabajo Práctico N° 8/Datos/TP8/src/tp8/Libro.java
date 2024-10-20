package tp8;

public class Libro {

    private String titulo;
    private String editorial;
    private int añoEdicion=2015;
    private Autor primerAutor;
    private String ISBN;
    private double precio=100;

    public Libro(String unTitulo, String unaEditorial, int unAñoEdicion, Autor unPrimerAutor, String unISBN, double unPrecio) {
        titulo=unTitulo;
        editorial=unaEditorial; 
        añoEdicion=unAñoEdicion;
        primerAutor=unPrimerAutor;
        ISBN=unISBN;
        precio=unPrecio;
    }

    public Libro(String unTitulo, String unaEditorial, Autor unPrimerAutor, String unISBN) {
        titulo=unTitulo;
        editorial=unaEditorial; 
        primerAutor=unPrimerAutor;
        ISBN=unISBN;
    }

    public void setTitulo(String unTitulo) {
        titulo=unTitulo;
    }

    public void setEditorial(String unaEditorial) {
         editorial=unaEditorial;
    }

    public void setAñoEdicion(int unAño) {
         añoEdicion=unAño;
    }

    public void setPrimerAutor(Autor unPrimerAutor) {
         primerAutor=unPrimerAutor;
    }

    public void setISBN(String unISBN) {
         ISBN=unISBN;
    }

    public void setPrecio(double unPrecio) {
         precio=unPrecio;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getEditorial() {
        return editorial;
    }

    public int getAñoEdicion() {
        return añoEdicion;
    }

    public Autor getPrimerAutor() {
        return primerAutor;
    }

    public String getISBN() {
        return ISBN;
    }

    public double getPrecio() {
        return precio;
    }

    @Override
    public String toString() {
        return "Título: " + titulo + "; Autor: " + primerAutor.toString() + "; Año de edición: " + añoEdicion + "; ISBN: " + ISBN;
    }
   
}