{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 8}
{Realizar un programa modularizado que lea secuencia de números enteros. La lectura finaliza cuando llega el número 123456, el cual no debe procesarse.
Informar en pantalla, para cada número, la suma de sus dígitos pares y la cantidad de dígitos impares que posee.}

program TP2_E8;
{$codepage UTF8}
uses crt;
const
  num_salida=123456;
procedure suma_pares_cantidad_impares(num: int32; var suma_pares, cantidad_impares: int16);
var
  digito: int8;
begin
  while (num>0) do
  begin
    digito:=num mod 10;
    if (digito mod 2=0) then
      suma_pares:=suma_pares+digito
    else
      cantidad_impares:=cantidad_impares+1;
    num:=num div 10;
  end;
end;
var
  suma_pares, cantidad_impares: int16;
  num: int32;
begin
  randomize;
  num:=num_salida+random(100);
  while (num<>num_salida) do
  begin
    suma_pares:=0; cantidad_impares:=0;
    suma_pares_cantidad_impares(num,suma_pares,cantidad_impares);
    textcolor(green); write('La suma de los dígitos pares del número '); textcolor(yellow); write(num); textcolor(green); write(' es '); textcolor(red); writeln(suma_pares);
    textcolor(green); write('La cantidad de dígitos impares que posee el número '); textcolor(yellow); write(num); textcolor(green); write(' es '); textcolor(red); writeln(cantidad_impares);
    num:=num_salida+random(100);
  end;
end.