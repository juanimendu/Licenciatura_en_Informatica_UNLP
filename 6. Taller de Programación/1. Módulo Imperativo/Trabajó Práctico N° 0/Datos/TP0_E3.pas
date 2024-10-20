{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 3}
{Implementar un programa que procese las ventas de un supermercado. El supermercado dispone de una tabla con los precios y stocks de los 1000 productos que tiene a la venta.
(a) Implementar un módulo que retorne, en una estructura de datos adecuada, los tickets de las ventas.
De cada venta, se lee código de venta y los productos vendidos. Las ventas finalizan con el código de venta -1.
De cada producto, se lee código y cantidad de unidades solicitadas.
Para cada venta, la lectura de los productos a vender finaliza con cantidad de unidades vendidas igual a 0.
El ticket debe contener:
•	Código de venta.
•	Detalle (código de producto, cantidad y precio unitario) de los productos que se pudieron vender. En caso de no haber stock suficiente, se venderá la máxima cantidad posible.
•	Monto total de la venta.
(b) Implementar un módulo que reciba la estructura generada en el inciso (a) y un código de producto y retorne la cantidad de unidades vendidas de ese código de producto.}

program TP0_E3;
{$codepage UTF8}
uses crt;
const
  productos_total=1000;
  codigo_venta_salida=-1;
  cantidad_salida=0;
type
  t_producto=1..productos_total;
  t_registro_producto=record
    codigo_producto: int16;
    cantidad: int8;
    precio: real;
  end;
  t_lista_productos=^t_nodo_productos;
  t_nodo_productos=record
    ele: t_registro_producto;
    sig: t_lista_productos;
  end;
  t_registro_venta=record
    codigo_venta: int16;
    productos: t_lista_productos;
    monto_total: real;
  end;
  t_lista_ventas=^t_nodo_ventas;
  t_nodo_ventas=record
    ele: t_registro_venta;
    sig: t_lista_ventas;
  end;
  t_vector_productos=array[t_producto] of t_registro_producto;
procedure cargar_vector_productos(var vector_productos: t_vector_productos);
var
	i: t_producto;
begin
	for i:= 1 to productos_total do
	begin
		vector_productos[i].codigo_producto:=i;
		vector_productos[i].cantidad:=1+random(high(int8));
		vector_productos[i].precio:=1+random(100);
	end;
end;
function buscar_vector_productos(vector_productos: t_vector_productos; codigo_producto: int16): t_producto;
var
  pos: t_producto;
begin
  pos:=1;
  while (vector_productos[pos].codigo_producto<>codigo_producto) do
    pos:=pos+1;
  buscar_vector_productos:=pos;
end;
procedure actualizar_vector_productos(var vector_productos: t_vector_productos; var registro_producto: t_registro_producto; pos: t_producto);
begin
  if (registro_producto.cantidad<vector_productos[pos].cantidad) then
    vector_productos[pos].cantidad:=vector_productos[pos].cantidad-registro_producto.cantidad
  else
  begin
    registro_producto.cantidad:=vector_productos[pos].cantidad;
    vector_productos[pos].cantidad:=0;
  end;
end;
procedure leer_producto(var registro_producto: t_registro_producto; var vector_productos: t_vector_productos; var monto_total: real);
var
  pos: t_producto;
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_producto.cantidad:=cantidad_salida
  else
    registro_producto.cantidad:=1+random(high(int8));
  if (registro_producto.cantidad<>cantidad_salida) then
  begin
    registro_producto.codigo_producto:=1+random(productos_total);
    pos:=buscar_vector_productos(vector_productos,registro_producto.codigo_producto);
    actualizar_vector_productos(vector_productos,registro_producto,pos);
    registro_producto.precio:=vector_productos[pos].precio;
    monto_total:=monto_total+registro_producto.precio*registro_producto.cantidad;
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
procedure cargar_lista_productos(var lista_productos: t_lista_productos; var vector_productos: t_vector_productos; var monto_total: real);
var
  registro_producto: t_registro_producto;
begin
  leer_producto(registro_producto,vector_productos,monto_total);
  while (registro_producto.cantidad<>cantidad_salida) do
  begin
    agregar_adelante_lista_productos(lista_productos,registro_producto);
    leer_producto(registro_producto,vector_productos,monto_total);
  end;
