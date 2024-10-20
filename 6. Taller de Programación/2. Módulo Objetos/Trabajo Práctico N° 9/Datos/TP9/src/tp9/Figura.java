package tp9;

public abstract class Figura {

    private String colorRelleno;
    private String colorLinea;

    public Figura(String unColorRelleno, String unColorLinea) {
        setColorRelleno(unColorRelleno);
        setColorLinea(unColorLinea);
    }

    public void setColorRelleno(String unColorRelleno) {
        colorRelleno=unColorRelleno;
    }

    public void setColorLinea(String unColorLinea) {
        colorLinea=unColorLinea;
    }

    public String getColorRelleno() {
        return colorRelleno;
    }

    public String getColorLinea() {
        return colorLinea;       
    }

    public void despintar() {
        setColorRelleno("Blanco");
        setColorLinea("Negro");
    }

    @Override
    public String toString() {
        return "Color Relleno: " + getColorRelleno() + "; Color Línea: " + getColorLinea() + "; Perímetro: " + String.format("%.2f", this.calcularPerimetro()) + "; Área: " + String.format("%.2f", this.calcularArea());
    }

    public abstract double calcularPerimetro();
    public abstract double calcularArea();

}