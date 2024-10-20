{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 1}
{Implementar un programa que lea por teclado dos números enteros e imprima en pantalla los valores leídos en orden inverso.
Por ejemplo, si se ingresan los números 4 y 8, debe mostrar el mensaje: Se ingresaron los valores 8 y 4.}

program TP0_E1;
{$codepage UTF8}
uses crt;
var
  num1, num2: int16;
begin
  textcolor(green); write('Introducir número entero: ');
  textcolor(yellow); readln(num1);
  textcolor(green); write('Introducir número entero: ');
  textcolor(yellow); readln(num2);
  textcolor(green); write('Se ingresaron los valores '); textcolor(red); write(num2); textcolor(green); write(' y '); textcolor(red); write(num1);
end.