{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 4}
{Realizar un programa que lea un número real X.
Luego, deberá leer números reales hasta que se ingrese uno cuyo valor sea, exactamente, el doble de X (el primer número leído).}

program TP1_E4;
{$codepage UTF8}
uses crt;
const
  multiplo=2;
var
  num1, num2: real;
begin
  randomize;
  num1:=random(1000)/10;
  num2:=multiplo*num1+random(100);
  while (num2<>(multiplo*num1)) do
    num2:=multiplo*num1+random(100);
  textcolor(green); write('El número introducido ('); textcolor(red); write(num2:0:2); textcolor(green); write(') es igual al inicial ('); textcolor(red); write(num1:0:2); textcolor(green); write(') multiplicado por '); textcolor(yellow); write(multiplo);
end.