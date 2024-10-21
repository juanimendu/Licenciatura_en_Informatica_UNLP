{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 3}
{Implementar un programa que invoque a los siguientes módulos:
(a) Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300 y menores a 1550 (incluidos ambos).
(b) Un módulo que reciba el vector generado en (a) y lo retorne ordenado (utilizar lo realizado en la práctica anterior).
(c) Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente encabezado:
Procedure busquedaDicotomica (v: vector; ini, fin: indice; dato: integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector.}

program TP2_E3;
{$codepage UTF8}
uses crt;
const
  dimF=20;
  num_ini=300; num_fin=1550;
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
procedure ordenar_vector_numeros(var vector_numeros: t_vector_numeros; dimL: int8);
var
  item: t_numero;
  i, j, k: int8;
begin
  for i:= 1 to (dimL-1) do
  begin
    k:=i;
    for j:= (i+1) to dimL do
      if (vector_numeros[j]<vector_numeros[k]) then
        k:=j;
    item:=vector_numeros[k];
    vector_numeros[k]:=vector_numeros[i];
    vector_numeros[i]:=item;
  end;
end;
function buscar_vector_numeros(vector_numeros: t_vector_numeros; num, pri, ult: int8): int8;
var 
  medio: int8;
begin 
  if (pri<=ult) then
  begin
    medio:=(pri+ult) div 2;
    if (num=vector_numeros[medio]) then
      buscar_vector_numeros:=medio
    else if (num<vector_numeros[medio]) then
      buscar_vector_numeros:=buscar_vector_numeros(vector_numeros,num,pri,medio-1)
    else
      buscar_vector_numeros:=buscar_vector_numeros(vector_numeros,num,medio+1,ult)
  end
  else
    buscar_vector_numeros:=-1;
end;
var
  vector_numeros: t_vector_numeros;
  num: t_numero;
  dimL, pri, ult, pos: int8;
begin
  randomize;
  dimL:=0;
  pos:=0;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_numeros(vector_numeros,dimL);
  imprimir_vector_numeros(vector_numeros,dimL);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  ordenar_vector_numeros(vector_numeros,dimL);
  imprimir_vector_numeros(vector_numeros,dimL);
  writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
  num:=(num_ini+1)+random(num_fin-(num_ini+1));
  pri:=1; ult:=dimL;
  pos:=buscar_vector_numeros(vector_numeros,num,pri,ult);
  if (pos<>-1) then
  begin
    textcolor(green); write('El número '); textcolor(yellow); write(num); textcolor(green); write(' se encontró en el vector, en la posición '); textcolor(red); write(pos);
  end
  else
  begin
    textcolor(green); write('El número '); textcolor(yellow); write(num); textcolor(green); write(' no se encontró en el vector');
  end;
end.