package tp9;

public class Entrenador extends Empleado {

    private int campeonatosGanados;

    public Entrenador(String unNombre, double unSueldo, int unaAntiguedad, int campeonatos) {
        super(unNombre, unSueldo, unaAntiguedad);
        setCampeonatosGanados(campeonatos);
    }

    public void setCampeonatosGanados(int campeonatos) {
        campeonatosGanados=campeonatos;
    }

    public int getCampeonatosGanados() {
        return campeonatosGanados;
    }

    @Override
    public double calcularEfectividad() {
        return (double) getCampeonatosGanados()/getAntiguedad();
    }

    @Override
    public double calcularSueldoACobrar() {
        double sueldo=(1+getAntiguedad()*0.10)*getSueldoBasico();
        if ((getCampeonatosGanados()>0) && (getCampeonatosGanados()<=4))
            sueldo+=5000;
        else
            if ((getCampeonatosGanados()>=5) && (getCampeonatosGanados()<=10))
                sueldo+=30000;
            else
                sueldo+=50000;
        return sueldo;
    }

}