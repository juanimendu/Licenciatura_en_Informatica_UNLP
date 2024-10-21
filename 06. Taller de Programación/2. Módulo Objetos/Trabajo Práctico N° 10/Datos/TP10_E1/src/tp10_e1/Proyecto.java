package tp10_e1;

import PaqueteLectura.*;

public class Proyecto {

    private String proyecto;
    private int codigo;
    private String director;
    private int invesMax=50;
    private int cantInves=0;
    private Investigador[] investigadores;

    public Proyecto(String unProyecto, int unCodigo, String unDirector) {
        setProyecto(unProyecto);
        setCodigo(unCodigo);
        setDirector(unDirector);
        setInvestigadores();
    }

    public void setProyecto(String unProyecto) {
        proyecto=unProyecto;
    }

    public void setCodigo(int unCodigo) {
        codigo=unCodigo;
    }

    public void setDirector(String unDirector) {
        director=unDirector;
    }

    private void setCantInves(int cantInves) {
        this.cantInves=cantInves;
    }

    private void setInvestigadores() {
        investigadores=new Investigador[getInvesMax()];
        for (int i=0; i<getInvesMax(); i++)
            getInvestigadores()[i]=null;
    }

    public String getProyecto() {
        return proyecto;
    }

    public int getCodigo() {
        return codigo;
    }

    public String getDirector() {
        return director;
    }

    public int getInvesMax() {
        return invesMax;
    }

    public int getCantInves() {
        return cantInves;
    }

    private Investigador[] getInvestigadores() {
        return investigadores;
    }

    private boolean quedaEspacio() {
        return getCantInves()<getInvesMax();
    }

    public void agregarInvestigador(Investigador unInvestigador) {
        if (quedaEspacio()) {
            getInvestigadores()[getCantInves()]=unInvestigador;
            setCantInves(++cantInves);
        }
        else
            System.out.println("No es posible agregar más investigadores al proyecto");
    }

    public void agregarSubsidio(int unInvestigador, double unMonto, String unMotivo) {
        getInvestigadores()[unInvestigador].agregarSubsidio(unMonto, unMotivo);
    }

    public double dineroTotalOtorgado() {
        double suma=0;
        for (int i=0; i<getCantInves(); i++)
            suma+=getInvestigadores()[i].totalSubsidios();
        return suma;
    }

    private int buscarInvestigador(String unInvestigador) {
        int inv=0;
        while ((inv<getCantInves()) && (!getInvestigadores()[inv].getNombre().equals(unInvestigador)))
            inv++;
        if (inv<getCantInves())
            return inv;
        else
            return -1;
    }

    public void otorgarTodos(String unInvestigador) {
        int inv=buscarInvestigador(unInvestigador);
        if (inv!=-1)
            while ((getInvestigadores()[inv].quedaEspacio()))
                getInvestigadores()[inv].agregarSubsidio(GeneradorAleatorio.generarDouble(1000), GeneradorAleatorio.generarString(10));
        else
            System.out.println("Este investigador no existe");
    }

    @Override
    public String toString() {
        String aux="";
        for (int i=0; i<getCantInves(); i++)
            aux+=getInvestigadores()[i].toString() + "\n";
        return "Nombre del Proyecto: " + getProyecto() + "; Código del Proyecto: " + getCodigo() + "; Nombre del Director del Proyecto: " + getDirector() + "; Dinero total de subsidios otorgados al Proyecto: $" + String.format("%.2f", dineroTotalOtorgado()) + "\nINFORMACIÓN DE LOS INVESTIGADORES DEL PROYECTO:\n" + aux;
    }

}