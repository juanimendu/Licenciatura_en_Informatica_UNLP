/*TRABAJO PRÁCTICO N° 6*/
/*EJERCICIO 1*/
/*Analizar el programa Ej01Tabla2.java, que carga un vector que representa la tabla del 2.
Luego, escribir las instrucciones necesarias para generar enteros aleatorios hasta obtener el número 11.
Para cada número, mostrar el resultado de multiplicarlo por 2 (accediendo al vector).*/

package tp6;

import PaqueteLectura.*;

public class TP6_E1 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        int dimF=11;
        int[] tabla2=new int[dimF];
        for (int i=0; i<dimF; i++) {
            tabla2[i]=2*i;
            System.out.println("2 x " + i + " = " + tabla2[i]);
        }
        System.out.println();

        // Generar enteros aleatorios hasta obtener el número 11. Para cada número, mostrar el resultado de multiplicarlo por 2 (accediendo al vector) 
        int numSalida=11;
        int num=1+GeneradorAleatorio.generarInt(numSalida);
        while (num!=numSalida) {
            System.out.println("2 x " + num + " = " + tabla2[num]);
            num=1+GeneradorAleatorio.generarInt(numSalida);
        }

    }

}