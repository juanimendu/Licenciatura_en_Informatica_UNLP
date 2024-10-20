/*TRABAJO PRÁCTICO N° 10*/
/*EJERCICIO 3*/
/*
Un productor musical desea administrar los recitales que organiza, que pueden ser: eventos ocasionales y giras.
•	De todo recital, se conoce el nombre de la banda y la lista de temas que tocarán durante el recital.
•	Un evento ocasional es un recital que, además, tiene el motivo (a beneficio, show de TV o show privado), el nombre del contratante del recital y el día del evento.
•	Una gira es un recital que, además, tiene un nombre y las “fechas” donde se repetirá la actuación. De cada “fecha”, se conoce la ciudad y el día. Además, la gira guarda el número de la fecha en la que se tocará próximamente (actual).
(a) Generar las clases necesarias. Implementar métodos getters/setters adecuados.
(b) Implementar los constructores. El constructor de recitales recibe el nombre de la banda y la cantidad de temas que tendrá el recital. El constructor de eventos ocasionales, además, recibe el motivo, el nombre del contratante y día del evento. El constructor de giras, además, recibe el nombre de la gira y la cantidad de fechas que tendrá.
(c) Implementar los métodos listados a continuación:
(i) Cualquier recital debe saber responder a los mensajes:
•	agregarTema que recibe el nombre de un tema y lo agrega a la lista de temas.
•	actuar que imprime (por consola), para cada tema, la leyenda “y ahora tocaremos…” seguido por el nombre del tema.
(ii) La gira debe saber responder a los mensajes:
•	agregarFecha que recibe una “fecha” y la agrega adecuadamente.
•	La gira debe responder al mensaje actuar de manera distinta. Imprimir la leyenda “Buenas noches…” seguido del nombre de la ciudad de la fecha “actual”. Luego, debe imprimir el listado de temas como lo hace cualquier recital. Además, debe establecer la siguiente fecha de la gira como la nueva “actual”.
(iii) El evento ocasional debe saber responder al mensaje actuar de manera distinta:
•	Si es un show de beneficencia, se imprime la leyenda “Recuerden colaborar con…” seguido del nombre del contratante.
•	Si es un show de TV, se imprime “Saludos amigos televidentes”.
•	Si es un show privado, se imprime “Un feliz cumpleaños para…” seguido del nombre del contratante.
Independientemente del motivo del evento, luego, se imprime el listado de temas como lo hace cualquier recital.
(iv) Todo recital debe saber responder al mensaje calcularCosto teniendo en cuenta lo siguiente. Si es un evento ocasional, devuelve 0 si es a beneficio, 50.000 si es un show de TV y 150.000 si es privado. Las giras deben devolver 30.000 por cada fecha de la misma.
(d) Realizar un programa que instancie un evento ocasional y una gira, cargando la información necesaria. Luego, para ambos, imprimir el costo e invocar al mensaje "actuar".
*/

package tp10_e3;

import PaqueteLectura.*;

public class TP10_E3 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Instanciar un evento ocasional y una gira
        int tam=5;
        int temasMin=5;
        int temasMax=10;
        int diaMin=1;
        int diaMax=31;
        int fechasMin=5;
        int fechasMax=10;
        int temas=temasMin+GeneradorAleatorio.generarInt(temasMax-temasMin+1);
        EventoOcasional eventoOcasional=new EventoOcasional(GeneradorAleatorio.generarString(tam), temas, "Show de TV", GeneradorAleatorio.generarString(tam), diaMin+GeneradorAleatorio.generarInt(diaMax-diaMin+1));
        for (int i=0; i<eventoOcasional.getTemasMax(); i++)
            eventoOcasional.agregarTema(GeneradorAleatorio.generarString(tam));
        Gira gira=new Gira(GeneradorAleatorio.generarString(tam), temas, GeneradorAleatorio.generarString(tam), fechasMin+GeneradorAleatorio.generarInt(fechasMax-fechasMin+1));
        for (int i=0; i<gira.getTemasMax(); i++)
            gira.agregarTema(GeneradorAleatorio.generarString(tam));
        Fecha fecha;
        for (int i=0; i<gira.getFechasMax(); i++) {
            fecha=new Fecha(GeneradorAleatorio.generarString(tam), diaMin+GeneradorAleatorio.generarInt(diaMax-diaMin+1));
            gira.agregarFecha(fecha);
        }

        // Para ambos, imprimir el costo
        System.out.println("El costo del Evento Ocasional para " + eventoOcasional.getNombreContratante() + " es $" + eventoOcasional.calcularCosto());
        System.out.println("El costo de la Gira " + gira.getNombreGira() + " es $" + gira.calcularCosto());
        System.out.println();

        // Para ambos, invocar al mensaje actuar
        System.out.println("El mensaje 'actuar' del Evento Ocasional es:\n" + eventoOcasional.actuar());
        System.out.println();
        System.out.println("El mensaje 'actuar' de la Gira es:\n" + gira.actuar());

    }

}