{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 7}
{(a) Realizar un módulo que reciba como parámetro un número entero y retorne la cantidad de dígitos que posee y la suma de los mismos.
(b) Utilizando el módulo anterior, realizar un programa que lea una secuencia de números e imprima la cantidad total de dígitos leídos.
La lectura finaliza al leer un número cuyos dígitos suman, exactamente, 10, el cual debe procesarse.}

program TP2_E7;
{$codepage UTF8}
uses crt;
const
  suma_salida=10;
procedure cantidad_suma_digitos(num: int16; var digitos, suma: int16);
var
  digito: int8;
begin
  while (num>0) do
  begin
    digito:=num mod 10;
    digitos:=digitos+1;
    suma:=suma+digito;
    num:=num div 10;
  end;
end;
procedure cantidad_digitos_total(var digitos_total: int16);
var
  num, digitos, suma: int16;
begin
  repeat
    num:=1+random(1000);
    digitos:=0; suma:=0;
    cantidad_suma_digitos(num,digitos,suma);
    digitos_total:=digitos_total+digitos;
  until (suma=suma_salida);
end;
var
  digitos_total: int16;
begin
  randomize;
  digitos_total:=0;
  cantidad_digitos_total(digitos_total);
  textcolor(green); write('La cantidad total de dígitos leídos es '); textcolor(red); write(digitos_total);
end.