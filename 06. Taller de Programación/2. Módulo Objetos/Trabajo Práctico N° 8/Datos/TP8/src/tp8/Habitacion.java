package tp8;

import PaqueteLectura.*;

public class Habitacion {

    private double costo=2000+GeneradorAleatorio.generarDouble(6001);
    private boolean ocupada=false;
    private Cliente cliente=null;

    public Habitacion() {
        
    }

    private void setCosto(double unCosto) {
        costo=unCosto;
    }

    public void setOcupada(boolean Ocupada) {
        ocupada=Ocupada;
    }

    public void setCliente(Cliente unCliente) {
        cliente=unCliente;
    }

    public double getCosto() {
        return costo;
    }

    public boolean getOcupada() {
        return ocupada;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void ocuparHabitacion(Cliente unCliente) {
        setOcupada(true);
        setCliente(unCliente);
    }

    public void aumentarPrecio(double unPrecio) {
        setCosto(costo+unPrecio);
    }

    @Override
    public String toString() {
        if (getOcupada())
            return "Costo $" + String.format("%.2f", costo) + "; Ocupada; " + cliente.toString();
        else
            return "Costo $" + String.format("%.2f", costo) + "; Libre";
    }

}