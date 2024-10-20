package tp10_e4;

public class CoroSemicircular extends Coro {

    private int coristasMax;
    private int cantCoristas;
    private Corista[] coristas;

    public CoroSemicircular(String unNombreCoro, Director unDirector, int coristasMax) {
        super(unNombreCoro, unDirector);
        setCoristasMax(coristasMax);
        setCoristas();
    }

    private void setCoristasMax(int coristasMax) {
        this.coristasMax=coristasMax;
    }

    private void setCantCoristas(int cantCoristas) {
        this.cantCoristas=cantCoristas;
    }

    private void setCoristas() {
        coristas=new Corista[getCoristasMax()];
    }

    public int getCantCoristas() {
        return cantCoristas;
    }

    public int getCoristasMax() {
        return coristasMax;
    }

    private Corista[] getCoristas() {
        return coristas;
    }

    @Override
    public boolean estaLleno() {
        return getCantCoristas()==getCoristasMax();
    }

    @Override
    public void agregarCorista(Corista unCorista) {
        if (!estaLleno()) {
            getCoristas()[getCantCoristas()]=unCorista;
            setCantCoristas(++cantCoristas);
        }
        else
            System.out.println("No es posible agregar más coristas al coro");
    }

    @Override
    public boolean estaBienFormado() {
        boolean ok=true;
        int tono;
        int aux=999;
        int i=0;
        while ((ok) && (i<getCantCoristas())) {
            tono=getCoristas()[i].getTono();
            if (tono<aux)
                aux=tono;
            else
                ok=false;
            i++;
        }
        return ok;
    }

    @Override
    public String toString() {
        String aux="";
        for (int i=0; i<getCantCoristas(); i++)
            aux+=getCoristas()[i].toString() + "\n";
        return super.toString() + aux;
    }

}