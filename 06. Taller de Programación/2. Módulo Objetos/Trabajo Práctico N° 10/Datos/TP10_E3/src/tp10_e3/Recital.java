package tp10_e3;

public abstract class Recital {

    private String nombreRecital;
    private int temasMax;
    private int cantTemas=0;
    private String[] temas;

    public Recital(String unNombreRecital, int temasMax) {
        setNombreRecital(unNombreRecital);
        setTemasMax(temasMax);
        setTemas();
    }

    public void setNombreRecital(String unNombreRecital) {
        nombreRecital=unNombreRecital;
    }

    private void setTemasMax(int temasMax) {
        this.temasMax=temasMax;
    }

    private void setTemas() {
        temas=new String[getTemasMax()];
    }

    private void setCantTemas(int cantTemas) {
        this.cantTemas=cantTemas;
    }

    public String getNombreRecital() {
        return nombreRecital;
    }

    public int getTemasMax() {
        return temasMax;
    }

    public int getCantTemas() {
        return cantTemas;
    }

    private String[] getTemas() {
        return temas;
    }

    private boolean quedaEspacio() {
        return getCantTemas()<getTemasMax();
    }

    public void agregarTema(String unTema) {
        if (quedaEspacio()) {
            getTemas()[getCantTemas()]=unTema;
            setCantTemas(++cantTemas);
        }
        else
            System.out.println("No es posible agregar más temas al recital");
    }

    public String actuar() {
        String aux="";
        for (int i=0; i<getCantTemas(); i++)
            aux+="Y ahora tocaremos '" + getTemas()[i] + "'\n"; 
        return aux + "El costo del recital " + getNombreRecital() + " fue $" + this.calcularCosto();
    }

    public abstract int calcularCosto();

}