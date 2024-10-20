{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 1c}
{Responder las preguntas en relación al siguiente programa:
(c) ¿Qué sucede si se cambia el encabezado del procedure por: procedure suma(var num1: integer; var num2:integer);?}

program TP2_E1c;
{$codepage UTF8}
uses crt;
procedure suma(var num1: integer; var num2: integer);
begin
  num2:=num1+num2;
  num1:=0;
end;
var
  i, x: integer;
begin
  read(x);
  for i:= 1 to 5 do
    suma(i,x);
  write(x);
end.