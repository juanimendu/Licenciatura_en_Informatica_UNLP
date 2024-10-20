{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 2}
{Escribir un programa que:
(a) Implemente un módulo que genere, aleatoriamente, información de ventas de un comercio. Para cada venta, generar código de producto, fecha y cantidad de unidades vendidas.
Finalizar con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
  (i) Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto. Los códigos repetidos van a la derecha.
  (ii) Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto.
  Cada nodo del árbol debe contener el código de producto y la cantidad total de unidades vendidas.
  (iii) Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto.
  Cada nodo del árbol debe contener el código de producto y la lista de las ventas realizadas del producto.
  Nota: El módulo debe retornar TRES árboles.
(b) Implemente un módulo que reciba el árbol generado en (i) y una fecha y retorne la cantidad total de productos vendidos en la fecha recibida.
(c) Implemente un módulo que reciba el árbol generado en (ii) y retorne el código de producto con mayor cantidad total de unidades vendidas.
(d) Implemente un módulo que reciba el árbol generado en (iii) y retorne el código de producto con mayor cantidad de ventas.}

program TP3_E2;
{$codepage UTF8}
uses crt;
const
  codigo_salida=0;
type
  t_registro_venta1=record
    codigo: int8;
    fecha: int8;
    cantidad: int8;
  end;
  t_abb_ventas=^t_nodo_abb_ventas;
  t_nodo_abb_ventas=record
    ele: t_registro_venta1;
    hi: t_abb_ventas;
    hd: t_abb_ventas;
  end;
  t_registro_producto1=record
    codigo: int8;
    cantidad: int16;
  end;
  t_abb_productos1=^t_nodo_abb_productos1;
  t_nodo_abb_productos1=record
    ele: t_registro_producto1;
    hi: t_abb_productos1;
    hd: t_abb_productos1;
  end;
  t_registro_venta2=record
    fecha: int8;
    cantidad: int8;
  end;
  t_lista_ventas=^t_nodo_ventas;
  t_nodo_ventas=record
    ele: t_registro_venta2;
    sig: t_lista_ventas;
  end;
  t_registro_producto2=record
    codigo: int8;
    ventas: t_lista_ventas;
  end;
  t_abb_productos2=^t_nodo_abb_productos2;
  t_nodo_abb_productos2=record
    ele: t_registro_producto2;
    hi: t_abb_productos2;
    hd: t_abb_productos2;
  end;
