{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 7}
{Realizar un programa que lea el código, el precio actual y el nuevo precio de los productos de un almacén.
La lectura finaliza al ingresar el producto con el código 32767, el cual debe procesarse.
Para cada producto leído, el programa deberá indicar si el nuevo precio del producto supera en un 10% al precio anterior. Por ejemplo:
•	Si se ingresa el código 10382, con precio actual 40 y nuevo precio 44, deberá imprimir: “El aumento de precio del producto 10382 no supera el 10%”.
•	Si se ingresa el código 32767, con precio actual 30 y nuevo precio 33,01, deberá imprimir: “El aumento de precio del producto 32767 es superior al 10%”.}

program TP1_E7;
{$codepage UTF8}
uses crt;
const
  producto_salida=32767;
  porcentaje_corte=10.0;
var
  i: int8;
  producto: int16;
  precio_actual, precio_nuevo, variacion: real;
begin
  randomize;
  producto:=0;
  while (producto<>producto_salida) do
  begin
    i:=random(100);
    if (i=0) then
      producto:=producto_salida
    else
      producto:=1+random(high(int16));
    precio_actual:=1+random(100);
    precio_nuevo:=precio_actual*(1+random(21)/100);
    variacion:=(precio_nuevo/precio_actual-1)*100;
    if (variacion<=porcentaje_corte) then
    begin
      textcolor(green); write('El aumento de precio del producto '); textcolor(red); write(producto); textcolor(green); write(' no supera el '); textcolor(yellow); write(porcentaje_corte:0:2); textcolor(green); writeln('%');
    end
    else
    begin
      textcolor(green); write('El aumento de precio del producto '); textcolor(red); write(producto); textcolor(green); write(' es superior al '); textcolor(yellow); write(porcentaje_corte:0:2); textcolor(green); writeln('%');
    end;
  end;
end.