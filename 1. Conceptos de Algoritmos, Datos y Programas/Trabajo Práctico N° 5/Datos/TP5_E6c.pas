{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 6c}
{Realizar un programa que ocupe 50 KB de memoria en total. Para ello:
(c) El programa debe minimizar tanto como sea posible el uso de la memoria estática (a lo sumo, 4 bytes).}

program TP5_E6c;
{$codepage UTF8}
uses crt;
const
  KB=50; byte=1024; bytes=KB*byte;
  vector_total=(bytes div 2)-2;
type
  t_vector=array[1..vector_total] of int16;
  t_puntero_vector=^t_vector;
var
  puntero_vector: t_puntero_vector;
begin
  new(puntero_vector);
  textcolor(green); write('La memoria estática ocupada por puntero_vector es '); textcolor(red); write(sizeof(puntero_vector)/byte:0:8); textcolor(green); writeln(' KB');
  textcolor(green); write('La memoria dinámica ocupada por contenido puntero_vector es '); textcolor(red); write(sizeof(puntero_vector^)/byte:0:8); textcolor(green); write(' KB');
end.