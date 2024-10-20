/*TRABAJO PRÁCTICO N° 9*/
/*EJERCICIO 6*/
/*El Servicio Meteorológico Nacional necesita un sistema que permita registrar, para una determinada estación meteorológica, la temperatura promedio mensual de N años consecutivos a partir de un año A dado.
Además, necesita dos versiones del sistema: una que permita reportar el promedio histórico por años y otra que permita reportar el promedio histórico por meses.
Esto se detalla más adelante. De la estación, interesa conocer: nombre, y latitud y longitud donde se encuentra.
Implementar las clases, constructores y métodos que se considere necesarios para:
(a) Crear el sistema de registro/reporte, que funcionará en una determinada estación, para N años consecutivos a partir de un año A. Iniciar cada temperatura en un valor muy alto.
(b) Registrar la temperatura de un mes y año recibidos por parámetro. Nota: El mes está en rango 1..12 y el año está en rango A..A+N-1.
(c) Obtener la temperatura de un mes y año recibidos por parámetro. Nota: El mes está en rango 1..12 y el año está en rango A..A+N-1. En caso de no haberse registrado temperatura para ese mes/año, se retorna el valor muy alto.
(d) Devolver un String que concatena el mes y año en que se registró la mayor temperatura. Nota: Suponer que ya están registradas las temperaturas de todos los meses y años.
(e) Devolver un String con el nombre de la estación, su latitud y longitud y los promedios mensuales o anuales según corresponda:
•	La versión del sistema que reporta por años deberá calcular el promedio para cada año (el promedio del año X se calcula con los datos mensuales de ese año).
•	La versión del sistema que reporta por meses deberá calcular el promedio para cada mes (el promedio del mes M se calcula con los datos de todos los años en ese mes).
Nota: Suponer que ya están registradas las temperaturas de todos los meses y años. Utilizar el carácter \n para concatenar un salto de línea.
(f) Realizar un programa principal que cree un Sistema con reporte anual para 3 años consecutivos a partir del 2021, para la estación La Plata (latitud -34.921 y longitud -57.955). Cargar todas las temperaturas (para todos los meses y años). Informar los promedios anuales y el mes y año en que se registró la mayor temperatura. Luego, crear un Sistema con informe mensual para 4 años a partir de 2020, para la estación Mar del Plata (latitud -38.002 y longitud -57.556). Cargar todas las temperaturas (para todos los meses y años). Informar los promedios mensuales y el mes y año en que se registró la mayor temperatura.
NOTA: Prestar atención de no violar el encapsulamiento al resolver el ejercicio.*/

package tp9;

import PaqueteLectura.*;

public class TP9_E6 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Crear un Sistema con reporte anual para 3 años consecutivos a partir del 2021, para la estación La Plata
        Estacion estacion1=new Estacion("La Plata", -34.921, -57.955);
        SistemaAnual sistemaAnual=new SistemaAnual(estacion1, 2021, 3);

        // Cargar todas las temperaturas (para todos los meses y años)
        int tempMax=50;
        for (int i=0; i<sistemaAnual.getCantAnios(); i++)
            for (int j=0; j<sistemaAnual.getCantMeses(); j++)
                sistemaAnual.setTemp(i, j, GeneradorAleatorio.generarDouble(tempMax));

        // Informar los promedios anuales y el mes y año en que se registró la mayor temperatura
        System.out.println(sistemaAnual.toString());
        System.out.println(sistemaAnual.mayorTemp());
        System.out.println();

        // Crear un Sistema con informe mensual para 4 años a partir de 2020, para la estación Mar del Plata
        Estacion estacion2=new Estacion("Mar del Plata", -38.002, -57.556); 
        SistemaMensual sistemaMensual=new SistemaMensual(estacion2, 2020, 4);

        // Cargar todas las temperaturas (para todos los meses y años)
        for (int i=0; i<sistemaMensual.getCantAnios(); i++)
            for (int j=0; j<sistemaMensual.getCantMeses(); j++)
                sistemaMensual.setTemp(i, j, GeneradorAleatorio.generarDouble(tempMax));

        // Informar los promedios mensuales y el mes y año en que se registró la mayor temperatura
        System.out.println(sistemaMensual.toString());
        System.out.println(sistemaMensual.mayorTemp());

    }

}