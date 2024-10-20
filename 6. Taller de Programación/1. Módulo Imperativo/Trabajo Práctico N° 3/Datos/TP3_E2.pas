{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 2}
{Escribir un programa que:
(a) Implemente un módulo que lea información de ventas de un comercio. De cada venta, se lee código de producto, fecha y cantidad de unidades vendidas.
La lectura finaliza con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
  (i) Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
  (ii) Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto.
  Cada nodo del árbol debe contener el código de producto y la cantidad total de unidades vendidas.
  Nota: El módulo debe retornar los dos árboles.
(b) Implemente un módulo que reciba el árbol generado en (i) y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
(c) Implemente un módulo que reciba el árbol generado en (ii) y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.}

program TP3_E2;
{$codepage UTF8}
uses crt;
const
  codigo_salida=0;
type
  t_registro_venta=record
    codigo: int8;
    fecha: int8;
    cantidad: int8;
  end;
  t_registro_producto=record
    codigo: int8;
    cantidad: int16;
  end;
  t_abb_ventas=^t_nodo_abb_ventas;
  t_nodo_abb_ventas=record
    ele: t_registro_venta;
    hi: t_abb_ventas;
    hd: t_abb_ventas;
  end;
  t_abb_productos=^t_nodo_abb_productos;
  t_nodo_abb_productos=record
    ele: t_registro_producto;
    hi: t_abb_productos;
    hd: t_abb_productos;
  end;
procedure leer_venta(var registro_venta: t_registro_venta);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_venta.codigo:=codigo_salida
  else
    registro_venta.codigo:=1+random(high(int8));
  if (registro_venta.codigo<>codigo_salida) then
  begin
    registro_venta.fecha:=1+random(high(int8));
    registro_venta.cantidad:=1+random(high(int8));
  end;
end;
procedure agregar_abb_ventas(var abb_ventas: t_abb_ventas; registro_venta: t_registro_venta);
begin
  if (abb_ventas=nil) then
  begin
    new(abb_ventas);
    abb_ventas^.ele:=registro_venta;
    abb_ventas^.hi:=nil;
    abb_ventas^.hd:=nil;
  end
  else
    if (registro_venta.codigo<=abb_ventas^.ele.codigo) then
      agregar_abb_ventas(abb_ventas^.hi,registro_venta)
    else
      agregar_abb_ventas(abb_ventas^.hd,registro_venta);
end;
procedure cargar_registro_producto(var registro_producto: t_registro_producto; registro_venta: t_registro_venta);
begin
  registro_producto.codigo:=registro_venta.codigo;
  registro_producto.cantidad:=registro_venta.cantidad;
end;
procedure agregar_abb_productos(var abb_productos: t_abb_productos; registro_venta: t_registro_venta);
begin
  if (abb_productos=nil) then
  begin
    new(abb_productos);
    cargar_registro_producto(abb_productos^.ele,registro_venta);
    abb_productos^.hi:=nil;
    abb_productos^.hd:=nil;
  end
  else
    if (registro_venta.codigo=abb_productos^.ele.codigo) then
      abb_productos^.ele.cantidad:=abb_productos^.ele.cantidad+registro_venta.cantidad
    else if (registro_venta.codigo<abb_productos^.ele.codigo) then
      agregar_abb_productos(abb_productos^.hi,registro_venta)
    else
      agregar_abb_productos(abb_productos^.hd,registro_venta);
end;
procedure cargar_abbs(var abb_ventas: t_abb_ventas; var abb_productos: t_abb_productos);
var
  registro_venta: t_registro_venta;
begin
  leer_venta(registro_venta);
  while (registro_venta.codigo<>codigo_salida) do
  begin
    agregar_abb_ventas(abb_ventas,registro_venta);
    agregar_abb_productos(abb_productos,registro_venta);
    leer_venta(registro_venta);
  end;
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta);
begin
  textcolor(green); write('El código de producto de la venta es '); textcolor(red); writeln(registro_venta.codigo);
  textcolor(green); write('La fecha de la venta es '); textcolor(red); writeln(registro_venta.fecha);
  textcolor(green); write('La cantidad de unidades vendidas de la venta es '); textcolor(red); writeln(registro_venta.cantidad);
  writeln();
end;
procedure imprimir_abb_ventas(abb_ventas: t_abb_ventas);
begin
  if (abb_ventas<>nil) then
  begin
    imprimir_abb_ventas(abb_ventas^.hi);
    imprimir_registro_venta(abb_ventas^.ele);
    imprimir_abb_ventas(abb_ventas^.hd);
  end;
end;
procedure imprimir_registro_producto(registro_producto: t_registro_producto);
begin
  textcolor(green); write('El código de producto del producto es '); textcolor(red); writeln(registro_producto.codigo);
  textcolor(green); write('La cantidad de unidades vendidas del producto es '); textcolor(red); writeln(registro_producto.cantidad);
  writeln();
end;
procedure imprimir_abb_productos(abb_productos: t_abb_productos);
begin
  if (abb_productos<>nil) then
  begin
    imprimir_abb_productos(abb_productos^.hi);
    imprimir_registro_producto(abb_productos^.ele);
    imprimir_abb_productos(abb_productos^.hd);
  end;
end;
function contar_abb_ventas(abb_ventas: t_abb_ventas; codigo: int8): int16;
begin
  if (abb_ventas=nil) then
    contar_abb_ventas:=0
  else
    if (codigo=abb_ventas^.ele.codigo) then
      contar_abb_ventas:=contar_abb_ventas(abb_ventas^.hi,codigo)+abb_ventas^.ele.cantidad
    else if (codigo<abb_ventas^.ele.codigo) then
      contar_abb_ventas:=contar_abb_ventas(abb_ventas^.hi,codigo)
    else
      contar_abb_ventas:=contar_abb_ventas(abb_ventas^.hd,codigo);
end;
function contar_abb_productos(abb_productos: t_abb_productos; codigo: int8): int16;
begin
  if (abb_productos=nil) then
    contar_abb_productos:=0
  else
    if (codigo=abb_productos^.ele.codigo) then
      contar_abb_productos:=abb_productos^.ele.cantidad
    else if (codigo<abb_productos^.ele.codigo) then
      contar_abb_productos:=contar_abb_productos(abb_productos^.hi,codigo)
    else
      contar_abb_productos:=contar_abb_productos(abb_productos^.hd,codigo);
end;
var
  abb_ventas: t_abb_ventas;
  abb_productos: t_abb_productos;
  codigo: int8;
begin
  randomize;
  abb_ventas:=nil; abb_productos:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abbs(abb_ventas,abb_productos);
  if ((abb_ventas<>nil) and (abb_productos<>nil)) then
  begin
    writeln(); textcolor(red); writeln('ABB_VENTAS:'); writeln();
    imprimir_abb_ventas(abb_ventas);
    writeln(); textcolor(red); writeln('ABB_PRODUCTOS:'); writeln();
    imprimir_abb_productos(abb_productos);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    codigo:=1+random(high(int8));
    textcolor(green); write('La cantidad total de unidades vendidas en el abb_ventas del código de producto '); textcolor(yellow); write(codigo); textcolor(green); write(' es '); textcolor(red); writeln(contar_abb_ventas(abb_ventas,codigo));
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    textcolor(green); write('La cantidad total de unidades vendidas en el abb_productos del código de producto '); textcolor(yellow); write(codigo); textcolor(green); write(' es '); textcolor(red); write(contar_abb_productos(abb_productos,codigo));
  end;
end.