end;
procedure leer_venta(var registro_venta: t_registro_venta; var vector_productos: t_vector_productos);
var
  i: int8;
  monto_total: real;
begin
  i:=random(100);
  if (i=0) then
    registro_venta.codigo_venta:=codigo_venta_salida
  else
    registro_venta.codigo_venta:=1+random(high(int16));
  if (registro_venta.codigo_venta<>codigo_venta_salida) then
  begin
    registro_venta.productos:=nil; monto_total:=0;
    cargar_lista_productos(registro_venta.productos,vector_productos,monto_total);
    registro_venta.monto_total:=monto_total;
  end;
end;
procedure agregar_adelante_lista_ventas(var lista_ventas: t_lista_ventas; registro_venta: t_registro_venta);
var
  nuevo: t_lista_ventas;
begin
  new(nuevo);
  nuevo^.ele:=registro_venta;
  nuevo^.sig:=lista_ventas;
  lista_ventas:=nuevo;
end;
procedure cargar_lista_ventas(var lista_ventas: t_lista_ventas; vector_productos: t_vector_productos);
var
  registro_venta: t_registro_venta;
begin
  leer_venta(registro_venta,vector_productos);
  while (registro_venta.codigo_venta<>codigo_venta_salida) do
  begin
    agregar_adelante_lista_ventas(lista_ventas,registro_venta);
    leer_venta(registro_venta,vector_productos);
  end;
end;
procedure imprimir_registro_producto(registro_producto: t_registro_producto; venta: int16; codigo: int16);
begin
  textcolor(green); write('El código de producto del producto '); textcolor(yellow); write(codigo); textcolor(green); write(' de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto.codigo_producto);
  textcolor(green); write('La cantidad del producto '); textcolor(yellow); write(codigo); textcolor(green); write(' de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto.cantidad);
  textcolor(green); write('El precio unitario del producto '); textcolor(yellow); write(codigo); textcolor(green); write(' de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto.precio:0:2);
end;
procedure imprimir_lista_productos(lista_productos: t_lista_productos; venta: int16);
var
  i: int16;
begin
  i:=0;
  while (lista_productos<>nil) do
  begin
    i:=i+1;
    imprimir_registro_producto(lista_productos^.ele,venta,i);
    lista_productos:=lista_productos^.sig;
  end;
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta; venta: int16);
begin
  textcolor(green); write('El código de venta de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.codigo_venta);
  textcolor(green); write('El monto total de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.monto_total:0:2);
  imprimir_lista_productos(registro_venta.productos,venta);
end;
procedure imprimir_lista_ventas(lista_ventas: t_lista_ventas);
var
  i: int16;
begin
  i:=0;
  while (lista_ventas<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información de la venta '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_venta(lista_ventas^.ele,i);
    writeln();
    lista_ventas:=lista_ventas^.sig;
  end;
end;
procedure buscar_lista_productos(lista_productos: t_lista_productos; codigo_producto: int16; var ventas: int32);
begin
  while (lista_productos<>nil) do
  begin
    if (lista_productos^.ele.codigo_producto=codigo_producto) then
      ventas:=ventas+lista_productos^.ele.cantidad;
    lista_productos:=lista_productos^.sig;
  end;
end;
function buscar_lista_ventas(lista_ventas: t_lista_ventas; codigo_producto: int16): int32;
var
  ventas: int32;
begin
  ventas:=0;
  while (lista_ventas<>nil) do
  begin
    buscar_lista_productos(lista_ventas^.ele.productos,codigo_producto,ventas);
    lista_ventas:=lista_ventas^.sig;
  end;
  buscar_lista_ventas:=ventas;
end;
var
  vector_productos: t_vector_productos;
  lista_ventas: t_lista_ventas;
  codigo_producto: int16;
begin
  randomize;
  lista_ventas:=nil;
  cargar_vector_productos(vector_productos);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_ventas(lista_ventas,vector_productos);
  if (lista_ventas<>nil) then
  begin
    imprimir_lista_ventas(lista_ventas);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    codigo_producto:=1+random(productos_total);
    textcolor(green); write('La cantidad de unidades vendidas en la lista del código de producto '); textcolor(yellow); write(codigo_producto); textcolor(green); write(' es '); textcolor(red); write(buscar_lista_ventas(lista_ventas,codigo_producto));
  end;
end.