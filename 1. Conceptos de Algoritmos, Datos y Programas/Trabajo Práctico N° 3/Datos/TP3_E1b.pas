{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 1b}
{Dado el siguiente programa:
(b) Modificar al programa anterior para que, al finalizar la lectura de todos los alumnos, se informe también el nombre del alumno con mejor promedio.}

program TP3_E1b;
{$codepage UTF8}
uses crt;
const
  codigo_salida=0;
type
  str20=string[20];
  alumno=record
    codigo: integer;
    nombre: str20;
    promedio: real;
  end;
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
procedure leer(var alu: alumno);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    alu.codigo:=codigo_salida
  else
    alu.codigo:=random(high(int16));
  if (alu.codigo<>codigo_salida) then
  begin
    alu.nombre:=random_string(5+random(6));
    alu.promedio:=1+random(91)/10;
  end;
end;
procedure actualizar_maximo(promedio: real; nombre: str20; var promedio_max: real; var nombre_max: str20);
begin
  if (promedio>promedio_max) then
  begin
    promedio_max:=promedio;
    nombre_max:=nombre;
  end;
end;
var
  a: alumno;
  alumnos_leidos: integer;
  promedio_max: real;
  nombre_max: str20;
begin
  randomize;
  alumnos_leidos:=0;
  leer(a);
  while (a.codigo<>codigo_salida) do
  begin
    alumnos_leidos:=alumnos_leidos+1;
    actualizar_maximo(a.promedio,a.nombre,promedio_max,nombre_max);
    leer(a);
  end;
  textcolor(green); write('La cantidad de alumnos leidos es '); textcolor(red); writeln(alumnos_leidos);
  textcolor(green); write('El nombre del alumno con mejor promedio es '); textcolor(red); write(nombre_max);
end.