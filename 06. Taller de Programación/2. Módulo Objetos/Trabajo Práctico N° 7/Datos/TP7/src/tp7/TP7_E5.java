/*TRABAJO PRÁCTICO N° 7*/
/*EJERCICIO 5*/
/*Se dispone de la clase Partido (en la carpeta tema2).
Un objeto partido representa un encuentro entre dos equipos (local y visitante).
Un objeto partido puede crearse sin valores iniciales o enviando, en el mensaje de creación, el nombre del equipo local, el nombre del visitante, la cantidad de goles del local y del visitante (en ese orden).
Un objeto partido sabe responder a los siguientes mensajes:

getLocal() retorna el nombre (String) del equipo local;
getVisitante() retorna el nombre (String) del equipo visitante;
getGolesLocal() retorna la cantidad de goles (int) del equipo local;
getGolesVisitante() retorna la cantidad de goles (int) del equipo visitante;
setLocal(X) modifica el nombre del equipo local al “String” X;
setVisitante(X) modifica el nombre del equipo visitante al “String” X;
setGolesLocal(X) modifica la cantidad de goles del equipo local al “int” X;
setGolesVisitante(X) modifica la cantidad de goles del equipo visitante al “int” X;
hayGanador() retorna un boolean que indica si hubo (true) o no hubo (false) ganador;
getGanador() retorna el nombre (String) del ganador del partido (si no hubo retorna un String vacío);
hayEmpate() retorna un boolean que indica si hubo (true) o no hubo (false) empate;

Implementar un programa que cargue un vector con, a lo sumo, 20 partidos disputados en el campeonato.
La información de cada partido se lee desde teclado hasta ingresar uno con nombre de visitante “ZZZ” o alcanzar los 20 partidos.
Luego de la carga:
•	Para cada partido, armar e informar una representación String del estilo: {EQUIPO-LOCAL golesLocal VS EQUIPO-VISITANTE golesVisitante}.
•	Calcular e informar la cantidad de partidos que ganó River.
•	Calcular e informar el total de goles que realizó Boca jugando de local.*/

package tp7;

import PaqueteLectura.*;

public class TP7_E5 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // Cargar un vector con, a lo sumo, 20 partidos disputados en el campeonato
        int dimF=20;
        Partido[] partidos=new Partido[dimF];
        Partido partido=new Partido();
        int dimL=0;
        int nombreTam=3;
        int golesMax=10;
        String visitanteSalida="ZZZ";
        partido.setVisitante(GeneradorAleatorio.generarString(nombreTam));
        while ((!partido.getVisitante().equals(visitanteSalida)) && (dimL<dimF)) {
            partido.setLocal(GeneradorAleatorio.generarString(nombreTam));
            partido.setGolesVisitante(GeneradorAleatorio.generarInt(golesMax));
            partido.setGolesLocal(GeneradorAleatorio.generarInt(golesMax));
            partidos[dimL]=partido;
            partido=new Partido();
            partido.setVisitante(GeneradorAleatorio.generarString(nombreTam));
            dimL++;
        }

        // Para cada partido, armar e informar una representación String del estilo: {EQUIPO-LOCAL golesLocal VS EQUIPO-VISITANTE golesVisitante}.
        for (int i=0; i<dimL; i++)
            System.out.println(partidos[i].getLocal() + " " + partidos[i].getGolesLocal() + " VS " + partidos[i].getVisitante() + " " + partidos[i].getGolesVisitante());
        System.out.println();

        // Calcular e informar la cantidad de partidos que ganó River
        int cant=0;
        for (int i=0; i<dimL; i++)
            if (((partidos[i].getLocal().contains("r")) && (partidos[i].getGolesLocal()>partidos[i].getGolesVisitante())) || ((partidos[i].getVisitante().contains("r")) && (partidos[i].getGolesVisitante()>partidos[i].getGolesLocal())))
                cant++;
        System.out.println("La cantidad de partidos que ganó River son " + cant);

        // Calcular e informar el total de goles que realizó Boca jugando de local
        int goles=0;
        for (int i=0; i<dimL; i++)
            if (partidos[i].getLocal().contains("b"))
                goles=goles+partidos[i].getGolesLocal(); 
        System.out.println("El total de goles que realizó Boca jugando de local es " + goles);

    }

}