/*TRABAJO PRÁCTICO N° 9*/
/*EJERCICIO 4*/
/*Un objeto visor de figuras se encarga de mostrar, en consola, cualquier figura que reciba y también mantiene cuántas figuras mostró.
Analizar y ejecutar el siguiente programa y responder: ¿Qué imprime? ¿Por qué?*/

package tp9;

public class TP9_E4 {

    public static void main(String[] args) {

        VisorFiguras visor=new VisorFiguras();
        Cuadrado c1=new Cuadrado(10, "Violeta", "Rosa");
        Rectangulo r=new Rectangulo(20, 10, "Azul", "Celeste");
        Cuadrado c2=new Cuadrado(30, "Rojo", "Naranja");

        visor.mostrar(c1);
        visor.mostrar(r);
        visor.mostrar(c2);

        System.out.println(visor.getMostradas());

    }

}