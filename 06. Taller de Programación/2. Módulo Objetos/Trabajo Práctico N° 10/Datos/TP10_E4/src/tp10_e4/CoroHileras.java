package tp10_e4;

public class CoroHileras extends Coro {

    private int filasMax;
    private int columnasMax;
    private int cantFilas=0;
    private int[] cantColumnas;
    private Corista[][] coristas;

    public CoroHileras(String unNombreCoro, Director unDirector, int filasMax, int columnasMax) {
        super(unNombreCoro, unDirector);
        setFilasMax(filasMax);
        setColumnasMax(columnasMax);
        setCantColumnas();
        setCoristas();
    }

    private void setFilasMax(int filasMax) {
        this.filasMax=filasMax;
    }

    private void setColumnasMax(int columnasMax) {
        this.columnasMax=columnasMax;
    }

    private void setCantFilas(int cantFilas) {
        this.cantFilas=cantFilas;
    }

    private void setCantColumnas() {
        cantColumnas=new int[getFilasMax()];
        for (int i=0; i<getFilasMax(); i++)
            getCantColumnas()[i]=0;
    }

    private void aumentarCantColumnas(int cantFilas) {
        this.cantColumnas[cantFilas]+=1;
    }

    private void setCoristas() {
        coristas=new Corista[getFilasMax()][getColumnasMax()];
    }

    public int getFilasMax() {
        return filasMax;
    }

    public int getColumnasMax() {
        return columnasMax;
    }

    public int getCantFilas() {
        return cantFilas;
    }

    public int[] getCantColumnas() {
        return cantColumnas;
    }

    private Corista[][] getCoristas() {
        return coristas;
    }

    @Override
    public boolean estaLleno() {
        return getCantColumnas()[getFilasMax()-1]==getColumnasMax();
    }

    @Override
    public void agregarCorista(Corista unCorista) {
        if (!estaLleno()) {
            getCoristas()[getCantFilas()][getCantColumnas()[getCantFilas()]]=unCorista;
            aumentarCantColumnas(cantFilas);
            if (getCantColumnas()[getCantFilas()]==getColumnasMax())
                setCantFilas(++cantFilas);
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
        int j;
        while ((ok) && (i<getCantFilas())) {
            j=0;
            tono=getCoristas()[i][j].getTono();
            if (tono<aux)
                aux=tono;
            else
                ok=false;
            while (((ok)) && (j<getCantColumnas()[i]) && (tono==getCoristas()[i][j].getTono()))
                j++;
            if ((ok) && (j<getCantColumnas()[i]))
                ok=false;
            i++;
        }
        return ok;
    }

    @Override
    public String toString() {
        String aux="";
        for (int i=0; i<getCantFilas(); i++)
            for (int j=0; j<getCantColumnas()[i]; j++)
                aux+=getCoristas()[i][j].toString() + "\n";
        return super.toString() + aux;
    }

}