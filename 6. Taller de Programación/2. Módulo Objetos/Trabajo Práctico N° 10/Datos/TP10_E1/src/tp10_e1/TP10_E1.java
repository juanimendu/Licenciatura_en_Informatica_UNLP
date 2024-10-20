/*TRABAJO PRÁCTICO N° 10*/
/*EJERCICIO 1*/
/*
La UNLP desea administrar sus proyectos, investigadores y subsidios.
Un proyecto tiene: nombre, código, nombre completo del director y los investigadores que participan en el proyecto (50 como máximo).
De cada investigador, se tiene: nombre completo, categoría (1 a 5) y especialidad.
Además, cualquier investigador puede pedir hasta un máximo de 5 subsidios.
De cada subsidio, se conoce: el monto pedido, el motivo y si fue otorgado o no.
(a) Implementar el modelo de clases teniendo en cuenta:
•	Un proyecto sólo debería poder construirse con el nombre, código, nombre del director.
•	Un investigador sólo debería poder construirse con nombre, categoría y especialidad.
•	Un subsidio sólo debería poder construirse con el monto pedido y el motivo. Un subsidio siempre se crea en estado no-otorgado.
(b) Implementar los métodos necesarios (en las clases donde corresponda) que permitan:
•	void agregarInvestigador(Investigador unInvestigador);
        // agregar un investigador al proyecto.
•	void agregarSubsidio(Subsidio unSubsidio);
        // agregar un subsidio al investigador.
•	double dineroTotalOtorgado();
        //devolver el monto total otorgado en subsidios del proyecto (tener en cuenta todos los subsidios otorgados de todos los investigadores).
•	void otorgarTodos(String nombre_completo);
        //otorgar todos los subsidios no-otorgados del investigador llamado nombre_completo.
•	String toString();
        // devolver un string con: nombre del proyecto, código, nombre del director, el total de dinero otorgado del proyecto y la siguiente información de cada investigador: nombre, categoría, especialidad y el total de dinero de sus subsidios otorgados.
(c) Escribir un programa que instancie un proyecto con tres investigadores. Agregar dos subsidios a cada investigador y otorgar los subsidios de uno de ellos. Luego, imprimir todos los datos del proyecto en pantalla.
*/

package tp10_e1;

import PaqueteLectura.*;

public class TP10_E1 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Instanciar un proyecto con tres investigadores
        int tam=10;
        int codigoMin=1;
        int codigoMax=10;
        int categoriaMin=1;
        int categoriaMax=5;
        int subsMax=1000;
        Proyecto proyecto=new Proyecto(GeneradorAleatorio.generarString(tam), codigoMin+GeneradorAleatorio.generarInt(codigoMax-codigoMin+1), GeneradorAleatorio.generarString(tam));
        Investigador investigador1=new Investigador("Juan", categoriaMin+GeneradorAleatorio.generarInt(categoriaMax-categoriaMin+1), GeneradorAleatorio.generarString(tam));
        Investigador investigador2=new Investigador("Ignacio", categoriaMin+GeneradorAleatorio.generarInt(categoriaMax-categoriaMin+1), GeneradorAleatorio.generarString(tam));
        Investigador investigador3=new Investigador("Menduiña", categoriaMin+GeneradorAleatorio.generarInt(categoriaMax-categoriaMin+1), GeneradorAleatorio.generarString(tam));
        proyecto.agregarInvestigador(investigador1);
        proyecto.agregarInvestigador(investigador2);
        proyecto.agregarInvestigador(investigador3);

        // Agregar dos subsidios a cada investigador
        for (int i=0; i<3; i++)
            for (int j=0; j<2; j++)
                proyecto.agregarSubsidio(i, GeneradorAleatorio.generarDouble(subsMax), GeneradorAleatorio.generarString(tam));

        // Otorgar los subsidios de uno de ellos
        proyecto.otorgarTodos("Juan");

        // Imprimir todos los datos del proyecto en pantalla
        System.out.println(proyecto.toString());

    }

}