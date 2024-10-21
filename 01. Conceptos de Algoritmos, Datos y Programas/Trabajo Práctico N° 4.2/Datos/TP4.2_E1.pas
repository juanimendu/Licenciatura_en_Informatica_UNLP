{TRABAJO PRÁCTICO N° 4.2}
{EJERCICIO 1}
{(a) Dado un vector de enteros de, a lo sumo, 500 valores, realizar un módulo que reciba dicho vector y un valor n y retorne si n se encuentra en el vector o no.
(b) Modificar el módulo del inciso (a) considerando, ahora, que el vector se encuentra ordenado de manera ascendente.}

program TP4_E1;
{$codepage UTF8}
uses crt;
const
  num_total=500;
type
  t_numero=1..num_total;
  t_vector_numeros=array[t_numero] of int16;
procedure cargar_vector_numeros(var vector_numeros: t_vector_numeros);
var
  i: t_numero;
begin
  for i:= 1 to num_total do
    vector_numeros[i]:=random(1000);
end;
function buscar_desordenado_vector_numeros(vector_numeros: t_vector_numeros; num: int16): boolean;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=num_total) and (vector_numeros[pos]<>num)) do
    pos:=pos+1;
  buscar_desordenado_vector_numeros:=(pos<=num_total);
end;
procedure ordenar_vector_numeros(var vector_numeros: t_vector_numeros);
var
  i, j, k: t_numero;
  item: int16;
begin
  for i:= 1 to (num_total-1) do
  begin
    k:=i;
    for j:= (i+1) to num_total do
      if (vector_numeros[j]<vector_numeros[k]) then
        k:=j;
    if (k<>i) then
    begin
      item:=vector_numeros[k];
      vector_numeros[k]:=vector_numeros[i];
      vector_numeros[i]:=item;
    end;
  end;
end;
function buscar_ordenado_vector_numeros(vector_numeros: t_vector_numeros; num: int16): boolean;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=num_total) and (vector_numeros[pos]<num)) do
    pos:=pos+1;
  buscar_ordenado_vector_numeros:=((pos<=num_total) and (vector_numeros[pos]=num));
end;
var
  vector_numeros: t_vector_numeros;
  num: int16;
begin
  randomize;
  cargar_vector_numeros(vector_numeros);
  num:=random(1000);
  textcolor(green); write('¿El número '); textcolor(yellow); write(num); textcolor(green); write(' se encontró en el vector (desordenado)?: '); textcolor(red); writeln(buscar_desordenado_vector_numeros(vector_numeros,num));
  ordenar_vector_numeros(vector_numeros);
  textcolor(green); write('¿El número '); textcolor(yellow); write(num); textcolor(green); write(' se encontró en el vector (ordenado)?: '); textcolor(red); write(buscar_ordenado_vector_numeros(vector_numeros,num));
end.