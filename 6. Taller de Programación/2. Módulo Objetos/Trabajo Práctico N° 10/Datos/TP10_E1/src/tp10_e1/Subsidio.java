package tp10_e1;

public class Subsidio {

    private double monto;
    private String motivo;
    private boolean otorgado=false;

    public Subsidio(double unMonto, String unMotivo) {
        setMonto(unMonto);
        setMotivo(unMotivo);
    }

    private void setMonto(double unMonto) {
        monto=unMonto;
    }

    private void setMotivo(String unMotivo) {
        motivo=unMotivo;
    }

    public void setOtorgado(boolean Otorgado) {
        otorgado=Otorgado;
    }

    public double getMonto() {
        return monto;
    }

    public String getMotivo() {
        return motivo;
    }

    public boolean getOtorgado() {
        return otorgado;
    }

}