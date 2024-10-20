{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 3}
{Dado el siguiente programa, indicar cuál es su error y su causa.}

program TP2_E3;
{$codepage UTF8}
uses crt;
var
  a: integer;
procedure uno;
var
  b: integer;
begin
  b:=2;
  writeln(b);
end;
begin
  a:=1;
  uno;
  writeln(b,a);
end.