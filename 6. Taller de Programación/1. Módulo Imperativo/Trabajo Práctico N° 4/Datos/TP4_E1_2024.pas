{TRABAJO PRÁCTICO N° 4}
{EJERCICIO 1}
{(a) Almacenar los productos vendidos en una estructura eficiente para la búsqueda por código de producto.
De cada producto, deben quedar almacenados su código, la cantidad total de unidades vendidas y el monto total.
De cada venta, se cargan código de venta, código del producto vendido, cantidad de unidades vendidas y precio unitario.
El ingreso de las ventas finaliza cuando se lee el código de venta 0.
(b) Imprimir el contenido del árbol ordenado por código de producto.
(c) Retornar el menor código de producto.
(d) Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro.
(e) Retornar el monto total entre todos los códigos de productos comprendidos entre dos valores recibidos (sin incluir) como parámetros.}

program TP4_E1;
{$codepage UTF8}
uses crt;
const
  codigo_venta_salida=0;
type
  t_registro_venta=record
    codigo_venta: int16;
    codigo_producto: int16;
    cantidad: int8;
    precio: real;
  end;
  t_registro_producto=record
    codigo_producto: int16;
    cantidad_total: int16;
    monto_total: real;
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
    registro_venta.codigo_venta:=codigo_venta_salida
  else
    registro_venta.codigo_venta:=random(high(int16));
  if (registro_venta.codigo_venta<>codigo_venta_salida) then
  begin
    registro_venta.codigo_producto:=1+random(high(int16));
    registro_venta.cantidad:=1+random(high(int8));
    registro_venta.precio:=1+random(100);
  end;
end;
procedure cargar_registro_producto(var registro_producto: t_registro_producto; registro_venta: t_registro_venta);
begin
  registro_producto.codigo_producto:=registro_venta.codigo_producto;
  registro_producto.cantidad_total:=registro_venta.cantidad;
  registro_producto.monto_total:=registro_venta.cantidad*registro_venta.precio;
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
    if (registro_venta.codigo_producto=abb_productos^.ele.codigo_producto) then
    begin
      abb_productos^.ele.cantidad_total:=abb_productos^.ele.cantidad_total+registro_venta.cantidad;
      abb_productos^.ele.monto_total:=abb_productos^.ele.monto_total+registro_venta.cantidad*registro_venta.precio;
    end
    else
      if (registro_venta.codigo_producto<abb_productos^.ele.codigo_producto) then
        agregar_abb_productos(abb_productos^.hi,registro_venta)
      else
        agregar_abb_productos(abb_productos^.hd,registro_venta);
end;
procedure cargar_abb_productos(var abb_productos: t_abb_productos);
var
  registro_venta: t_registro_venta;
begin
  leer_venta(registro_venta);
  while (registro_venta.codigo_venta<>codigo_venta_salida) do
  begin
    agregar_abb_productos(abb_productos,registro_venta);
    leer_venta(registro_venta);
  end;
end;
procedure imprimir_registro_producto(registro_producto: t_registro_producto);
begin
  textcolor(green); write('El código de producto del producto es '); textcolor(red); writeln(registro_producto.codigo_producto);
  textcolor(green); write('La cantidad total de unidades vendidas del producto es '); textcolor(red); writeln(registro_producto.cantidad_total);
  textcolor(green); write('El monto total del producto es $'); textcolor(red); writeln(registro_producto.monto_total:0:2);
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
function buscar_menor_codigo(abb_productos: t_abb_productos): int16;
begin
  if (abb_productos^.hi=nil) then
    buscar_menor_codigo:=abb_productos^.ele.codigo_producto
  else
    buscar_menor_codigo:=buscar_menor_codigo(abb_productos^.hi);
end;
function contar_codigos(abb_productos: t_abb_productos; codigo: int16): int16;
begin
  if (abb_productos=nil) then
    contar_codigos:=0
  else
    if (abb_productos^.ele.codigo_producto<codigo) then
      contar_codigos:=contar_codigos(abb_productos^.hi,codigo)+contar_codigos(abb_productos^.hd,codigo)+1
    else
      contar_codigos:=contar_codigos(abb_productos^.hi,codigo);
end;
procedure verificar_codigos(var codigo1, codigo2: int16);
var
  aux: int16;
begin
  if (codigo1>codigo2) then
  begin
    aux:=codigo1;
    codigo1:=codigo2;
    codigo2:=aux;
  end;
end;
function contar_monto_total(abb_productos: t_abb_productos; codigo1, codigo2: int16): real;
begin
  if (abb_productos=nil) then
    contar_monto_total:=0
  else
    if (codigo1>=abb_productos^.ele.codigo_producto) then
      contar_monto_total:=contar_monto_total(abb_productos^.hd,codigo1,codigo2)
    else if (codigo2<=abb_productos^.ele.codigo_producto) then
      contar_monto_total:=contar_monto_total(abb_productos^.hi,codigo1,codigo2)
    else
      contar_monto_total:=contar_monto_total(abb_productos^.hi,codigo1,codigo2)+contar_monto_total(abb_productos^.hd,codigo1,codigo2)+abb_productos^.ele.monto_total;
end;
var
  abb_productos: t_abb_productos;
  codigo, codigo1, codigo2: int16;
begin
  randomize;
  abb_productos:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abb_productos(abb_productos);
  if (abb_productos<>nil) then
  begin
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    imprimir_abb_productos(abb_productos);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    textcolor(green); write('El código de producto más chico es '); textcolor(red); writeln(buscar_menor_codigo(abb_productos));
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    codigo:=1+random(high(int16));
    textcolor(green); write('La cantidad de códigos menores que el código de producto '); textcolor(yellow); write(codigo); textcolor(green); write(' es '); textcolor(red); writeln(contar_codigos(abb_productos,codigo));
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    codigo1:=1+random(high(int16)); codigo2:=1+random(high(int16));
    verificar_codigos(codigo1,codigo2);
    textcolor(green); write('El monto total de todos los códigos de producto en el abb compredidos entre '); textcolor(yellow); write(codigo1); textcolor(green); write(' y '); textcolor(yellow); write(codigo2); textcolor(green); write(' es $'); textcolor(red); write(contar_monto_total(abb_productos,codigo1,codigo2):0:2);
  end;
end.