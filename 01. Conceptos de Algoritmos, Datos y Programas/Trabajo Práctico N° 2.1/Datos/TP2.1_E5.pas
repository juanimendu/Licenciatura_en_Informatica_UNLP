{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 5}
{Dado el siguiente programa, indicar cuál es el error.}

program TP2_E5;
{$codepage UTF8}
uses crt;
function cuatro: integer;
begin
  cuatro:=4;
end;
var
  a: integer;
begin
  cuatro;
  writeln(a);
end.