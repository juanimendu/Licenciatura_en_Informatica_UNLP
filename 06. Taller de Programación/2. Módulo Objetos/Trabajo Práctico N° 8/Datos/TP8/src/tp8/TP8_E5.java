/*TRABAJO PRÁCTICO N° 8*/
/*EJERCICIO 5*/
/*
(a) Definir una clase para representar círculos. Los círculos se caracterizan por su radio (double), el color de relleno (String) y el color de línea (String). Proveer un constructor que reciba todos los datos necesarios para iniciar el objeto. Proveer métodos para:
•	Devolver/modificar el valor de cada uno de sus atributos (métodos get y set).
•	Calcular el perímetro y devolverlo (método calcularPerimetro).
•	Calcular el área y devolverla (método calcularArea).
NOTA: la constante PI es Math.PI.
(b) Realizar un programa que instancie un círculo, le cargue información leída de teclado e informe, en consola, el perímetro y el área.
NOTA: La constante PI es Math.PI.
*/

package tp8;

import PaqueteLectura.*;

public class TP8_E5 {

    public static void main(String[] args) {

        // Instanciar un círculo
        Circulo circulo=new Circulo();

        // Cargar a la instancia círculo información leída desde teclado
        System.out.print("Introducir radio del círculo: ");
        circulo.setRadio(Lector.leerDouble());
        System.out.print("Introducir color de relleno del círculo: ");
        circulo.setColorRelleno(Lector.leerString());
        System.out.print("Introducir color de línea del círculo: ");
        circulo.setColorLinea(Lector.leerString());

        // Informar, en consola, el perímetro y el área
        System.out.println();
        System.out.println(circulo.toString());

    }

}