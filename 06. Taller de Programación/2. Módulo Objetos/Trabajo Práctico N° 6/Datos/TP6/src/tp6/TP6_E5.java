/*TRABAJO PRÁCTICO N° 6*/
/*EJERCICIO 5*/
/*El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen (con puntaje de 1 a 10) los siguientes aspectos:
(0) Atención al cliente, (1) Calidad de la comida, (2) Precio, (3) Ambiente.
Escribir un programa que lea desde teclado las calificaciones de los cinco clientes para cada uno de los aspectos y almacene la información en una estructura.
Luego, imprima la calificación promedio obtenida por cada aspecto.*/

package tp6;

import PaqueteLectura.*;

public class TP6_E5 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Almacenar las califaciones de los cinco clientes para cada uno de los aspectos en una estructura
        int clientes=5;
        int aspectos=4;
        int[][] restaurante=new int[clientes][aspectos];
        int puntajeMin=1;
        int puntajeMax=10;
        for (int i=0; i<clientes; i++)
            for (int j=0; j<aspectos; j++)
                restaurante[i][j]=puntajeMin+GeneradorAleatorio.generarInt(puntajeMax-puntajeMin+1);

        // Imprimir la califación promedio obtenida para cada aspecto
        for (int j=0; j<aspectos; j++) {
            double suma=0;
            for (int i=0; i<clientes; i++)
                suma+=restaurante[i][j];
            System.out.println("La calificación promedio obtenida por el aspecto " + j + " es " + suma/clientes);
        }

    }
}