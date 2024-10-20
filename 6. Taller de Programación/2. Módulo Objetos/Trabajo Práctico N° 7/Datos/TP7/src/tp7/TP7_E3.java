/*TRABAJO PRÁCTICO N° 7*/
/*EJERCICIO 3*/
/*Se realizará un casting para un programa de TV. El casting durará, a lo sumo, 5 días y, en cada día, se entrevistarán a 8 personas en distinto turno.
(a) Simular el proceso de inscripción de personas al casting. A cada persona, se le pide nombre, DNI y edad y se la debe asignar en un día y turno de la siguiente manera: las personas, primero, completan el primer día en turnos sucesivos, luego el segundo día y así siguiendo. La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los 40 cupos de casting.
(b) Una vez finalizada la inscripción, informar, para cada día y turno asignado, el nombre de la persona a entrevistar.
NOTA: Utilizar la clase Persona. Pensar en la estructura de datos a utilizar. Para comparar Strings, usar el método equals.*/

package tp7;

import PaqueteLectura.*;

public class TP7_E3 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        int dias=5;
        int turnos=8;
        Persona[][] personas=new Persona[dias][turnos];
        Persona persona=new Persona();
        int nombreTam=3;
        String nombreSalida="ZZZ";
        int dniMin=10000000;
        int dniMax=50000000;
        int edadMin=10;
        int edadMax=100;

        // INCISO (a)
        int i=0;
        int j=0;
        int dimL=0;
        persona.setNombre(GeneradorAleatorio.generarString(nombreTam));
        while ((!persona.getNombre().equals(nombreSalida)) && (i<dias)) {
            while ((!persona.getNombre().equals(nombreSalida)) && (j<turnos)) {
                persona.setDni(dniMin+GeneradorAleatorio.generarInt(dniMax-dniMin+1));
                persona.setEdad(edadMin+GeneradorAleatorio.generarInt(edadMax-edadMin+1));
                personas[i][j]=persona;
                persona=new Persona();
                persona.setNombre(GeneradorAleatorio.generarString(nombreTam));
                dimL++;
                j++;
            }
            i++;
            j=0;
        }

        // INCISO (b)
        int dimLPrint=dimL;
        i=0;
        j=0;
        while ((i<dias) && (dimLPrint>0)) {
            while ((j<turnos) && (dimLPrint>0)) {
                System.out.println("El nombre de la persona a entrevistar en el (día,turno) = (" + (i+1) + "," + (j+1) + ") es '" + personas[i][j].getNombre() + "'");
                dimLPrint--;
                j++;
            }
            i++;
            j=0;
        }

    }

}