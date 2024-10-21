{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 1d}
{Dado el siguiente programa:
(d) ¿Qué valores están contenidos en la variable numeros si las líneas 11 y 12 se reemplazan por for i:= 1 to 9 do numeros[i+1]:=numeros[i];?}

program TP4_E1d;
{$codepage UTF8}
uses crt;
type
  vnums=array[1..10] of integer;
var
  numeros: vnums;
  i: integer;
begin
  for i:= 1 to 10 do
  begin
    numeros[i]:=i;
    if (i<10) then
      write(numeros[i],', ')
    else
      writeln(numeros[i])
  end;
  for i:= 1 to 9 do
  begin
    numeros[i+1]:=numeros[i];
    if (i<9) then
      write(numeros[i],', ')
    else
      writeln(numeros[i])
  end;
end.