package tp7;

public class Partido {

    private String local=null;
    private String visitante=null;
    private int golesLocal=-1;
    private int golesVisitante=-1;

    public Partido(String unLocal, String unVisitante, int unGolLocal, int unGolVisitante) {
        local=unLocal;
        visitante=unVisitante;
        golesLocal=unGolLocal;
        golesVisitante=unGolVisitante;
    }

    public Partido() {
        
    }

    public void setLocal(String unEquipo) {
        local=unEquipo;
    }

    public void setVisitante(String unEquipo) {
        visitante=unEquipo;
    }

    public void setGolesLocal(int unosGoles) {
        golesLocal=unosGoles;
    }

    public void setGolesVisitante(int unosGoles) {
        golesVisitante=unosGoles;
    }

    public String getLocal() {
        return local;
    }

    public String getVisitante() {
        return visitante;
    }

    public int getGolesLocal() {
        return golesLocal;
    }

    public int getGolesVisitante() {
        return golesVisitante;
    }

    public boolean hayGanador() {
        return golesLocal!=golesVisitante;
    }

    public boolean hayEmpate() {
        return golesLocal==golesVisitante;
    }

    public String getGanador() {
        String ganador="";
        if (golesLocal>golesVisitante)
            ganador=local;
        else if (golesLocal<golesVisitante)
            ganador=visitante;
        return ganador;
    }

}