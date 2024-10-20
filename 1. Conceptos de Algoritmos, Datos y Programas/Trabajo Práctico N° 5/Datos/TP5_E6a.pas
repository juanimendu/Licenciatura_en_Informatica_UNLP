{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 6a}
{Realizar un programa que ocupe 50 KB de memoria en total. Para ello:
(a) El programa debe utilizar sólo memoria estática.}

program TP5_E6a;
{$codepage UTF8}
uses crt;
const
  KB=50; byte=1024; bytes=KB*byte;
  vector_total=bytes div 2;
type
  t_vector=array[1..vector_total] of int16;
var
  vector: t_vector;
begin
  textcolor(green); write('La memoria estática ocupada por el vector es '); textcolor(red); write(sizeof(vector)/byte:0:2); textcolor(green); write(' KB');
end.