package tp10_e1;

public class Investigador {

    private String nombre;
    private int categoria;
    private String especialidad;
    private int subMax=5;
    private int cantSub=0;
    private Subsidio[] subsidios;

    public Investigador(String unNombre, int unaCategoria, String unaEspecialidad) {
        setNombre(unNombre);
        setCategoria(unaCategoria);
        setEspecialidad(unaEspecialidad);
        setSubsidios();
    }

    public void setNombre(String unNombre) {
        nombre=unNombre;
    }

    public void setCategoria(int unaCategoria) {
        categoria=unaCategoria;
    }

    public void setEspecialidad(String unaEspecialidad) {
        especialidad=unaEspecialidad;
    }

    private void setCantSub(int cantSub) {
        this.cantSub=cantSub;
    }

    private void setSubsidios() {
        subsidios=new Subsidio[getSubMax()];
        for (int i=0; i<getSubMax(); i++)
            getSubsidios()[i]=null;
    }

    public String getNombre() {
        return nombre;
    }

    public int getCategoria() {
        return categoria;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public int getSubMax() {
        return subMax;
    }
 
    public int getCantSub() {
        return cantSub;
    }

    private Subsidio[] getSubsidios() {
        return subsidios;
    }

    public boolean quedaEspacio() {
        return getCantSub()<getSubMax();
    }

    public void agregarSubsidio(double unMonto, String unMotivo) {
        if (quedaEspacio()) {
            getSubsidios()[getCantSub()]=new Subsidio(unMonto, unMotivo);
            setCantSub(++cantSub);
        }
        else
            System.out.println("No es posible agregar más subsidios al investigador");
    }

    public double totalSubsidios() {
        double suma=0;
        for (int i=0; i<getCantSub(); i++)
            suma+=getSubsidios()[i].getMonto();
        return suma;
    }

    @Override
    public String toString() {
        return "Nombre: " + getNombre() + "; Categoría: " + (getCategoria()+1) + "; Especialidad: " + getEspecialidad() + "; Dinero total de subsidios otorgados al Investigador: $" + String.format("%.2f", totalSubsidios());
    }

}