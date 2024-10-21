/*TRABAJO PRÁCTICO N° 9*/
/*EJERCICIO 5*/
/*
(a) Modificar la clase VisorFiguras: ahora, debe permitir guardar las figuras a mostrar (a lo sumo, 5) y también mostrar todas las figuras guardadas. Usar la siguiente estructura.
(b) Realizar un programa que instancie el visor, guarde dos cuadrados y un rectángulo en el visor y, por último, haga que el visor muestre sus figuras almacenadas.
*/

package tp9;

public class TP9_E5 {

    public static void main(String[] args) {

        // Instanciar el visor y dos cuadrados y un rectángulo
        VisorFigurasModificado visor=new VisorFigurasModificado();
        Cuadrado cuadrado1=new Cuadrado(10, "Violeta", "Rosa");
        Cuadrado cuadrado2=new Cuadrado(30, "Rojo", "Naranja");
        Rectangulo rectangulo=new Rectangulo(20, 10, "Azul", "Celeste");

        // Guardar los dos cuadrados y el rectángulo en el visor
        visor.guardar(cuadrado1);
        visor.guardar(cuadrado2);
        visor.guardar(rectangulo);

        // Mostrar las figuras almacenadas en el visor
        visor.mostrar();

    }

}