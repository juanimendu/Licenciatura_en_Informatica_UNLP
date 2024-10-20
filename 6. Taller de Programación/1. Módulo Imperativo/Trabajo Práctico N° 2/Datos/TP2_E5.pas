{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 5}
{Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el siguiente encabezado:
Procedure busquedaDicotomica(v: vector; ini, fin: indice; dato: integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector.}

program TP2_E5;
{$codepage UTF8}
uses crt;
const
  dimF=10;
  num_salida=0;
type
  t_vector_numeros=array[1..dimF] of int8;
procedure cargar_vector_numeros(var vector_numeros: t_vector_numeros; var dimL: int8);
var
  num: int8;
begin
  if (dimL<dimF) then
  begin
    num:=num_salida+random(high(int8));
    if (num<>num_salida) then
    begin
      dimL:=dimL+1;
      vector_numeros[dimL]:=num;
      cargar_vector_numeros(vector_numeros,dimL);
    end;
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
  i, j, k, item: int8;
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
  dimL, num, pri, ult, pos: int8;
begin
  randomize;
  dimL:=0;
  cargar_vector_numeros(vector_numeros,dimL);
  if (dimL>0) then
  begin
    imprimir_vector_numeros(vector_numeros,dimL);
    ordenar_vector_numeros(vector_numeros,dimL);
    imprimir_vector_numeros(vector_numeros,dimL);
    num:=1+random(high(int8));
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
  end;
end.