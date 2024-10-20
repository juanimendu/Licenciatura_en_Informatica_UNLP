{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 3}
{Un supermercado requiere el procesamiento de sus productos. De cada producto, se conoce código, rubro (1..10), stock y precio unitario. Se pide:
(a) Generar una estructura adecuada que permita agrupar los productos por rubro.
A su vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo más eficiente posible.
La lectura finaliza con el código de producto igual a -1.
(b) Implementar un módulo que reciba la estructura generada en (a), un rubro y un código de producto y retorne si dicho código existe o no para ese rubro.
(c) Implementar un módulo que reciba la estructura generada en (a) y retorne, para cada rubro, el código y stock del producto con mayor código.
(d) Implementar un módulo que reciba la estructura generada en (a), dos códigos y retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores ingresados.}

program TP5_E3;
{$codepage UTF8}
uses crt;
const
  rubro_ini=1; rubro_fin=10;
  codigo_salida=-1;
type
  t_rubro=rubro_ini..rubro_fin;
  t_registro_producto1=record
    codigo: int16;
    rubro: t_rubro;
    stock: int16;
    precio: real;
  end;
  t_registro_producto2=record
    codigo: int16;
    stock: int16;
    precio: real;
  end;
  t_abb_productos=^t_nodo_abb_productos;
  t_nodo_abb_productos=record
    ele: t_registro_producto2;
    hi: t_abb_productos;
    hd: t_abb_productos;
  end;
  t_vector_abbs=array[t_rubro] of t_abb_productos;
  t_registro_producto3=record
    codigo: int16;
    stock: int16;
  end;
  t_vector_productos=array[t_rubro] of t_registro_producto3;
  t_vector_cantidades=array[t_rubro] of int16;
procedure inicializar_vector_abbs(var vector_abbs: t_vector_abbs);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
    vector_abbs[i]:=nil;
end;
procedure inicializar_vector_productos(var vector_productos: t_vector_productos);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
  begin
    vector_productos[i].codigo:=codigo_salida;
    vector_productos[i].stock:=0;
  end;
end;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
    vector_cantidades[i]:=0;
end;
procedure leer_producto(var registro_producto1: t_registro_producto1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_producto1.codigo:=codigo_salida
  else
    registro_producto1.codigo:=1+random(high(int16));
  if (registro_producto1.codigo<>codigo_salida) then
  begin
    registro_producto1.rubro:=rubro_ini+random(rubro_fin);
    registro_producto1.stock:=1+random(high(int16));
    registro_producto1.precio:=1+random(100);
  end;
end;
procedure cargar_registro_producto2(var registro_producto2: t_registro_producto2; registro_producto1: t_registro_producto1);
begin
  registro_producto2.codigo:=registro_producto1.codigo;
  registro_producto2.stock:=registro_producto1.stock;
  registro_producto2.precio:=registro_producto1.precio;
end;
procedure agregar_abb_productos(var abb_productos: t_abb_productos; registro_producto1: t_registro_producto1);
begin
  if (abb_productos=nil) then
  begin
    new(abb_productos);
    cargar_registro_producto2(abb_productos^.ele,registro_producto1);
    abb_productos^.hi:=nil;
    abb_productos^.hd:=nil;
  end
  else
    if (registro_producto1.codigo<=abb_productos^.ele.codigo) then
      agregar_abb_productos(abb_productos^.hi,registro_producto1)
    else
      agregar_abb_productos(abb_productos^.hd,registro_producto1);
end;
procedure cargar_vector_abbs(var vector_abbs: t_vector_abbs);
var
  registro_producto1: t_registro_producto1;
begin
  leer_producto(registro_producto1);
  while (registro_producto1.codigo<>codigo_salida) do
  begin
    agregar_abb_productos(vector_abbs[registro_producto1.rubro],registro_producto1);
    leer_producto(registro_producto1);
  end;
end;
procedure imprimir_registro_producto2(registro_producto2: t_registro_producto2; rubro: t_rubro);
begin
  textcolor(green); write('El código de producto del producto del rubro '); textcolor(yellow); write(rubro); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto2.codigo);
  textcolor(green); write('El stock del producto del rubro '); textcolor(yellow); write(rubro); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto2.stock);
  textcolor(green); write('El precio del producto del rubro '); textcolor(yellow); write(rubro); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto2.precio:0:2);
end;
procedure imprimir_abb_productos(abb_productos: t_abb_productos; rubro: t_rubro);
begin
  if (abb_productos<>nil) then
  begin
    imprimir_abb_productos(abb_productos^.hi,rubro);
    imprimir_registro_producto2(abb_productos^.ele,rubro);
    imprimir_abb_productos(abb_productos^.hd,rubro);
  end;
