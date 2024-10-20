package tp8;

public class Triangulo {

    private double lado1=-1;
    private double lado2=-1;
    private double lado3=-1;
    private String colorRelleno=null;
    private String colorLinea=null;

    public Triangulo(double unLado1, double unLado2, double unLado3, String unColorRelleno, String unColorLinea) {
        lado1=unLado1;
        lado2=unLado2;
        lado3=unLado3;
        colorRelleno=unColorRelleno;
        colorLinea=unColorLinea;
    }

    public Triangulo() {
        
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

    public void setColorRelleno(String unColorRelleno) {
        colorRelleno=unColorRelleno;
    }

    public void setColorLinea(String unColorLinea) {
        colorLinea=unColorLinea;
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

    public String getColorRelleno() {
        return colorRelleno;
    }

    public String getColorLinea() {
        return colorLinea;
    }

    public double calcularPerimetro() {
        return lado1+lado2+lado3;
    }

    public double calcularArea() {
        double s=calcularPerimetro()/2;
        return Math.sqrt(s*(s-lado1)*(s-lado2)*(s-lado3));
    }

    @Override
    public String toString() {
        return "El perímetro y el área del triángulo son " + String.format("%.2f", calcularPerimetro()) + " y " + String.format("%.2f", calcularArea()) + ", respectivamente";
    }

}