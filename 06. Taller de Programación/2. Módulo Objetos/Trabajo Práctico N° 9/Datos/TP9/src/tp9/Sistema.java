package tp9;

import PaqueteLectura.*;

public abstract class Sistema {

    private Estacion estacion;
    private int anioInicial;
    private int cantAnios;
    private int cantMeses=12;
    private double[][] temperaturas;
    private String[] meses=new String[]{"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};

    public Sistema(Estacion unaEstacion, int unAnioInicial, int cantAnios) {
        setEstacion(unaEstacion);
        setAnioInicial(unAnioInicial);
        setCantAnios(cantAnios);
        setTemperaturas();
    }

    public void setEstacion(Estacion unaEstacion) {
        estacion=unaEstacion;
    }

    public void setAnioInicial(int unAnioInicial) {
        anioInicial=unAnioInicial;
    }

    private void setCantAnios(int cantAnios) {
        this.cantAnios=cantAnios;
    }

    private void setTemperaturas() {
        temperaturas=new double[getCantAnios()][getCantMeses()];
        for (int i=0; i<getCantAnios(); i++)
            for (int j=0; j<getCantMeses(); j++)
                getTemperaturas()[i][j]=100;
    }

    public Estacion getEstacion() {
        return estacion;
    }

    public int getAnioInicial() {
        return anioInicial;
    }

    public int getCantAnios() {
        return cantAnios;
    }

    public int getCantMeses() {
        return cantMeses;
    }

    private double[][] getTemperaturas() {
        return temperaturas;
    }

    public void setTemp(int unAnio, int unMes, double unaTemp) {
        getTemperaturas()[unAnio][unMes]=unaTemp;
    }

    public double getTemp(int unAnio, int unMes) {
        return getTemperaturas()[unAnio][unMes];
    }

    public String mayorTemp() {
        double tempMax=-1;
        int anioMax=-1;
        int mesMax=-1;
        for (int i=0; i<getCantAnios(); i++)
            for (int j=0; j<getCantMeses(); j++) {
                if (getTemp(i,j)>tempMax) {
                    tempMax=getTemp(i,j);
                    anioMax=i;
                    mesMax=j;
                }
            }
        return "La temperatura máxima de " + String.format("%.2f", tempMax) + "°C de la estación " + getEstacion().getNombre() + " se registró en el mes de " + meses[mesMax] + " del año " + (getAnioInicial()+anioMax);
    }

    @Override
    public String toString() {
        return getEstacion().toString() + "\n" + this.retornarMedia();
    }

    public abstract String retornarMedia();

}