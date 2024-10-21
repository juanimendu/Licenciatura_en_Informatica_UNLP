{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 4}
{Escribir un programa con:
(a) Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y menores a 100.
(b) Un módulo recursivo que devuelva el máximo valor del vector.
(c) Un módulo recursivo que devuelva la suma de los valores contenidos en el vector.}

program TP2_E4;
{$codepage UTF8}
uses crt;
const
  dimF=20;
  num_ini=0; num_fin=100;
type
  t_numero=num_ini..num_fin;
  t_vector_numeros=array[1..dimF] of t_numero;
procedure cargar_vector_numeros(var vector_numeros: t_vector_numeros; var dimL: int8);
begin
  if (dimL<dimF) then
  begin
    dimL:=dimL+1;
    vector_numeros[dimL]:=(num_ini+1)+random(num_fin-(num_ini+1));
    cargar_vector_numeros(vector_numeros,dimL);
  end;
end;
procedure imprimir_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8);
begin
  if (dimL>0) then
  begin
    imprimir_vector_numeros(vector_numeros,dimL-1);
    textcolor(green); write('Elemento ',dimL,' del vector: '); textcolor(red); writeln(vector_numeros[dimL]);
  end;
end;
procedure calcular_maximo_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8; var num_max: t_numero);
begin
  if (dimL>0) then
  begin
    if (vector_numeros[dimL]>num_max) then
      num_max:=vector_numeros[dimL];
    calcular_maximo_vector_numeros(vector_numeros,dimL-1,num_max);
  end;
end;
function sumar_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8): int16;
begin
  if (dimL=1) then
    sumar_vector_numeros:=vector_numeros[dimL]
  else
    sumar_vector_numeros:=sumar_vector_numeros(vector_numeros,dimL-1)+vector_numeros[dimL];
end;
var
  vector_numeros: t_vector_numeros;
  num_max: t_numero;
  dimL: int8;
begin
  randomize;
  dimL:=0;
  num_max:=low(t_numero);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_numeros(vector_numeros,dimL);
  if (dimL>0) then
  begin
    imprimir_vector_numeros(vector_numeros,dimL);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    calcular_maximo_vector_numeros(vector_numeros,dimL,num_max);
    textcolor(green); write('El máximo valor del vector es '); textcolor(red); writeln(num_max);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    textcolor(green); write('La suma de los valores contenidos en el vector es '); textcolor(red); write(sumar_vector_numeros(vector_numeros,dimL));
  end;
end.