/*TRABAJO PRÁCTICO N° 9*/
/*EJERCICIO 3*/
/*
(a) Implementar las clases para el siguiente problema. Una garita de seguridad quiere identificar los distintos tipos de personas que entran a un barrio cerrado. Al barrio, pueden entrar: personas, que se caracterizan por nombre, DNI y edad; y trabajadores, estos son personas que se caracterizan, además, por la tarea realizada en el predio. Implementar constructores, getters y setters para las clases. Además, tanto las personas como los trabajadores, deben responder al mensaje toString siguiendo el formato:
•	Personas: “Mi nombre es Mauro, mi DNI es 11203737 y tengo 70 años.”
•	Trabajadores: “Mi nombre es Mauro, mi DNI es 11203737 y tengo 70 años. Soy jardinero.”
(b) Realizar un programa que instancie una persona y un trabajador y mostrar la representación de cada uno en consola.
NOTA: Reutilizar la clase Persona (carpeta tema2).
*/

package tp9;

import PaqueteLectura.*;

public class TP9_E3 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Instanciar una persona y un trabajador
        int nombreTam=5;
        int dniMin=1000000;
        int dniMax=5000000;
        int edadMin=18;
        int edadMax=100;
        int tareaTam=10;
        Persona persona=new Persona(GeneradorAleatorio.generarString(nombreTam), dniMin+GeneradorAleatorio.generarInt(dniMax-dniMin+1), edadMin+GeneradorAleatorio.generarInt(edadMax-edadMin+1));
        Trabajador trabajador=new Trabajador(GeneradorAleatorio.generarString(nombreTam), dniMin+GeneradorAleatorio.generarInt(dniMax-dniMin+1), edadMin+GeneradorAleatorio.generarInt(edadMax-edadMin+1), GeneradorAleatorio.generarString(tareaTam));

        // Mostrar la representación de cada uno en consola
        System.out.println("REPRESENTACIÓN STRING DE LA PERSONA: " + persona.toString());
        System.out.println("REPRESENTACIÓN STRING DEL TRABAJADOR: " + trabajador.toString());

    }

}