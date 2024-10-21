/*TRABAJO PRÁCTICO N° 10*/
/*EJERCICIO 4*/
/*
Una escuela de música arma coros para participar de ciertos eventos.
Los coros poseen un nombre y están formados por un director y una serie de coristas.
Del director, se conoce el nombre, DNI, edad y la antigüedad (un número entero).
De los coristas, se conoce el nombre, DNI, edad y el tono fundamental (un número entero).
Asimismo, hay dos tipos de coros: coro semicircular en el que los coristas se colocan en el escenario uno al lado del otro y coro por hileras donde los coristas se organizan en filas de igual dimensión.
(a) Implementar las clases necesarias teniendo en cuenta que los coros deberían crearse con un director y sin ningún corista, pero sí sabiendo las dimensiones del coro.
(b) Implementar métodos (en las clases donde corresponda) que permitan:
•	agregar un corista al coro.
    o	En el coro semicircular, los coristas se deben ir agregando de izquierda a derecha.
    o	En el coro por hileras, los coristas se deben ir agregando de izquierda a derecha, completando la hilera antes de pasar a la siguiente.
•	determinar si un coro está lleno o no. Devuelve true si el coro tiene a todos sus coristas asignados o false en caso contrario.
•	determinar si un coro (se supone que está lleno) está bien formado. Un coro está bien formado si:
    o	En el caso del coro semicircular, de izquierda a derecha, los coristas están ordenados de mayor a menor en cuanto a tono fundamental.
    o	En el caso del coro por hileras, todos los miembros de una misma hilera tienen el mismo tono fundamental y, además, todos los primeros miembros de cada hilera están ordenados de mayor a menor en cuanto a tono fundamental.
•	devolver la representación de un coro formada por el nombre del coro, todos los datos del director y todos los datos de todos los coristas.
(c) Escribir un programa que instancie un coro de cada tipo.
Leer o bien la cantidad de coristas (en el caso del coro semicircular) o la cantidad de hileras e integrantes por hilera (en el caso del coro por hileras).
Luego, crear la cantidad de coristas necesarios, leyendo sus datos y almacenándolos en el coro.
Finalmente, imprimir toda la información de los coros indicando si están bien formados o no.
*/

package tp10_e4;

import PaqueteLectura.*;

public class TP10_E4 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Instanciar un coro semicircular
        int coristasMax=4;
        Director director1=new Director("Juan Ignacio Menduiña", 37102205, 32, 10);
        CoroSemicircular corosemicircular=new CoroSemicircular("Coro Semicircular", director1, coristasMax);

        // Crear coristas y almacenarlos en coro semicircular
        Corista corista1=new Corista("Juan", 37, 30, 1);
        Corista corista2=new Corista("Ignacio", 102, 31, 2);
        Corista corista3=new Corista("Menduiña", 205, 32, 3);
        corosemicircular.agregarCorista(corista1);
        corosemicircular.agregarCorista(corista2);
        corosemicircular.agregarCorista(corista3);

        // Imprimir toda la información del coro semicircular
        System.out.println(corosemicircular.toString()); 
        System.out.println("¿El coro semicircular está lleno? " + corosemicircular.estaLleno());
        System.out.println("¿El coro semicircular está bien formado? " + corosemicircular.estaBienFormado());
        System.out.println();

        // Instanciar un coro hileras
        int filasMax=3;
        int columnasMax=3;
        Director director2=new Director("Demian Tupac Panigo", 20040864, 50, 10);
        CoroHileras corohileras=new CoroHileras("Coro Hileras", director2, filasMax, columnasMax);

        // Crear coristas y almacenarlos en coro hileras
        Corista corista4=new Corista("Demian", 24, 48, 4);
        Corista corista5=new Corista("Tupac", 040, 49, 5);
        Corista corista6=new Corista("Panigo", 864, 50, 6);
        Corista corista7=new Corista("Demian Tupac Panigo", 20040864, 50, 7);
        corohileras.agregarCorista(corista4);
        corohileras.agregarCorista(corista5);
        corohileras.agregarCorista(corista6);
        corohileras.agregarCorista(corista7);

        // Imprimir toda la información del coro hileras
        System.out.println(corohileras.toString()); 
        System.out.println("¿El coro hileras está lleno? " + corohileras.estaLleno());
        System.out.println("¿El coro hileras está bien formado? " + corohileras.estaBienFormado());

    }

}