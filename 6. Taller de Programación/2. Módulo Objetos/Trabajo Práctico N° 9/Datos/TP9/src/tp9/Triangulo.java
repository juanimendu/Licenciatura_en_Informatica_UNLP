package tp9;

public final class Triangulo extends Figura {

    private double lado1;
    private double lado2;
    private double lado3;

    public Triangulo(double unLado1, double unLado2, double unLado3, String unColorRelleno, String unColorLinea) {
        super(unColorRelleno, unColorLinea);
        setLado1(unLado1);
        setLado2(unLado2);
        setLado3(unLado3);
    }

    public void setLado1(double unLado1) {
        lado1=unLado1;
    }

    public void setLado2(double unLado2) {
        lado2=unLado2;
    }

    public void setLado3(double unLado3) {
        lado3=unLado3;
    }

    public double getLado1() {
        return lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public double getLado3() {
        return lado3;
    }

    @Override
    public double calcularPerimetro() {
        return getLado1()+getLado2()+getLado3();
    }

    @Override
    public double calcularArea() {
        double s=calcularPerimetro()/2;
        return Math.sqrt(s*(s-getLado1())*(s-getLado2())*(s-getLado3()));
    }

    @Override
    public String toString(){
        return super.toString() + "; Lado 1: " + String.format("%.2f", getLado1()) + "; Lado 2: " + String.format("%.2f", getLado2()) + "; Lado 3: " + String.format("%.2f", getLado3());
    }

}