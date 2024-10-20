package tp9;

public class VisorFigurasModificado {

    private int figurasMax=5;
    private int cantFiguras=0;
    private Figura[] figuras;

    public VisorFigurasModificado() {
        setFiguras();
    }

    private void setCantFiguras(int cantFiguras) {
        this.cantFiguras=cantFiguras;
    }

    private void setFiguras() {
        figuras=new Figura[getFigurasMax()];
        for (int i=0; i<getFigurasMax(); i++)
            getFiguras()[i]=null;
    }

    public int getFigurasMax() {
        return figurasMax;
    }

    public int getCantFiguras() {
        return cantFiguras;
    }

    private Figura[] getFiguras() {
        return figuras;
    }

    private boolean quedaEspacio() {
        return getCantFiguras()<getFigurasMax();
    }

    public void guardar(Figura unaFigura) {
        if (quedaEspacio()) {
            getFiguras()[getCantFiguras()]=unaFigura;
            setCantFiguras(++cantFiguras);
        }
        else
            System.out.println("No es posible agregar más figuras al visor");
    }

    public void mostrar() {
        for (int i=0; i<getCantFiguras(); i++)
            System.out.println(getFiguras()[i].toString());
    }

}