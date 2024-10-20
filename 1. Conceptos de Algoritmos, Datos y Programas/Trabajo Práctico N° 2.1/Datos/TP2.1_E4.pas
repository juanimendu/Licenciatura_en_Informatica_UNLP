{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 4}
{Dados los siguientes programas, explicar las diferencias.}

program TP2_E4a;
{$codepage UTF8}
uses crt;
var
  a, b: integer;
procedure uno;
begin
  a:=1;
  writeln(a);
end;
begin
  a:=1;
  b:=2;
  uno;
  writeln(b,a);
end.

program TP2_E4b;
{$codepage UTF8}
uses crt;
procedure uno;
begin
  a:=1;
  writeln(a);
end;
var
  a, b: integer;
begin
  a:=1;
  b:=2;
  uno;
  writeln(b,a);
end.