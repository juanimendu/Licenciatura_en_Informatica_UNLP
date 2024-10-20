package tp9;

public class Circulo extends Figura {

    private double radio;
    
    public Circulo(double unRadio, String unColorRelleno, String unColorLinea) {
        super(unColorRelleno, unColorLinea);
        setRadio(unRadio);
    }

    public void setRadio(double unRadio) {
        radio=unRadio;
    }

    public double getRadio() {
        return radio;
    }

    @Override
    public double calcularPerimetro() {
        return 2*getRadio()*Math.PI;
    }

    @Override
    public double calcularArea() {
        return Math.PI*Math.pow(getRadio(),2);
    }

    @Override
    public String toString() {
        return super.toString() + "; Radio: " + String.format("%.2f", getRadio());
    }

}