{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 4}
{Una librería requiere el procesamiento de la información de sus productos. De cada producto, se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
(a) Leer los datos de los productos y almacenarlos ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se lee el precio 0.
(b) Una vez almacenados, mostrar los códigos de los productos pertenecientes a cada rubro.
(c) Generar un vector (de, a lo sumo, 30 elementos) con los productos del rubro 3. Considerar que puede haber más o menos de 30 productos del rubro 3.
Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignorar el resto.
(d) Ordenar, por precio, los elementos del vector generado en (c) utilizando alguno de los dos métodos vistos en la teoría.
(e) Mostrar los precios del vector resultante del inciso (d).
(f) Calcular el promedio de los precios del vector resultante del inciso (d).}

program TP1_E4;
{$codepage UTF8}
uses crt;
const
  rubro_ini=1; rubro_fin=8;
  precio_salida=0.0;
  productos_rubro3_total=30;
type
  t_rubro=rubro_ini..rubro_fin;
  t_registro_producto1=record
    codigo: int16;
    rubro: t_rubro;
    precio: real;
  end;
  t_registro_producto2=record
    codigo: int16;
    precio: real;
  end;
  t_lista_productos=^t_nodo_productos;
  t_nodo_productos=record
    ele: t_registro_producto2;
    sig: t_lista_productos;
  end;
  t_vector_productos1=array[t_rubro] of t_lista_productos;
  t_vector_productos2=array[1..productos_rubro3_total] of t_registro_producto2;
procedure inicializar_vector_productos1(var vector_productos1: t_vector_productos1);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
    vector_productos1[i]:=nil;
end;
procedure leer_producto(var registro_producto1: t_registro_producto1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_producto1.precio:=precio_salida
  else
    registro_producto1.precio:=1+random(100);
  if (registro_producto1.precio<>precio_salida) then
  begin
    registro_producto1.codigo:=1+random(high(int16));
    registro_producto1.rubro:=rubro_ini+random(rubro_fin);
  end;
end;
procedure cargar_registro_producto2(var registro_producto2: t_registro_producto2; registro_producto1: t_registro_producto1);
begin
  registro_producto2.codigo:=registro_producto1.codigo;
  registro_producto2.precio:=registro_producto1.precio;
end;
procedure agregar_ordenado_lista_productos(var lista_productos: t_lista_productos; registro_producto1: t_registro_producto1);
var
  anterior, actual, nuevo: t_lista_productos;
begin
  new(nuevo);
  cargar_registro_producto2(nuevo^.ele,registro_producto1);
  anterior:=lista_productos; actual:=lista_productos;
  while ((actual<>nil) and (actual^.ele.codigo<nuevo^.ele.codigo)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_productos) then
    lista_productos:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure cargar_vector_productos1(var vector_productos1: t_vector_productos1);
var
  registro_producto1: t_registro_producto1;
begin
  leer_producto(registro_producto1);
  while (registro_producto1.precio<>precio_salida) do
  begin
    agregar_ordenado_lista_productos(vector_productos1[registro_producto1.rubro],registro_producto1);
    leer_producto(registro_producto1);
  end;
end;
procedure imprimir_registro_producto2(registro_producto2: t_registro_producto2; rubro: t_rubro; producto: int16);
begin
  textcolor(green); write('El código de producto del producto '); textcolor(yellow); write(producto); textcolor(green); write(' del código de rubro '); textcolor(yellow); write(rubro); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto2.codigo);
  textcolor(green); write('El precio del producto '); textcolor(yellow); write(producto); textcolor(green); write(' del código de rubro '); textcolor(yellow); write(rubro); textcolor(green); write(' es '); textcolor(red); writeln(registro_producto2.precio:0:2);
end;
procedure imprimir_lista_productos(lista_productos: t_lista_productos; rubro: t_rubro);
var
  i: int16;
begin
  i:=0;
  while (lista_productos<>nil) do
  begin
    i:=i+1;
    imprimir_registro_producto2(lista_productos^.ele,rubro,i);
    lista_productos:=lista_productos^.sig;
  end;
end;
procedure imprimir_vector_productos1(vector_productos1: t_vector_productos1);
var
  i: t_rubro;
begin
  for i:= rubro_ini to rubro_fin do
  begin
    textcolor(green); write('La información de los productos del rubro '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_lista_productos(vector_productos1[i],i);
    writeln();
  end;
end;
procedure cargar_vector_productos2(var vector_productos2: t_vector_productos2; var productos_rubro3: int8; lista_productos: t_lista_productos);
begin
  while ((lista_productos<>nil) and (productos_rubro3<productos_rubro3_total)) do
  begin
    productos_rubro3:=productos_rubro3+1;
    vector_productos2[productos_rubro3]:=lista_productos^.ele;
    lista_productos:=lista_productos^.sig;
  end;
end;
procedure imprimir_vector_productos2(vector_productos2: t_vector_productos2; productos_rubro3: int8);
var
  i: int8;
begin
  for i:= 1 to productos_rubro3 do
  begin
    textcolor(green); write('La información del producto '); textcolor(yellow); write(i); textcolor(green); writeln(' del rubro 3 son:');
    imprimir_registro_producto2(vector_productos2[i],3,i);
    writeln();
  end;
end;
procedure ordenar_vector_productos2(var vector_productos2: t_vector_productos2; productos_rubro3: int8);
var
  item: t_registro_producto2;
  i, j, k: int8;
begin
  for i:= 1 to (productos_rubro3-1) do
  begin
    k:=i;
    for j:= (i+1) to productos_rubro3 do
      if (vector_productos2[j].precio<vector_productos2[k].precio) then
        k:=j;
    item:=vector_productos2[k];
    vector_productos2[k]:=vector_productos2[i];
    vector_productos2[i]:=item;
  end;
end;
function calcular_promedio_vector_productos2(vector_productos2: t_vector_productos2; productos_rubro3: int8): real;
var
  i: int8;
  precio_total: real;
begin
  precio_total:=0;
  for i:= 1 to productos_rubro3 do
    precio_total:=precio_total+vector_productos2[i].precio;
  calcular_promedio_vector_productos2:=precio_total/productos_rubro3;
end;
var
  vector_productos1: t_vector_productos1;
  vector_productos2: t_vector_productos2;
  productos_rubro3: int8;
begin
  randomize;
  productos_rubro3:=0;
  inicializar_vector_productos1(vector_productos1);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_productos1(vector_productos1);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  imprimir_vector_productos1(vector_productos1);
  writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
  cargar_vector_productos2(vector_productos2,productos_rubro3,vector_productos1[3]);
  if (productos_rubro3>0) then
  begin
    imprimir_vector_productos2(vector_productos2,productos_rubro3);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    ordenar_vector_productos2(vector_productos2,productos_rubro3);
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    imprimir_vector_productos2(vector_productos2,productos_rubro3);
    writeln(); textcolor(red); writeln('INCISO (f):'); writeln();
    textcolor(green); write('El promedio de los precios del vector_productos2 es '); textcolor(red); write(calcular_promedio_vector_productos2(vector_productos2,productos_rubro3):0:2);
  end;
end.