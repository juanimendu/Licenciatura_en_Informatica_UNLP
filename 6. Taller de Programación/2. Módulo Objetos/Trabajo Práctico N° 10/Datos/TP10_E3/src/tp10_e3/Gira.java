package tp10_e3;

public class Gira extends Recital {

    private String nombreGira;
    private int fechasMax;
    private int cantFechas=0;
    private Fecha[] fechas;
    private int actual=0;

    public Gira(String unNombreRecital, int temasMax, String unNombreGira, int fechasMax) {
        super(unNombreRecital, temasMax);
        setNombreGira(unNombreGira);
        setFechasMax(fechasMax);
        setFechas();
    }

    public void setNombreGira(String unNombreGira) {
        nombreGira=unNombreGira;
    }

    private void setFechasMax(int fechasMax) {
        this.fechasMax=fechasMax;
    }

    private void setCantFechas(int cantFechas) {
        this.cantFechas=cantFechas;
    }

    private void setFechas() {
        fechas=new Fecha[getFechasMax()];
        for (int i=0; i<getFechasMax(); i++)
            getFechas()[i]=null;
    }

    private void setActual(int actual) {
        this.actual=actual;
    }

    public String getNombreGira() {
        return nombreGira;
    }

    public int getFechasMax() {
        return fechasMax;
    }

    public int getCantFechas() {
        return cantFechas;
    }
 
    private Fecha[] getFechas() {
        return fechas;
    }

    private int getActual() {
        return actual;
    }

    private boolean quedaEspacio() {
        return getCantFechas()<getFechasMax();
    }

    public void agregarFecha(Fecha unaFecha) {
        if (quedaEspacio()) {
            getFechas()[getCantFechas()]=unaFecha;
            setCantFechas(++cantFechas);
        }
        else
            System.out.println("No es posible agregar más fechas a la gira");
    }

    @Override
    public String actuar() {
        String aux="";
        for (int i=0; i<getCantFechas(); i++) {
            aux+="Buenas noches. El nombre de la ciudad de la fecha actual " + (getActual()+1) + " es '" + getFechas()[getActual()].getCiudad() + "'\n";
            setActual(++actual);
        }
        aux+=super.actuar();
        return aux;
    }

    @Override
    public int calcularCosto() {
        int costo=0;
        for (int i=0; i<getCantFechas(); i++)
            costo++;
        costo=30000*costo;
        return costo;
    }

}