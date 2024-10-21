package tp9;

public class Jugador extends Empleado {

    private int partidosJugados;
    private int golesAnotados;

    public Jugador(String unNombre, double unSueldo, int unaAntiguedad, int partidos, int goles) {
        super(unNombre, unSueldo, unaAntiguedad);
        setPartidosJugados(partidos);
        setGolesAnotados(goles);
    }

    public void setPartidosJugados(int partidos) {
        partidosJugados=partidos;
    }

    public void setGolesAnotados(int goles) {
        golesAnotados=goles;
    }

    public int getPartidosJugados() {
        return partidosJugados;
    }

    public int getGolesAnotados() {
        return golesAnotados;
    }

    @Override
    public double calcularEfectividad() {
        return (double) getGolesAnotados()/getPartidosJugados();
    }

    @Override
    public double calcularSueldoACobrar() {
        double sueldo=(1+getAntiguedad()*0.10)*getSueldoBasico();
        if (calcularEfectividad()>0.5)
            sueldo+=getSueldoBasico();
        return sueldo;
    }

}