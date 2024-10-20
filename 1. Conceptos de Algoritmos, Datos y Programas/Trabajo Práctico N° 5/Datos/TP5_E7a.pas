{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 7a}
{Se desea almacenar en memoria una secuencia de 2500 nombres de ciudades, cada nombre podrá tener una longitud máxima de 50 caracteres.
(a) Definir una estructura de datos estática que permita guardar la información leída. Calcular el tamaño de memoria que requiere la estructura.}

program TP5_E7a;
{$codepage UTF8}
uses crt;
const
  longitud_ciudad=50;
  ciudades_total=2500;
type
  t_ciudad=string[longitud_ciudad];
  t_vector_ciudad=array[1..ciudades_total] of t_ciudad;
begin
  textcolor(green); write('El tamaño de memoria que requiere la estructura es '); textcolor(red); write(sizeof(t_vector_ciudad)); textcolor(green); write(' bytes');
end.