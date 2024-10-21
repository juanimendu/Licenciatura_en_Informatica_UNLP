{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 5}
{Realizar un programa que lea y almacene la información de productos de un supermercado. De cada producto, se lee: código, descripción, stock actual, stock mínimo y precio.
La lectura finaliza cuando se ingresa el código -1, que no debe procesarse.
Una vez leída y almacenada toda la información, calcular e informar:
•	Porcentaje de productos con stock actual por debajo de su stock mínimo.
•	Descripción de aquellos productos con código compuesto por, al menos, tres dígitos pares.
•	Código de los dos productos más económicos.}

program TP6_E5;
{$codepage UTF8}
uses crt;
const
  producto_salida=-1;
  pares_corte=3;
type
  t_registro_producto=record
    producto: int16;
    descripcion: string;
    stock_actual: int16;
    stock_minimo: int16;
    precio: real;
  end;
  t_lista_productos=^t_nodo_productos;
  t_nodo_productos=record
    ele: t_registro_producto;
    sig: t_lista_productos;
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
procedure leer_producto(var registro_producto: t_registro_producto);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_producto.producto:=producto_salida
  else
    registro_producto.producto:=1+random(high(int16));
  if (registro_producto.producto<>producto_salida) then
  begin
    registro_producto.descripcion:=random_string(5+random(6));
    registro_producto.stock_actual:=1+random(high(int16));
    registro_producto.stock_minimo:=1+random(high(int16));
    registro_producto.precio:=1+random(100);
  end;
end;
procedure agregar_adelante_lista_productos(var lista_productos: t_lista_productos; registro_producto: t_registro_producto);
var
  nuevo: t_lista_productos;
begin
  new(nuevo);
  nuevo^.ele:=registro_producto;
  nuevo^.sig:=lista_productos;
  lista_productos:=nuevo;
end;
procedure cargar_lista_productos(var lista_productos: t_lista_productos);
var
  registro_producto: t_registro_producto;
begin
  leer_producto(registro_producto);
  while (registro_producto.producto<>producto_salida) do
  begin
    agregar_adelante_lista_productos(lista_productos,registro_producto);
    leer_producto(registro_producto);
  end;
end;
function contar_pares(producto: int16): boolean;
var
  digito, pares: int8;
begin
  pares:=0;
  while ((producto<>0) and (pares<pares_corte)) do
  begin
    digito:=producto mod 10;
    if (digito mod 2=0) then
      pares:=pares+1;
    producto:=producto div 10;
  end;
  contar_pares:=(pares>=pares_corte);
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
procedure procesar_lista_productos(lista_productos: t_lista_productos; var porcentaje_debajo: real; var producto_min1, producto_min2: int16);
var
  productos_total, productos_debajo: int16;
  precio_min1, precio_min2: real;
begin
  productos_total:=0; productos_debajo:=0;
  precio_min1:=9999999; precio_min2:=9999999;
  while (lista_productos<>nil) do
  begin
    productos_total:=productos_total+1;
    if (lista_productos^.ele.stock_actual<lista_productos^.ele.stock_minimo) then
      productos_debajo:=productos_debajo+1;
    if (contar_pares(lista_productos^.ele.producto)=true) then
    begin
      textcolor(green); write('La descripción es este producto con código compuesto por, al menos, '); textcolor(yellow); write(pares_corte); textcolor(green); write(' dígitos pares es '); textcolor(red); writeln(lista_productos^.ele.descripcion);
    end;
    actualizar_minimos(lista_productos^.ele.precio,lista_productos^.ele.producto,precio_min1,precio_min2,producto_min1,producto_min2);
    lista_productos:=lista_productos^.sig;
  end;
  porcentaje_debajo:=productos_debajo/productos_total*100;
end;
var
  lista_productos: t_lista_productos;
  producto_min1, producto_min2: int16;
  porcentaje_debajo: real;
begin
  randomize;
  lista_productos:=nil;
  porcentaje_debajo:=0;
  producto_min1:=0; producto_min2:=0;
  cargar_lista_productos(lista_productos);
  if (lista_productos<>nil) then
  begin
    procesar_lista_productos(lista_productos,porcentaje_debajo,producto_min1,producto_min2);
    textcolor(green); write('El porcentaje de productos con stock actual por debajo de su stock mínimo es '); textcolor(red); write(porcentaje_debajo:0:2); textcolor(green); writeln('%');
    textcolor(green); write('Los códigos de los dos productos más econónomicos son '); textcolor(red); write(producto_min1); textcolor(green); write(' y '); textcolor(red); write(producto_min2);
  end;
end.