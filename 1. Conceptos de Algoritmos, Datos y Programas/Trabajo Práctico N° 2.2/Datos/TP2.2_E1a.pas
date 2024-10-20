{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 1a}
{Responder las preguntas en relación al siguiente programa:
(a) ¿Qué imprime si se lee el valor 10 en la variable x?}

program TP2_E1a;
{$codepage UTF8}
uses crt;
procedure suma(num1: integer; var num2: integer);
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