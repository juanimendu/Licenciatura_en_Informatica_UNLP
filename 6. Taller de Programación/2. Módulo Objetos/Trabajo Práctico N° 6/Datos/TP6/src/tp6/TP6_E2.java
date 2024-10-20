/*TRABAJO PRÁCTICO N° 6*/
/*EJERCICIO 2*/
/*Escribir un programa que lea las alturas de los 15 jugadores de un equipo de básquet y las almacene en un vector.
Luego, informar:
•	La altura promedio.
•	La cantidad de jugadores con altura por encima del promedio.
NOTA: Se dispone de un esqueleto para este programa en Ej02Jugadores.java.*/

package tp6;

import PaqueteLectura.*;

public class TP6_E2 {

    public static void main(String[] args) {

        // Leer alturas de los 15 jugadores de un equipo de básquet y almacenarlos en un vector
        int dimF=15;
        double[] alturas=new double[dimF];
        int alturaMin=175;
        int alturaMax=225;
        double suma=0;
        for (int i=0; i<dimF; i++) {
            alturas[i]=alturaMin+GeneradorAleatorio.generarInt(alturaMax-alturaMin+1);
            System.out.println("Altura del jugador " + (i+1) + ": " + alturas[i]);
            suma+=alturas[i];
        }
        System.out.println();

        // Informar la Saltura promedio
        double prom=suma/dimF;
        System.out.println("La altura promedio es " + String.format("%.2f", prom) + " centímetros");
        System.out.println();

        // Informar la cantidad de jugadores con altura por encima del promedio
        int cant=0;
        for (int i=0; i<dimF; i++)
            if (alturas[i]>prom)
                cant++;
        System.out.println("La cantidad de jugadores con altura por encima del promedio es " + cant);

    }

}