end;
procedure imprimir_vector_abbs(vector_abbs: t_vector_abbs);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
  begin
    textcolor(green); write('La información de los productos del rubro '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_abb_productos(vector_abbs[i],i);
    writeln();
  end;
end;
function buscar_abb_productos(abb_productos: t_abb_productos; codigo: int16): boolean;
begin
  if (abb_productos=nil) then
    buscar_abb_productos:=false
  else
    if (codigo=abb_productos^.ele.codigo) then
      buscar_abb_productos:=true
    else if (codigo<abb_productos^.ele.codigo) then
      buscar_abb_productos:=buscar_abb_productos(abb_productos^.hi,codigo)
    else
      buscar_abb_productos:=buscar_abb_productos(abb_productos^.hd,codigo);
end;
procedure cargar_registro_producto3(var registro_producto3: t_registro_producto3; abb_productos: t_abb_productos);
begin
  if (abb_productos^.hd=nil) then
  begin
    registro_producto3.codigo:=abb_productos^.ele.codigo;
    registro_producto3.stock:=abb_productos^.ele.stock;
  end
  else
    cargar_registro_producto3(registro_producto3,abb_productos^.hd);
end;
procedure cargar_vector_productos(var vector_productos: t_vector_productos; vector_abbs: t_vector_abbs);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
    if (vector_abbs[i]<>nil) then
      cargar_registro_producto3(vector_productos[i],vector_abbs[i]);
end;
procedure imprimir_registro_producto3(registro_producto3: t_registro_producto3; rubro: t_rubro);
begin
  textcolor(green); write('El mayor código de producto del rubro '); textcolor(yellow); write(rubro); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto3.codigo);
  textcolor(green); write('El stock del mayor código de producto del rubro '); textcolor(yellow); write(rubro); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto3.stock);
end;
procedure imprimir_vector_productos(vector_productos: t_vector_productos);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
  begin
    imprimir_registro_producto3(vector_productos[i],i);
    writeln();
  end;
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
function contar_productos(abb_productos: t_abb_productos; codigo1, codigo2: int16): int16;
begin
  if (abb_productos=nil) then
    contar_productos:=0
  else
    if (codigo1>=abb_productos^.ele.codigo) then
      contar_productos:=contar_productos(abb_productos^.hd,codigo1,codigo2)
    else if (codigo2<=abb_productos^.ele.codigo) then
      contar_productos:=contar_productos(abb_productos^.hi,codigo1,codigo2)
    else
      contar_productos:=contar_productos(abb_productos^.hi,codigo1,codigo2)+contar_productos(abb_productos^.hd,codigo1,codigo2)+1;
end;
procedure cargar_vector_cantidades(var vector_cantidades: t_vector_cantidades; vector_abbs: t_vector_abbs; codigo1, codigo2: int16);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
    vector_cantidades[i]:=contar_productos(vector_abbs[i],codigo1,codigo2);
end;
procedure imprimir_vector_cantidades(vector_cantidades: t_vector_cantidades; codigo1, codigo2: int16);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
  begin
    textcolor(green); write('La cantidad de productos del rubro '); textcolor(yellow); write(i); textcolor(green); write(' (cuyo código de producto se encuentra entre '); textcolor(yellow); write(codigo1); textcolor(green); write(' y '); textcolor(yellow); write(codigo2); textcolor(green); write(') es '); textcolor(red); writeln(vector_cantidades[i]);
  end;
end;
var
  vector_abbs: t_vector_abbs;
  vector_productos: t_vector_productos;
  vector_cantidades: t_vector_cantidades;
  rubro: t_rubro;
  codigo, codigo1, codigo2: int16;
begin
  randomize;
  inicializar_vector_abbs(vector_abbs);
  inicializar_vector_productos(vector_productos);
  inicializar_vector_cantidades(vector_cantidades);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_abbs(vector_abbs);
  imprimir_vector_abbs(vector_abbs);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  rubro:=rubro_ini+random(rubro_fin); codigo:=1+random(high(int16));
  textcolor(green); write('¿El código '); textcolor(yellow); write(codigo); textcolor(green); write(' se encuentra en el abb del rubro '); textcolor(yellow); write(rubro); textcolor(green); write('?: '); textcolor(red); writeln(buscar_abb_productos(vector_abbs[rubro],codigo));
  writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
  cargar_vector_productos(vector_productos,vector_abbs);
  imprimir_vector_productos(vector_productos);
  writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
  codigo1:=1+random(high(int16)); codigo2:=1+random(high(int16));
  verificar_codigos(codigo1,codigo2);
  cargar_vector_cantidades(vector_cantidades,vector_abbs,codigo1,codigo2);
  imprimir_vector_cantidades(vector_cantidades,codigo1,codigo2);
end.