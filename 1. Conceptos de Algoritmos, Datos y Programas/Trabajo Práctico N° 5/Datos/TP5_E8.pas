{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 8}
{Analizar el siguiente programa:
Responder: ¿Cuánta memoria en total ocupa el programa al ejecutarse?
Considerar tanto variables estáticas como dinámicas, parámetros y variables locales de los módulos.
(a) Hasta la sentencia de la línea 18.
(b) Hasta la sentencia de la línea 20.
(c) Hasta la sentencia de la línea 23.
(d) Hasta la sentencia de la línea 11.
(e) Hasta la sentencia de la línea 25.}

program TP5_E8;
{$codepage UTF8}
uses crt;
type
  datos=array[1..20] of integer;
  punt=^datos;
procedure procesarDatos(v: datos; var v2: datos);
var
  i, j: integer;
begin
  for i:= 1 to 20 do
    v2[21-i]:=v[i];
end;
var
  vect: datos;
  pvect: punt;
  i: integer;
begin
  for i:= 1 to 20 do
    vect[i]:=i;
  new(pvect);
  for i:= 20 downto 1 do
    pvect^[i]:=0;
  procesarDatos(pvect^,vect);
  writeln('fin');
end.