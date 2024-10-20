{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 5}
{Realizar un programa que lea números enteros desde teclado. La lectura debe finalizar cuando se ingrese el número 100, el cual debe procesarse.
Informar en pantalla:
•	El número máximo leído.
•	El número mínimo leído.
•	La suma total de los números leídos.}

program TP1_E5;
{$codepage UTF8}
uses crt;
const
  num_salida=100;
var
  num, num_max, num_min: int16;
  suma: int32;
begin
  randomize;
  num_max:=low(int16);
  num_min:=high(int16);
  suma:=0;
  repeat
    num:=num_salida+random(num_salida+1);
    if (num>num_max) then
      num_max:=num;
    if (num<num_min) then
      num_min:=num;
    suma:=suma+num;
  until (num=num_salida);
  textcolor(green); write('El número máximo leído es '); textcolor(red); writeln(num_max);
  textcolor(green); write('El número mínimo leído es '); textcolor(red); writeln(num_min);
  textcolor(green); write('La suma total de los números leídos es '); textcolor(red); write(suma);
end.