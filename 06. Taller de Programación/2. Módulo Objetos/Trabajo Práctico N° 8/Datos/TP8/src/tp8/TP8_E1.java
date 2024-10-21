/*TRABAJO PRÁCTICO N° 8*/
/*EJERCICIO 1*/
/*
(a) Definir una clase para representar triángulos.
Un triángulo se caracteriza por el tamaño de sus 3 lados (double), el color de relleno (String) y el color de línea (String).
Proveer un constructor que reciba todos los datos necesarios para iniciar el objeto.
Proveer métodos para:
•	Devolver/modificar el valor de cada uno de sus atributos (métodos get y set).
•	Calcular el perímetro y devolverlo (método calcularPerimetro).
•	Calcular el área y devolverla (método calcularArea).
NOTA: Calcular el área con la fórmula Área= √(s(s-a)(s-b)(s-c)), donde a, b y c son lados y s= (a+b+c)/2. La función raíz cuadrada es Math.sqrt(#).
(b) Realizar un programa que instancie un triángulo, le cargue información leída desde teclado e informe, en consola, el perímetro y el área.
*/

package tp8;

import PaqueteLectura.*;

public class TP8_E1 {

    public static void main(String[] args) {

        // Instanciar un triángulo
        Triangulo triangulo=new Triangulo();

        // Cargar a la instancia triángulo información leída desde teclado
        System.out.print("Introducir lado 1 del triángulo: ");
        triangulo.setLado1(Lector.leerDouble());
        System.out.print("Introducir lado 2 del triángulo: ");
        triangulo.setLado2(Lector.leerDouble());
        System.out.print("Introducir lado 3 del triángulo: ");
        triangulo.setLado3(Lector.leerDouble());
        System.out.print("Introducir color de relleno del triángulo: ");
        triangulo.setColorRelleno(Lector.leerString());
        System.out.print("Introducir color de línea del triángulo: ");
        triangulo.setColorLinea(Lector.leerString());

        // Informar, en consola, el perímetro y el área
        System.out.println();
        System.out.println(triangulo.toString());

    }

}