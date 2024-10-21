{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 6}
{Dado que en la solución anterior se recorre dos veces el vector (una para calcular el elemento máximo y otra para el mínimo), implementar un único módulo que recorra una única vez el vector y devuelva ambas posiciones.}

program TP4_E6;
{$codepage UTF8}
uses crt;
const
  num_total=100;
  num_salida=0;
type
  t_numero=1..num_total;
  t_vector_numeros=array[t_numero] of int16;
procedure cargar_vector_numeros(var vector_numeros: t_vector_numeros; var numeros: int16);
var
  num: int16;
begin
  num:=num_salida+random(101);
  while ((num<>num_salida) and (numeros<num_total)) do
  begin
    numeros:=numeros+1;
    vector_numeros[numeros]:=num;
    num:=num_salida+random(101);
  end;
end;
procedure elementosMaximoYMinimo(vector_numeros: t_vector_numeros; numeros: int16; var ele_max, pos_max, ele_min, pos_min: int16);
var
  i: t_numero;
begin
  for i:= 1 to numeros do
  begin
    if (vector_numeros[i]>ele_max) then
    begin
      ele_max:=vector_numeros[i];
      pos_max:=i;
    end;
    if (vector_numeros[i]<ele_min) then
    begin
      ele_min:=vector_numeros[i];
      pos_min:=i;
    end;
  end;
end;
procedure intercambio(var vector_numeros: t_vector_numeros; pos_max, pos_min: int16);
var
  num_aux: int16;
begin
  num_aux:=vector_numeros[pos_max];
  vector_numeros[pos_max]:=vector_numeros[pos_min];
  vector_numeros[pos_min]:=num_aux;
end;
var
  vector_numeros: t_vector_numeros;
  numeros, ele_max, pos_max, ele_min, pos_min: int16;
begin
  randomize;
  numeros:=0;
  ele_max:=low(int16); pos_max:=0;
  ele_min:=high(int16); pos_min:=0;
  cargar_vector_numeros(vector_numeros,numeros);
  if (numeros>0) then
  begin
    elementosMaximoYMinimo(vector_numeros,numeros,ele_max,pos_max,ele_min,pos_min);
    intercambio(vector_numeros,pos_max,pos_min);
    textcolor(green); write('El elemento máximo '); textcolor(red); write(ele_max); textcolor(green); write(', que se encontraba en la posición '); textcolor(red); write(pos_max); textcolor(green); write(', fue intercambiado con el elemento mínimo '); textcolor(red); write(ele_min); textcolor(green); write(', que se encontraba en la posición '); textcolor(red); write(pos_min);
  end;
end.