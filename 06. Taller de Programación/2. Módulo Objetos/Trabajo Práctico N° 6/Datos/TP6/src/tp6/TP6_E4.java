/*TRABAJO PRÁCTICO N° 6*/
/*EJERCICIO 4*/
/*Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso (1..4).
Realizar un programa que permita informar la cantidad de personas que concurrieron a cada oficina de cada piso.
Para esto, simular la llegada de personas al edificio de la siguiente manera: a cada persona, se le pide el nro. de piso y nro. de oficina a la cual quiere concurrir.
La llegada de personas finaliza al indicar un nro. de piso 9. Al finalizar la llegada de personas, informar lo pedido.*/

package tp6;

import PaqueteLectura.*;

public class TP6_E4 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Simular la llegada de personas al edificio
        int pisos=8;
        int oficinas=4;
        int pisoSalida=9;
        int[][] edificio=new int[pisos][oficinas];
        int piso=1+GeneradorAleatorio.generarInt(pisoSalida);
        int oficina;
        while (piso!=pisoSalida) {
            oficina=1+GeneradorAleatorio.generarInt(oficinas);
            edificio[piso-1][oficina-1]++;
            piso=1+GeneradorAleatorio.generarInt(pisoSalida);
        }

        // Informar la cantidad de personas que concurrieron a cada oficina de cada piso
        for (int i=0; i<pisos; i++) {
            for(int j=0; j<oficinas; j++)
                System.out.println("La cantidad de personas que concurrieron a la oficina " + (j+1) + " del piso " + (i+1) + " es " + edificio[i][j]);
            System.out.println();
        }
    }

}