/*TRABAJO PRÁCTICO N° 7*/
/*EJERCICIO 2*/
/*Utilizando la clase Persona, realizar un programa que almacene en un vector, a lo sumo, 15 personas.
La información (nombre, DNI, edad) se debe generar aleatoriamente hasta obtener edad 0. Luego de almacenar la información:
•	Informar la cantidad de personas mayores de 65 años.
•	Mostrar la representación de la persona con menor DNI.*/

package tp7;

import PaqueteLectura.*;

public class TP7_E2 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Almacenar en un vector, a lo sumo, 15 personas
        int dimF=15;
        Persona[] personas=new Persona[dimF];
        Persona persona=new Persona();
        int dimL=0;
        int nombreTam=10;
        int dniMin=10000000;
        int dniMax=50000000;
        int edadMax=100;
        int edadSalida=0;
        persona.setEdad(GeneradorAleatorio.generarInt(edadMax));
        while ((persona.getEdad()!=edadSalida) && (dimL<dimF)) {
            persona.setNombre(GeneradorAleatorio.generarString(nombreTam));
            persona.setDni(dniMin+GeneradorAleatorio.generarInt(dniMax-dniMin+1));
            personas[dimL]=persona;
            persona=new Persona();
            persona.setEdad(edadSalida+GeneradorAleatorio.generarInt(edadMax));
            dimL++;
        }

        // Informar la cantidad de personas mayores de 65 años
	// Mostrar la representación de la persona con menor DNI
        int edadCorte=65;
        int personasCorte=0;
        Persona personaMenorDni=new Persona();
        int dniMin2=dniMax+1;
        for (int i=0; i<dimL; i++) {
            if (personas[i].getEdad()>edadCorte)
                personasCorte++;
            if (personas[i].getDni()<dniMin2) {
                dniMin2=personas[i].getDni();
                personaMenorDni=personas[i];
            }
        }
        System.out.println("La cantidad de personas mayores de 65 años es " + personasCorte);
        System.out.println("La representación de la persona con menor DNI es '" + personaMenorDni.toString() + "'");

    }

}