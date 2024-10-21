package tp8;

public class Hotel {

    private int habMax=100;
    private int cantHab=0;
    private Habitacion[] habitaciones;

    public Hotel() {
        setHabitaciones();
    }

    public Hotel(int habMax) {
        setHabMax(habMax);
        setHabitaciones();
    }

    private void setHabMax(int habMax) {
        this.habMax=habMax;
    }

    private void setCantHab(int cantHab) {
        this.cantHab=cantHab;
    }

    private void setHabitaciones() {
        habitaciones=new Habitacion[habMax];
        for (int i=0; i<habMax; i++)
            habitaciones[i]=new Habitacion();
    }

    public int getHabMax() {
        return habMax;
    }

    public int getCantHab() {
        return cantHab;
    }

    private Habitacion[] getHabitaciones() {
        return habitaciones;
    }

    public void ocuparHab(int unaHabitacion, Cliente unCliente) {
        if (!habitaciones[unaHabitacion].getOcupada()) {
            habitaciones[unaHabitacion].ocuparHabitacion(unCliente);
            cantHab++;
        }
    }
    
    public void aumentarPrecios(double unPrecio) {
        for (int i=0; i<habMax; i++)
            habitaciones[i].aumentarPrecio(unPrecio);
    }

    @Override
    public String toString() {
        String aux="";
        for (int i=0; i<habMax; i++)
            aux+="Habitación " + (i+1) + ": " + habitaciones[i].toString() + "\n";
        return aux;
    }

}