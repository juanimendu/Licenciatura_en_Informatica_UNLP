{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 4}
{Implementar un programa que lea el diámetro D de un círculo e imprima:
•	El radio (R) del círculo (la mitad del diámetro).
•	El área del círculo. Para calcular el área de un círculo, se debe utilizar la fórmula PI * R^2.
•	El perímetro del círculo. Para calcular el perímetro del círculo, se debe utilizar la fórmula D * PI (o también R * 2 * PI).}

program TP0_E4;
{$codepage UTF8}
uses crt;
var
  diametro, radio, area, perimetro: real;
begin
  randomize;
  diametro:=random(10001)/10;
  radio:=diametro/2;
  textcolor(green); write('El radio del círculo es '); textcolor(red); writeln(radio:0:2);
  area:=pi*sqr(diametro/2);
  textcolor(green); write('El área del círculo es '); textcolor(red); writeln(area:0:2);
  perimetro:=pi*diametro;
  textcolor(green); write('El perímetro del círculo es '); textcolor(red); write(perimetro:0:2);
end.