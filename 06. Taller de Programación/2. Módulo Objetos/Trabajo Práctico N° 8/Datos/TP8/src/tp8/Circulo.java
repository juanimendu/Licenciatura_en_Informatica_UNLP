package tp8;

public class Circulo {

    private double radio=-1;
    private String colorRelleno=null;
    private String colorLinea=null;

    public Circulo(double unRadio, String unColorRelleno, String unColorLinea) {
        radio=unRadio;
        colorRelleno=unColorRelleno;
        colorLinea=unColorLinea;
    }

    public Circulo() {
        
    }

    public void setRadio(double unRadio) {
        radio=unRadio;
    }

    public void setColorRelleno(String unColorRelleno) {
        colorRelleno=unColorRelleno;
    }

    public void setColorLinea(String unColorLinea) {
        colorLinea=unColorLinea;
    }

    public double getRadio() {
        return radio;
    }

    public String getColorRelleno() {
        return colorRelleno;
    }

    public String getColorLinea() {
        return colorLinea;
    }

    public double calcularPerimetro() {
        return 2*radio*Math.PI;
    }

    public double calcularArea() {
        return Math.PI*Math.pow(radio,2);
    }

    @Override
    public String toString() {
        return "El perímetro y el área del círculo son " + String.format("%.2f", calcularPerimetro()) + " y " + String.format("%.2f", calcularArea()) + ", respectivamente";
    }

}