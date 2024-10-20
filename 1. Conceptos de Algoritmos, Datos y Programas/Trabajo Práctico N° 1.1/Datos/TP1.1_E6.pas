{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 6}
{Realizar un programa que lea el número de legajo y el promedio de cada alumno de la facultad.
La lectura finaliza cuando se ingresa el legajo -1, que no debe procesarse.
Por ejemplo, se lee la siguiente secuencia: 33423, 8.40, 19003, 6.43, -1.
En el ejemplo anterior, se leyó el legajo 33422, cuyo promedio fue 8.40, luego se leyó el legajo 19003, cuyo promedio fue 6.43 y, finalmente, el legajo -1 (para el cual no es necesario leer un promedio).
Al finalizar la lectura, informar:
•	La cantidad de alumnos leída (en el ejemplo anterior, se debería informar 2).
•	La cantidad de alumnos cuyo promedio supera 6.5 (en el ejemplo anterior, se debería informar 1).
•	El porcentaje de alumnos destacados (alumnos con promedio mayor a 8.5) cuyos legajos sean menor al valor 2500 (en el ejemplo anterior, se debería informar 0%).}

program TP1_E6;
{$codepage UTF8}
uses crt;
const
  legajo_salida=-1;
  promedio_corte1=6.5;
  promedio_corte2=8.5;
  legajo_corte=2500;
var
  i: int8;
  legajo: int16;
  alumnos_total, alumnos_corte1, alumnos_corte2: int32;
  promedio, alumnos_corte2_porc: real;
begin
  randomize;
  alumnos_total:=0;
  alumnos_corte1:=0;
  alumnos_corte2:=0; alumnos_corte2_porc:=0;
  i:=random(100);
  if (i=0) then
    legajo:=legajo_salida
  else
    legajo:=1+random(high(int16));
  while (legajo<>legajo_salida) do
  begin
    promedio:=1+random(91)/10;
    alumnos_total:=alumnos_total+1;
    if (promedio>promedio_corte1) then
      alumnos_corte1:=alumnos_corte1+1;
    if ((promedio>promedio_corte2) and (legajo<legajo_corte)) then
      alumnos_corte2:=alumnos_corte2+1;
    i:=random(100);
    if (i=0) then
      legajo:=legajo_salida
    else
      legajo:=1+random(high(int16));
  end;
  alumnos_corte2_porc:=alumnos_corte2/alumnos_total*100;
  textcolor(green); write('La cantidad de alumnos leída es '); textcolor(red); writeln(alumnos_total);
  textcolor(green); write('La cantidad de alumnos con promedio superior a '); textcolor(yellow); write(promedio_corte1:0:2); textcolor(green); write(' es '); textcolor(red); writeln(alumnos_corte1);
  textcolor(green); write('El porcentaje de alumnos destacados (alumnos con promedio mayor a '); textcolor(yellow); write(promedio_corte2:0:2); textcolor(green); write(') cuyos legajos son menor al valor '); textcolor(yellow); write(legajo_corte); textcolor(green); write(' es del '); textcolor(red); write(alumnos_corte2_porc:0:2); textcolor(green); write('%')
end.