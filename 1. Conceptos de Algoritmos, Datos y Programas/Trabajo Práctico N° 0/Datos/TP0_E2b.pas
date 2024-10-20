{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 2b}
{Modificar el programa anterior para que el mensaje de salida muestre la suma de ambos números:
(b) Sin utilizar una variable adicional.}

program TP0_E2b;
{$codepage UTF8}
uses crt;
var
  num1, num2: int16;
begin
  textcolor(green); write('Introducir número entero: ');
  textcolor(yellow); readln(num1);
  textcolor(green); write('Introducir número entero: ');
  textcolor(yellow); readln(num2);
  textcolor(green); write('La suma de los valores ingresados es '); textcolor(red); write(num1+num2);
end.