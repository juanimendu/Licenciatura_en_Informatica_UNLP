/*TRABAJO PRÁCTICO N° 8*/
/*EJERCICIO 2*/
/*
(a) Modificar la clase Libro.java (carpeta tema3) para, ahora, considerar que el primer autor es un objeto instancia de la clase Autor.
Implementar la clase Autor, sabiendo que se caracterizan por nombre, biografía y origen y que deben permitir devolver/modificar el valor de sus atributos y devolver una representación String formada por nombre, biografía y origen.
Luego, realizar las modificaciones necesarias en la clase Libro.
(b) Modificar el programa Demo01Constructores (carpeta tema3) para instanciar los libros con su autor, considerando las modificaciones realizadas.
Luego, a partir de uno de los libros instanciados, obtener e imprimir la representación del autor de ese libro.
*/

package tp8;

import PaqueteLectura.*;

public class TP8_E2 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Instanciar los libros con su autor
        int tam=5;
        Autor autor1=new Autor(GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam));
        Autor autor2=new Autor(GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam));
        Libro libro1=new Libro("Java: A Beginner's Guide", "Mcgraw-Hill", 2014, autor1, "978-0071809252", 21.72);
        Libro libro2=new Libro("Learning Java by Building Android Games", "CreateSpace Independent Publishing", autor2, "978-1512108347");

        // Obtener e imprimir la representación del autor 1
        System.out.println("La representación del autor del libro 1 es " + "'" + libro1.getPrimerAutor().toString() + "'");

        // Obtener e imprimir la representación del autor 2
        System.out.println("La representación del autor del libro 2 es " + "'" + libro2.getPrimerAutor().toString() + "'");

    }

}