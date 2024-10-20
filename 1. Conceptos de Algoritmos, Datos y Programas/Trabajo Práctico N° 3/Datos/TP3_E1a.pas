{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 1a}
{Dado el siguiente programa:
(a) Completar el programa principal para que lea información de alumnos (código, nombre, promedio) e informe la cantidad de alumnos leídos.
La lectura finaliza cuando ingresa un alumno con código 0, que no debe procesarse. Nota: Utilizar el módulo leer.}

program TP3_E1a;
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
var
  a: alumno;
  alumnos_leidos: integer;
begin
  randomize;
  alumnos_leidos:=0;
  leer(a);
  while (a.codigo<>codigo_salida) do
  begin
    alumnos_leidos:=alumnos_leidos+1;
    leer(a);
  end;
  textcolor(green); write('La cantidad de alumnos leídos es '); textcolor(red); write(alumnos_leidos);
end.