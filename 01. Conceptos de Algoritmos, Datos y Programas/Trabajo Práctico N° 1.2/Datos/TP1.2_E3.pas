{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 3}
{Realizar un programa que lea desde teclado la información de alumnos ingresantes a la carrera Analista en TIC.
De cada alumno, se lee nombre y nota obtenida en el módulo EPA (la nota es un número entre 1 y 10).
La lectura finaliza cuando se lee el nombre “Zidane Zinedine”, que debe procesarse. Al finalizar la lectura, informar:
•	La cantidad de alumnos aprobados (nota 8 o mayor).
•	La cantidad de alumnos que obtuvieron un 7 como nota.}

program TP1_E3;
{$codepage UTF8}
uses crt;
const
  nota_ini=1; nota_fin=10;
  nombre_salida='Zidane Zinedine';
  nota_corte1=8;
  nota_corte2=7;
type
  t_nota=nota_ini..nota_fin;
function random_string(length: int8): string;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
var
  nota: t_nota;
  i, alumnos_corte1, alumnos_corte2: int8;
  nombre: string;
begin
  randomize;
  alumnos_corte1:=0;
  alumnos_corte2:=0;
  repeat
    i:=random(100);
    if (i=0) then
      nombre:=nombre_salida
    else
      nombre:=random_string(5+random(6));
    nota:=nota_ini+random(nota_fin);
    if (nota>=nota_corte1) then
      alumnos_corte1:=alumnos_corte1+1
    else
      if (nota=nota_corte2) then
        alumnos_corte2:=alumnos_corte2+1;
  until (nombre=nombre_salida);
  textcolor(green); write('La cantidad de alumnos aprobados (nota 8 o mayor) es '); textcolor(red); writeln(alumnos_corte1);
  textcolor(green); write('La cantidad de alumnos que obtuvieron un 7 como nota es '); textcolor(red); write(alumnos_corte2);
end.