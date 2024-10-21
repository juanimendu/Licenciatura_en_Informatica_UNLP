{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 1}
{Dado el siguiente programa, indicar qué imprime.}

program TP2_E1;
{$codepage UTF8}
uses crt;
var
  a, b: integer;
procedure uno;
var
  b: integer;
begin
  b:=3;
  writeln(b);
end;
begin
  a:=1;
  b:=2;
  uno;
  writeln(b,a);
end.