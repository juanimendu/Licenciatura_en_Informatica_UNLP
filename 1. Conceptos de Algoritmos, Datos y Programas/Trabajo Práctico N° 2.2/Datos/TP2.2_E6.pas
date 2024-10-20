{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 6}
{Realizar un programa modularizado que lea datos de 100 productos de una tienda de ropa.
Para cada producto, debe leer el precio, código y tipo (pantalón, remera, camisa, medias, campera, etc.).
Informar:
•	Código de los dos productos más baratos.
•	Código del producto de tipo “pantalón” más caro.
•	Precio promedio.}

program TP2_E6;
{$codepage UTF8}
uses crt;
const
  productos_total=100;
  tipo_corte='pantalon';
procedure leer_producto(var precio: real; var producto: int16; var tipo: string);
var
  vector_tipos: array[1..5] of string=('pantalon', 'remera', 'camisa', 'medias', 'campera');
begin
  precio:=1+random(100);
  producto:=1+random(100);
  tipo:=vector_tipos[1+random(5)];
end;
procedure actualizar_minimos(precio: real; producto: int16; var precio_min1, precio_min2: real; var producto_min1, producto_min2: int16);
begin
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
end;
procedure actualizar_maximo(precio: real; producto: int16; tipo: string; var precio_max: real; var producto_max: int16);
begin
  if ((tipo=tipo_corte) and (precio>precio_max)) then
    begin
      precio_max:=precio;
      producto_max:=producto;
    end;
end;
procedure leer_productos(var producto_min1, producto_min2, producto_max: int16; var precio_prom: real);
var
  i: int8;
  producto: int16;
  precio, precio_min1, precio_min2, precio_max, precio_total: real;
  tipo: string;
begin
  precio_min1:=9999999; precio_min2:=9999999;
  precio_max:=-9999999;
  precio_total:=0;
  for i:= 1 to productos_total do
  begin
    leer_producto(precio,producto,tipo);
    actualizar_minimos(precio,producto,precio_min1,precio_min2,producto_min1,producto_min2);
    actualizar_maximo(precio,producto,tipo,precio_max,producto_max);
    precio_total:=precio_total+precio;
  end;
  precio_prom:=precio_total/productos_total;
end;
var
  producto_min1, producto_min2, producto_max: int16;
  precio_prom: real;
begin
  randomize;
  producto_min1:=0; producto_min2:=0;
  producto_max:=0;
  precio_prom:=0;
  leer_productos(producto_min1,producto_min2,producto_max,precio_prom);
  textcolor(green); write('Los códigos de los dos productos más baratos son '); textcolor(red); write(producto_min1); textcolor(green); write(' y '); textcolor(red); writeln(producto_min2);
  textcolor(green); write('El código del producto de tipo '); textcolor(yellow); write(tipo_corte); textcolor(green); write(' más caro es '); textcolor(red); writeln(producto_max);
  textcolor(green); write('El precio promedio es $'); textcolor(red); write(precio_prom:0:2);
end.