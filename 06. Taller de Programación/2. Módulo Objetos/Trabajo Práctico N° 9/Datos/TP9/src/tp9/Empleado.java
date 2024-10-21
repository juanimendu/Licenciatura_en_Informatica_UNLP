package tp9;

public abstract class Empleado {

    private String nombre;
    private double sueldoBasico;
    private int antiguedad;

    public Empleado(String unNombre, double unSueldo, int unaAntiguedad){
        setNombre(unNombre);
        setSueldoBasico(unSueldo);
        setAntiguedad(unaAntiguedad);
    }

    public void setNombre(String unNombre){
        nombre=unNombre;
    }

    public void setSueldoBasico(double unSueldoBasico){
        sueldoBasico=unSueldoBasico;
    }

    public void setAntiguedad(int unaAntiguedad){
        antiguedad=unaAntiguedad;
    }

    public String getNombre() {
        return nombre;
    }

    public double getSueldoBasico() {
        return sueldoBasico;
    }

    public int getAntiguedad() {
        return antiguedad;
    }

    @Override
    public String toString() {
        return "Nombre: " + getNombre() + "; Sueldo a cobrar: $" + String.format("%.2f", this.calcularSueldoACobrar()) + "; Efectividad: " + String.format("%.2f", this.calcularEfectividad());
    }

    public abstract double calcularEfectividad();
    public abstract double calcularSueldoACobrar();

}