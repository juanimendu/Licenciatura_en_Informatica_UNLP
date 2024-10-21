/*TRABAJO PRÁCTICO N° 9*/
/*EJERCICIO 1*/
/*
(a) Incluir la clase Triángulo a la jerarquía de figuras vista (carpeta tema4). Triángulo debe heredar de Figura todo lo que es común y definir su constructor y sus atributos y métodos propios. Además, se debe redefinir el método toString.
(b) De igual manera, incluir la clase Círculo a la jerarquía de figuras.
(c) Añadir, a la representación String, el valor del perímetro. Pensar: ¿qué método toString se debe modificar: el de cada subclase o el de Figura?
(d) Añadir el método despintar que establece los colores de la figura a línea “negra” y relleno “blanco”. Pensar: ¿dónde se debe definir el método: en cada subclase o en Figura?
(e) Realizar un programa que instancie un triángulo y un círculo. Mostrar, en consola, la representación String de cada uno. Probar el funcionamiento del método despintar.
*/

package tp9;

import PaqueteLectura.*;

public class TP9_E1 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Instanciar un triángulo y un círculo
        int ladoMax=10;
        int radioMax=10;
        int tam=5;
        Triangulo triangulo=new Triangulo(GeneradorAleatorio.generarDouble(ladoMax), GeneradorAleatorio.generarDouble(ladoMax), GeneradorAleatorio.generarDouble(ladoMax), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam));
        Circulo circulo=new Circulo(GeneradorAleatorio.generarDouble(radioMax), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam));

        // Mostrar, en consola, la representración String de cada uno
        System.out.println("REPRESENTACIÓN STRING DEL TRIÁNGULO: " + triangulo.toString());
        System.out.println("REPRESENTACIÓN STRING DEL CÍRCULO: " + circulo.toString());
        System.out.println();

        // Probar el funcionamiento del método despintar
        triangulo.despintar();
        circulo.despintar();
        System.out.println("TRIÁNGULO: CR " + triangulo.getColorRelleno() + "; CL " + triangulo.getColorLinea());
        System.out.println("CÍRCULO: CR " + circulo.getColorRelleno() + "; CL " + circulo.getColorLinea());

    }

}