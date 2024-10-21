{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 6}
{Realizar un programa que lea información de 200 productos de un supermercado. De cada producto, se lee código y precio (cada código es un número entre 1 y 200).
Informar en pantalla:
•	Los códigos de los dos productos más baratos.
•	La cantidad de productos de más de 16 pesos con código par.}

program TP1_E6;
{$codepage UTF8}
uses crt;
const
  producto_ini=1; producto_fin=200;
  precio_corte=16.0;
type
  t_producto=producto_ini..producto_fin;
var
  i, producto: t_producto;
  producto_min1, producto_min2, productos_corte: int16;
  precio, precio_min1, precio_min2: real;
begin
  randomize;
  precio_min1:=9999999; precio_min2:=9999999; producto_min1:=0; producto_min2:=0;
  productos_corte:=0;
  for i:= producto_ini to producto_fin do
  begin
    producto:=producto_ini+random(producto_fin);
    precio:=1+random(100);
    if (precio<precio_min1) then
    begin
      precio_min2:=precio_min1;
      producto_min2:=producto_min1;
      precio_min1:=precio;
      producto_min1:=producto;
    end
    else
      if (precio<precio_min2) then
      begin
        precio_min2:=precio;
        producto_min2:=producto;
      end;
    if ((precio>precio_corte) and (producto mod 2=0)) then
      productos_corte:=productos_corte+1;
  end;
  textcolor(green); write('Los códigos de los dos productos más baratos son '); textcolor(red); write(producto_min1); textcolor(green); write(' y '); textcolor(red); writeln(producto_min2);
  textcolor(green); write('La cantidad de productos de más de '); textcolor(yellow); write(precio_corte:0:2); textcolor(green); write(' pesos con código par es '); textcolor(red); write(productos_corte);
end.