procedure leer_venta(var registro_venta1: t_registro_venta1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_venta1.codigo:=codigo_salida
  else
    registro_venta1.codigo:=1+random(high(int8));
  if (registro_venta1.codigo<>codigo_salida) then
  begin
    registro_venta1.fecha:=1+random(high(int8));
    registro_venta1.cantidad:=1+random(high(int8));
  end;
end;
procedure agregar_abb_ventas(var abb_ventas: t_abb_ventas; registro_venta1: t_registro_venta1);
begin
  if (abb_ventas=nil) then
  begin
    new(abb_ventas);
    abb_ventas^.ele:=registro_venta1;
    abb_ventas^.hi:=nil;
    abb_ventas^.hd:=nil;
  end
  else
    if (registro_venta1.codigo<abb_ventas^.ele.codigo) then
      agregar_abb_ventas(abb_ventas^.hi,registro_venta1)
    else
      agregar_abb_ventas(abb_ventas^.hd,registro_venta1);
end;
procedure cargar_registro_producto1(var registro_producto1: t_registro_producto1; registro_venta1: t_registro_venta1);
begin
  registro_producto1.codigo:=registro_venta1.codigo;
  registro_producto1.cantidad:=registro_venta1.cantidad;
end;
procedure agregar_abb_productos1(var abb_productos1: t_abb_productos1; registro_venta1: t_registro_venta1);
begin
  if (abb_productos1=nil) then
  begin
    new(abb_productos1);
    cargar_registro_producto1(abb_productos1^.ele,registro_venta1);
    abb_productos1^.hi:=nil;
    abb_productos1^.hd:=nil;
  end
  else
    if (registro_venta1.codigo=abb_productos1^.ele.codigo) then
      abb_productos1^.ele.cantidad:=abb_productos1^.ele.cantidad+registro_venta1.cantidad
    else if (registro_venta1.codigo<abb_productos1^.ele.codigo) then
      agregar_abb_productos1(abb_productos1^.hi,registro_venta1)
    else
      agregar_abb_productos1(abb_productos1^.hd,registro_venta1);
end;
procedure cargar_registro_venta2(var registro_venta2: t_registro_venta2; registro_venta1: t_registro_venta1);
begin
  registro_venta2.fecha:=registro_venta1.fecha;
  registro_venta2.cantidad:=registro_venta1.cantidad;
end;
procedure agregar_adelante_lista_ventas(var lista_ventas: t_lista_ventas; registro_venta1: t_registro_venta1);
var
  nuevo: t_lista_ventas;
begin
  new(nuevo);
  cargar_registro_venta2(nuevo^.ele,registro_venta1);
  nuevo^.sig:=lista_ventas;
  lista_ventas:=nuevo;
end;
procedure cargar_registro_producto2(var registro_producto2: t_registro_producto2; registro_venta1: t_registro_venta1);
begin
  registro_producto2.codigo:=registro_venta1.codigo;
  registro_producto2.ventas:=nil;
  agregar_adelante_lista_ventas(registro_producto2.ventas,registro_venta1);
end;
procedure agregar_abb_productos2(var abb_productos2: t_abb_productos2; registro_venta1: t_registro_venta1);
begin
  if (abb_productos2=nil) then
  begin
    new(abb_productos2);
    cargar_registro_producto2(abb_productos2^.ele,registro_venta1);
    abb_productos2^.hi:=nil;
    abb_productos2^.hd:=nil;
  end
  else
    if (registro_venta1.codigo=abb_productos2^.ele.codigo) then
      agregar_adelante_lista_ventas(abb_productos2^.ele.ventas,registro_venta1)
    else if (registro_venta1.codigo<abb_productos2^.ele.codigo) then
      agregar_abb_productos2(abb_productos2^.hi,registro_venta1)
    else
      agregar_abb_productos2(abb_productos2^.hd,registro_venta1);
end;
procedure cargar_abbs(var abb_ventas: t_abb_ventas; var abb_productos1: t_abb_productos1; var abb_productos2: t_abb_productos2);
var
  registro_venta1: t_registro_venta1;
begin
  leer_venta(registro_venta1);
  while (registro_venta1.codigo<>codigo_salida) do
  begin
    agregar_abb_ventas(abb_ventas,registro_venta1);
    agregar_abb_productos1(abb_productos1,registro_venta1);
    agregar_abb_productos2(abb_productos2,registro_venta1);
    leer_venta(registro_venta1);
  end;
end;
procedure imprimir_registro_venta1(registro_venta1: t_registro_venta1);
begin
  textcolor(green); write('El código de producto de la venta es '); textcolor(red); writeln(registro_venta1.codigo);
  textcolor(green); write('La fecha de la venta es '); textcolor(red); writeln(registro_venta1.fecha);
  textcolor(green); write('La cantidad de unidades vendidas de la venta es '); textcolor(red); writeln(registro_venta1.cantidad);
  writeln();
end;
procedure imprimir_abb_ventas(abb_ventas: t_abb_ventas);
begin
  if (abb_ventas<>nil) then
  begin
    imprimir_abb_ventas(abb_ventas^.hi);
    imprimir_registro_venta1(abb_ventas^.ele);
    imprimir_abb_ventas(abb_ventas^.hd);
  end;
end;
procedure imprimir_registro_producto1(registro_producto1: t_registro_producto1);
begin
  textcolor(green); write('El código de producto del producto es '); textcolor(red); writeln(registro_producto1.codigo);
  textcolor(green); write('La cantidad de unidades vendidas del producto es '); textcolor(red); writeln(registro_producto1.cantidad);
  writeln();
end;
procedure imprimir_abb_productos1(abb_productos1: t_abb_productos1);
begin
  if (abb_productos1<>nil) then
  begin
    imprimir_abb_productos1(abb_productos1^.hi);
    imprimir_registro_producto1(abb_productos1^.ele);
    imprimir_abb_productos1(abb_productos1^.hd);
  end;
end;
procedure imprimir_registro_venta2(registro_venta2: t_registro_venta2; codigo: int8; venta: int16);
begin
  textcolor(green); write('La fecha de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' del código de producto '); textcolor(yellow); write(codigo); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta2.fecha);
  textcolor(green); write('La cantidad de unidades vendidas de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' del código de producto '); textcolor(yellow); write(codigo); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta2.cantidad);
end;
procedure imprimir_lista_ventas(lista_ventas: t_lista_ventas; codigo: int8);
var
  i: int16;
begin
  i:=0;
  while (lista_ventas<>nil) do
  begin
    i:=i+1;
    imprimir_registro_venta2(lista_ventas^.ele,codigo,i);
    lista_ventas:=lista_ventas^.sig;
  end;
end;
procedure imprimir_registro_producto2(registro_producto2: t_registro_producto2);
begin
  textcolor(green); write('El código de producto del producto es '); textcolor(red); writeln(registro_producto2.codigo);
  imprimir_lista_ventas(registro_producto2.ventas,registro_producto2.codigo);
  writeln();
end;
procedure imprimir_abb_productos2(abb_productos2: t_abb_productos2);
begin
  if (abb_productos2<>nil) then
  begin
    imprimir_abb_productos2(abb_productos2^.hi);
    imprimir_registro_producto2(abb_productos2^.ele);
    imprimir_abb_productos2(abb_productos2^.hd);
  end;
end;
function contar_abb_ventas(abb_ventas: t_abb_ventas; fecha: int8): int16;
begin
  if (abb_ventas=nil) then
    contar_abb_ventas:=0
  else
    if (fecha=abb_ventas^.ele.fecha) then
      contar_abb_ventas:=contar_abb_ventas(abb_ventas^.hi,fecha)+contar_abb_ventas(abb_ventas^.hd,fecha)+abb_ventas^.ele.cantidad
    else
      contar_abb_ventas:=contar_abb_ventas(abb_ventas^.hi,fecha)+contar_abb_ventas(abb_ventas^.hd,fecha);
end;
procedure buscar_codigo_mayor_productos(abb_productos1: t_abb_productos1; var productos_max: int16; var codigo_max1: int8);
begin
  if (abb_productos1<>nil) then
  begin
    buscar_codigo_mayor_productos(abb_productos1^.hi,productos_max,codigo_max1);
    if (abb_productos1^.ele.cantidad>productos_max) then
    begin
      productos_max:=abb_productos1^.ele.cantidad;
      codigo_max1:=abb_productos1^.ele.codigo;
    end;
    buscar_codigo_mayor_productos(abb_productos1^.hd,productos_max,codigo_max1);
  end;
end;
function contar_ventas(lista_ventas: t_lista_ventas): int16;
var
  ventas: int16;
begin
  ventas:=0;
  while (lista_ventas<>nil) do
  begin
    ventas:=ventas+1;
    lista_ventas:=lista_ventas^.sig;
  end;
  contar_ventas:=ventas;
end;
procedure buscar_codigo_mayor_ventas(abb_productos2: t_abb_productos2; var ventas_max: int16; var codigo_max2: int8);
var
  ventas: int16;
begin
  if (abb_productos2<>nil) then
  begin
    buscar_codigo_mayor_ventas(abb_productos2^.hi,ventas_max,codigo_max2);
    ventas:=contar_ventas(abb_productos2^.ele.ventas);
    if (ventas>ventas_max) then
    begin
      ventas_max:=ventas;
      codigo_max2:=abb_productos2^.ele.codigo;
    end;
    buscar_codigo_mayor_ventas(abb_productos2^.hd,ventas_max,codigo_max2);
  end;
end;
var
  abb_ventas: t_abb_ventas;
  abb_productos1: t_abb_productos1;
  abb_productos2: t_abb_productos2;
  codigo_max1, codigo_max2: int8;
  fecha, productos_max, ventas_max: int16;
begin
  randomize;
  abb_ventas:=nil; abb_productos1:=nil; abb_productos2:=nil;
  productos_max:=low(int16); codigo_max1:=codigo_salida;
  ventas_max:=low(int16); codigo_max2:=codigo_salida;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abbs(abb_ventas,abb_productos1,abb_productos2);
  if ((abb_ventas<>nil) and (abb_productos1<>nil) and (abb_productos2<>nil)) then
  begin
    writeln(); textcolor(red); writeln('ABB_VENTAS:'); writeln();
    imprimir_abb_ventas(abb_ventas);
    writeln(); textcolor(red); writeln('ABB_PRODUCTOS1:'); writeln();
    imprimir_abb_productos1(abb_productos1);
    writeln(); textcolor(red); writeln('ABB_PRODUCTOS2:'); writeln();
    imprimir_abb_productos2(abb_productos2);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    fecha:=1+random(high(int8));
    textcolor(green); write('La cantidad total de unidades vendidas en el abb_ventas en la fecha '); textcolor(yellow); write(fecha); textcolor(green); write(' es '); textcolor(red); writeln(contar_abb_ventas(abb_ventas,fecha));
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    buscar_codigo_mayor_productos(abb_productos1,productos_max,codigo_max1);
    textcolor(green); write('El código de producto con mayor cantidad de unidades vendidas es '); textcolor(red); writeln(codigo_max1);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    buscar_codigo_mayor_ventas(abb_productos2,ventas_max,codigo_max2);
    textcolor(green); write('El código de producto con mayor cantidad de ventas es '); textcolor(red); write(codigo_max2);
  end;
end.