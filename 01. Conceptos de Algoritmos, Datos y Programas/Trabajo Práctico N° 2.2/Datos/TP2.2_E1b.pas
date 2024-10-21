{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 1b}
{Responder las preguntas en relación al siguiente programa:
(b) ¿Qué imprime si se lee el valor 10 en la variable x y se cambia el encabezado del procedure por: procedure suma(num1: integer; num2:integer);?}

program TP2_E1b;
{$codepage UTF8}
uses crt;
procedure suma(num1: integer; num2: integer);
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