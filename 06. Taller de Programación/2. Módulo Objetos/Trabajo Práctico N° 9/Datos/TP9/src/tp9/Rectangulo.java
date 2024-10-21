package tp9;

public class Rectangulo extends Figura {

    private double base;
    private double altura;

    public Rectangulo(double unaBase, double unaAltura, String unColorRelleno, String unColorLinea) {
        super(unColorRelleno, unColorLinea);
        setBase(unaBase);
        setAltura(unaAltura);
    }

    public void setBase(double unaBase) {
        base=unaBase;
    }

    public void setAltura(double unaAltura) {
        altura=unaAltura;
    }

    public double getBase() {
        return base;
    }

    public double getAltura() {
        return altura;
    }

    @Override
    public double calcularArea() {
        return getBase()*getAltura();
    }

    @Override
    public double calcularPerimetro() {
        return 2*getBase()+2*getAltura();
    }

    @Override
    public String toString() {
       return super.toString() + "; Base: " + String.format("%.2f", getBase()) + "; Altura: " + String.format("%.2f", getAltura());
    }

}