/*TRABAJO PRÁCTICO N° 8*/
/*EJERCICIO 3*/
/*
(a) Definir una clase para representar estantes. Un estante almacena, a lo sumo, 20 libros. Implementar un constructor que permita iniciar el estante sin libros. Proveer métodos para:
•	Devolver la cantidad de libros que hay almacenados.
•	Devolver si el estante está lleno.
•	Agregar un libro al estante.
•	Devolver el libro con un título particular que se recibe.
(b) Realizar un programa que instancie un estante. Cargar varios libros. A partir del estante, buscar e informar el autor del libro “Mujercitas”.
(c) ¿Qué se modificaría en la clase definida para, ahora, permitir estantes que almacenen como máximo N libros? ¿Cómo se instanciaría el estante?
*/

package tp8;

import PaqueteLectura.*;

public class TP8_E3 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // INCISOS (a) y (b)

        // Instanciar un estante
        int cantLibros1=20;
        Estante estante1=new Estante();

        // Cargar varios libros
        int tam1=5;
        for (int i=0; i<cantLibros1; i++) {
            Autor autor=new Autor(GeneradorAleatorio.generarString(tam1), GeneradorAleatorio.generarString(tam1), GeneradorAleatorio.generarString(tam1));
            Libro libro=new Libro(GeneradorAleatorio.generarString(tam1), GeneradorAleatorio.generarString(tam1), GeneradorAleatorio.generarInt(tam1), autor, GeneradorAleatorio.generarString(tam1), GeneradorAleatorio.generarDouble(tam1));
            if (i==cantLibros1-1)
                libro.setTitulo("Mujercitas");
            estante1.agregarLibro(libro);
        }

        // A partir del estante, buscar e informar el autor del libro "Mujercitas"
        System.out.println("El autor del libro 'Mujercitas' es " + estante1.devolverLibro("Mujercitas").getPrimerAutor().getNombre());

        // INCISOS (c)

        // Instanciar un estante
        int librosMin=1;
        int librosMax=20;
        int cantLibros2=librosMin+GeneradorAleatorio.generarInt(librosMax-librosMin+1);
        Estante estante2=new Estante(cantLibros2);

        // Cargar varios libros
        int tam2=5;
        for (int i=0; i<cantLibros2; i++) {
            Autor autor=new Autor(GeneradorAleatorio.generarString(tam2), GeneradorAleatorio.generarString(tam2), GeneradorAleatorio.generarString(tam2));
            Libro libro=new Libro(GeneradorAleatorio.generarString(tam2), GeneradorAleatorio.generarString(tam2), GeneradorAleatorio.generarInt(tam2), autor, GeneradorAleatorio.generarString(tam2), GeneradorAleatorio.generarDouble(tam2));
            if (i==cantLibros2-1)
                libro.setTitulo("Mujercitas");
            estante2.agregarLibro(libro);
        }

        // A partir del estante, buscar e informar el autor del libro "Mujercitas"
        System.out.println("El autor del libro 'Mujercitas' es " + estante2.devolverLibro("Mujercitas").getPrimerAutor().getNombre());

    }

}