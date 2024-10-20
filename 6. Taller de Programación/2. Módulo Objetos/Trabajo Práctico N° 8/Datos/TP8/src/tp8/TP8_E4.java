/*TRABAJO PRÁCTICO N° 8*/
/*EJERCICIO 4*/
/*
(a) Un hotel posee N habitaciones. De cada habitación, se conoce costo por noche, si está ocupada y, en caso de estarlo, guarda el cliente que la reservó (nombre, DNI y edad).
    (i) Generar las clases necesarias. Para cada una, proveer métodos getters/setters adecuados.
    (ii) Implementar los constructores necesarios para iniciar: los clientes a partir de nombre, DNI, edad; el hotel para N habitaciones, cada una desocupada y con costo aleatorio entre 2000 y 8000.
    (iii) Implementar, en las clases que corresponda, todos los métodos necesarios para:
    •	Ingresar un cliente C en la habitación número X. Asumir que X es válido (es decir, está en el rango 1..N) y que la habitación está libre.
    •	Aumentar el precio de todas las habitaciones en un monto recibido.
    •	Obtener la representación String del hotel, siguiendo el formato:
    {Habitación 1: costo, libre u ocupada, información del cliente si está ocupada},
    …
    {Habitación N: costo, libre u ocupada, información del cliente si está ocupada}.
(b) Realizar un programa que instancie un hotel, ingrese clientes en distintas habitaciones, muestre el hotel, aumente el precio de las habitaciones y vuelva a mostrar el hotel.
NOTAS: Reusar la clase Persona. Para cada método solicitado, pensar a qué clase debe delegar la responsabilidad de la operación.
*/

package tp8;

import PaqueteLectura.*;

public class TP8_E4 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Instanciar un hotel
        int habMax=1+GeneradorAleatorio.generarInt(100);
        Hotel hotel=new Hotel(habMax);

        // Ingresar clientes en distintas habitaciones
        int habSalida=-1;
        int nombreTam=10;
        int dniMin=10000000;
        int dniMax=50000000;
        int edadMin=18;
        int edadMax=100;
        int hab=habSalida+GeneradorAleatorio.generarInt(habMax+1);
        int i=0;
        Cliente cliente;
        while ((hab!=habSalida) && (i<habMax)) {
            cliente=new Cliente(GeneradorAleatorio.generarString(nombreTam), dniMin+GeneradorAleatorio.generarInt(dniMax-dniMin+1), edadMin+GeneradorAleatorio.generarInt(edadMax-edadMin+1));
            hotel.ocuparHab(hab,cliente);
            hab=habSalida+GeneradorAleatorio.generarInt(habMax+1);
            i++;
        }

        // Mostrar el hotel
        System.out.println("HOTEL (sin aumento de precios):");
        System.out.println(hotel.toString());

        // Aumentar el precio de las habitaciones y volver a mostrar el hotel
        System.out.println("HOTEL (con aumento de precios):");
        hotel.aumentarPrecios(1000);
        System.out.println(hotel.toString());

    }

}