{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 1}
{Implementar un programa que invoque a los siguientes módulos:
(a) Un módulo recursivo que retorne un vector de, a lo sumo, 15 números enteros “random” mayores a 10 y menores a 155 (incluídos ambos). La carga finaliza con el valor 20.
(b) Un módulo no recursivo que reciba el vector generado en (a) e imprima el contenido del vector.
(c) Un módulo recursivo que reciba el vector generado en (a) e imprima el contenido del vector.
(d) Un módulo recursivo que reciba el vector generado en (a) y devuelva la suma de los valores pares contenidos en el vector.
(e) Un módulo recursivo que reciba el vector generado en (a) y devuelva el máximo valor del vector.
(f) Un módulo recursivo que reciba el vector generado en (a) y un valor y devuelva verdadero si dicho valor se encuentra en el vector o falso en caso contrario.
(g) Un módulo que reciba el vector generado en (a) e imprima, para cada número contenido en el vector, sus dígitos en el orden en que aparecen en el número.
Debe implementarse un módulo recursivo que reciba el número e imprima lo pedido. Ejemplo, si se lee el valor 142, se debe imprimir 1 4 2.}

program TP2_E1;
{$codepage UTF8}
uses crt;
const
  dimF=15;
  num_ini=10; num_fin=155;
  num_salida=20;
type
  t_numero=num_ini..num_fin;
  t_vector_numeros=array[1..dimF] of t_numero;
procedure leer_numero(var num: t_numero);
begin
  num:=num_ini+random(num_fin-num_ini+1);
end;
procedure cargar_vector_numeros(var vector_numeros: t_vector_numeros; var dimL: int8);
var
  num: t_numero;
begin
  leer_numero(num);
  if ((dimL<dimF) and (num<>num_salida)) then
  begin
    dimL:=dimL+1;
    vector_numeros[dimL]:=num;
    cargar_vector_numeros(vector_numeros,dimL);
  end;
end;
procedure imprimir_secuencial_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8);
var
  i: int8;
begin
  for i:= 1 to dimL do
  begin
    textcolor(green); write('Elemento ',i,' del vector: '); textcolor(red); writeln(vector_numeros[i]);
  end;
end;
procedure imprimir_recursivo_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8);
begin
  if (dimL>0) then
  begin
    imprimir_recursivo_vector_numeros(vector_numeros,dimL-1);
    textcolor(green); write('Elemento ',dimL,' del vector: '); textcolor(red); writeln(vector_numeros[dimL]);
  end;
end;
function sumar_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8): int16;
begin
  if (dimL=0) then
    sumar_vector_numeros:=0
  else
    if (vector_numeros[dimL] mod 2=0) then
      sumar_vector_numeros:=sumar_vector_numeros(vector_numeros,dimL-1)+vector_numeros[dimL]
    else
      sumar_vector_numeros:=sumar_vector_numeros(vector_numeros,dimL-1);
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
function buscar_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8; num: t_numero): boolean;
begin
  if (dimL=0) then
    buscar_vector_numeros:=false
  else
    if (vector_numeros[dimL]=num) then
      buscar_vector_numeros:=true
    else
      buscar_vector_numeros:=buscar_vector_numeros(vector_numeros,dimL-1,num);
end;
procedure descomponer_numero(var digito: int8; var num: int16);
begin
  digito:=num mod 10;
  num:=num div 10;
end;
procedure imprimir_digitos(num: int16);
var
  digito: int8;
begin
  if (num<>0) then
  begin
    descomponer_numero(digito,num);
    imprimir_digitos(num);
    textcolor(red); write(digito,' ');
  end;
end;
procedure imprimir_vector_numeros(vector_numeros: t_vector_numeros; dimL: int8);
begin
  if (dimL<>0) then
  begin
    imprimir_vector_numeros(vector_numeros,dimL-1);
    textcolor(green); write('Elemento ',dimL,' del vector: '); textcolor(red); writeln(vector_numeros[dimL]);
    textcolor(green); write('Elemento ',dimL,' del vector (dígito por dígito): ');
    imprimir_digitos(vector_numeros[dimL]);
    writeln()
  end;
end;
var
  vector_numeros: t_vector_numeros;
  num_max, num: t_numero;
  dimL: int8;
begin
  randomize;
  dimL:=0;
  num_max:=low(t_numero);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_numeros(vector_numeros,dimL);
  if (dimL>0) then
  begin
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    imprimir_secuencial_vector_numeros(vector_numeros,dimL);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    imprimir_recursivo_vector_numeros(vector_numeros,dimL);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    textcolor(green); write('La suma de los valores pares contenidos en el vector es '); textcolor(red); writeln(sumar_vector_numeros(vector_numeros,dimL));
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    calcular_maximo_vector_numeros(vector_numeros,dimL,num_max);
    textcolor(green); write('El máximo valor del vector es '); textcolor(red); writeln(num_max);
    writeln(); textcolor(red); writeln('INCISO (f):'); writeln();
    num:=num_ini+random(num_fin-num_ini+1);
    textcolor(green); write('¿El número '); textcolor(yellow); write(num); textcolor(green); write(' se encuentra en el vector?: '); textcolor(red); writeln(buscar_vector_numeros(vector_numeros,dimL,num));
    writeln(); textcolor(red); writeln('INCISO (g):'); writeln();
    imprimir_vector_numeros(vector_numeros,dimL);
  end;
end.