{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 2a}
{Modificar el programa anterior para que el mensaje de salida muestre la suma de ambos números:
(a) Utilizando una variable adicional.}

program TP0_E2a;
{$codepage UTF8}
uses crt;
var
  num1, num2: int16;
  suma: int32;
begin
  textcolor(green); write('Introducir número entero: ');
  textcolor(yellow); readln(num1);
  textcolor(green); write('Introducir número entero: ');
  textcolor(yellow); readln(num2);
  suma:=num1+num2;
  textcolor(green); write('La suma de los valores ingresados es '); textcolor(red); write(suma);
end.