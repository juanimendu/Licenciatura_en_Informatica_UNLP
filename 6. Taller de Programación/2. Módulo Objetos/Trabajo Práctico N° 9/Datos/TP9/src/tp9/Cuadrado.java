package tp9;


public class Cuadrado extends Figura {

    private double lado;

    public Cuadrado(double unLado, String unColorRelleno, String unColorLinea) {
        super(unColorRelleno, unColorLinea);
        setLado(unLado);
    }

    public void setLado(double unLado) {
        lado=unLado;
    }

    public double getLado() {
        return lado;
    }

    @Override
    public double calcularArea() {
        return getLado()*getLado();
    }

    @Override
    public double calcularPerimetro() {
        return 4*getLado();
    }

    @Override
    public String toString() {
       return super.toString() + "; Lado: " + String.format("%.2f", getLado());
    }

}