/*TRABAJO PRÁCTICO N° 6*/
/*EJERCICIO 3*/
/*Escribir un programa que defina una matriz de enteros de tamaño 5x5. Inicializar la matriz con números aleatorios entre 0 y 30.
Luego, realizar las siguientes operaciones:
•	Mostrar el contenido de la matriz en consola.
•	Calcular e informar la suma de los elementos de la fila 1.
•	Generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. Luego, imprimir el vector.
•	Leer un valor entero e indicar si se encuentra o no en la matriz. En caso de encontrarse, indicar su ubicación (fila y columna), en caso contrario imprimir “No se encontró el elemento”.
NOTA: Se dispone de un esqueleto para este programa en Ej03Matrices.java.*/

package tp6;

import PaqueteLectura.*;

public class TP6_E3 {

    public static void main(String[] args) {
 
	GeneradorAleatorio.iniciar();

        // Definir una matriz de enteros de 5x5
        int dim=5;
        int[][] matriz=new int[dim][dim];

        // Inicializar la matriz con números aleatorios entre 0 y 30
        int num1=31;
        for (int i=0; i<dim; i++)
            for(int j=0; j<dim; j++)
                matriz[i][j]=GeneradorAleatorio.generarInt(num1);

        // Mostrar el contenido de la matriz en consola
        for (int i=0; i<dim; i++) {
            for (int j=0; j<dim; j++) {
                System.out.print("(" + (i+1) + "," + (j+1) + ") " + matriz[i][j] + " | ");
            }
            System.out.println();
        }
        System.out.println();

        // Calcular e informar la suma de los elementos de la fila 1
        int suma1=0;
        for (int j=0; j<dim; j++)
            suma1+=matriz[1][j];
        System.out.println("La suma de los elementos de la fila 1 es " + suma1);
        System.out.println();

        // Generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. Luego, imprimir el vector
        int[] vector=new int[dim];
        for(int j=0; j<dim; j++){
            int suma2=0;
            for (int i=0; i<dim; i++)
                suma2+=matriz[i][j];
            vector[j]=suma2;
            System.out.println("La suma de los elementos de la columna " + (j+1) + " de la matriz es " + vector[j]);
        }
        System.out.println();

        // Leer un valor entero e indicar si se encuentra o no en la matriz. En caso de encontrarse, indicar su ubicación (fila y columna), en caso contrario imprimir "No se encontró el elemento"
        int num2=GeneradorAleatorio.generarInt(num1);
        int i=0;
        int j=0;
        while ((i<dim) && (matriz[i][j]!=num2)){
            while((j<dim) && (matriz[i][j]!=num2))
                j++;
            if (j==dim) {
                j=0;
                i++;
            }
        }
        if (i<dim)
            System.out.println("El número " + num2 + " se encontró en la ubicación (" + (i+1) + "," + (j+1) + ") de la matriz");
        else
            System.out.println("No se encontró el elemento " + num2);

    }

}