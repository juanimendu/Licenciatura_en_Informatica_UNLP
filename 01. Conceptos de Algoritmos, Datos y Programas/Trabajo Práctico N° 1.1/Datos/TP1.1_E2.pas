{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 2}
{Realizar un programa que lea un número real e imprima su valor absoluto.
El valor absoluto de un número X se escribe |X| y se define como: |X|= X cuando X es mayor o igual a cero; |X|= -X cuando X es menor a cero.}

program TP1_E2;
{$codepage UTF8}
uses crt;
var
  num, abs: real;
begin
  randomize;
  num:=(random(10001)-random(10001))/10;
  if (num>=0) then
    abs:=num
  else
    abs:=-num;
  textcolor(green); write('El valor absoluto del número '); textcolor(yellow); write(num:0:2); textcolor(green); write(' es '); textcolor(red); write(abs:0:2);
end.