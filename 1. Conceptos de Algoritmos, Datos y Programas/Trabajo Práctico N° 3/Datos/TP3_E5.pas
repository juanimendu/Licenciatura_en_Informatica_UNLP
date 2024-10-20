{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 5}
{Realizar un programa que lea información de autos que están a la venta en una concesionaria.
De cada auto, se lee: marca, modelo y precio. La lectura finaliza cuando se ingresa la marca “ZZZ”, que no debe procesarse. La información se ingresa ordenada por marca.
Se pide calcular e informar:
•	El precio promedio por marca.
•	Marca y modelo del auto más caro.}

program TP3_E5;
{$codepage UTF8}
uses crt;
const
  marca_salida='ZZZ';
type
  t_registro_auto=record
    marca: string;
    modelo: string;
    precio: real;
  end;
function random_string(length: int8): string;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_auto(var registro_auto: t_registro_auto; marca: string);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_auto.marca:=marca_salida
  else if (i<=50) then
    registro_auto.marca:=marca
  else
    registro_auto.marca:='Marca '+random_string(5+random(6));
  if (registro_auto.marca<>marca_salida) then
  begin
    registro_auto.modelo:='Modelo '+random_string(5+random(6));
    registro_auto.precio:=1000+random(99001);
  end;
end;
procedure actualizar_maximos(registro_auto: t_registro_auto; var precio_max: real; var marca_max, modelo_max: string);
begin
  if (registro_auto.precio>precio_max) then
  begin
    precio_max:=registro_auto.precio;
    marca_max:=registro_auto.marca;
    modelo_max:=registro_auto.modelo;
  end;
end;
procedure leer_autos(var marca_max, modelo_max: string);
var
  registro_auto: t_registro_auto;
  autos_total: int32;
  precio_total, precio_prom, precio_max: real;
  marca: string;
begin
  precio_max:=-9999999;
  marca:='Marca XXX';
  leer_auto(registro_auto,marca);
  while (registro_auto.marca<>marca_salida) do
  begin
    marca:=registro_auto.marca;
    precio_total:=0; autos_total:=0; precio_prom:=0;
    while ((registro_auto.marca<>marca_salida) and (registro_auto.marca=marca)) do
    begin
      precio_total:=precio_total+registro_auto.precio;
      autos_total:=autos_total+1;
      actualizar_maximos(registro_auto,precio_max,marca_max,modelo_max);
      leer_auto(registro_auto,marca);
    end;
    precio_prom:=precio_total/autos_total;
    textcolor(green); write('El precio promedio de la marca '); textcolor(red); write(marca); textcolor(green); write(' es '); textcolor(red); writeln(precio_prom:0:2);
  end;
end;
var
  marca_max, modelo_max: string;
begin
  randomize;
  marca_max:=''; modelo_max:='';
  leer_autos(marca_max,modelo_max);
  textcolor(green); write('La marca y el modelo del auto más caro son '); textcolor(red); write(marca_max); textcolor(green); write(' y '); textcolor(red); write(modelo_max); textcolor(green); write(', respectivamente');
end.