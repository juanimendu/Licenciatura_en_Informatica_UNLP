{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 1}
{Se desea procesar la información de las ventas de productos de un comercio (como máximo, 50).
Implementar un programa que invoque los siguientes módulos:
(a) Un módulo que retorne la información de las ventas en un vector. De cada venta, se conoce el día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo, 99 unidades).
El código debe generarse automáticamente (random) y la cantidad se debe leer. El ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
(b) Un módulo que muestre el contenido del vector resultante del inciso (a).
(c) Un módulo que ordene el vector de ventas por código.
(d) Un módulo que muestre el contenido del vector resultante del inciso (c).
(e) Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos valores que se ingresan como parámetros.
(f) Un módulo que muestre el contenido del vector resultante del inciso (e).
(g) Un módulo que retorne la información (ordenada por código de producto de menor a mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
(h) Un módulo que muestre la información obtenida en el inciso (g).}

program TP1_E1;
{$codepage UTF8}
uses crt;
const
  ventas_total=50;
  dia_ini=1; dia_fin=31;
  codigo_ini=1; codigo_fin=15;
  cantidad_total=99;
  dia_salida=0;
type
  t_venta=1..ventas_total;
  t_codigo=codigo_ini..codigo_fin;
  t_cantidad=1..cantidad_total;
  t_registro_venta=record
    dia: int8;
    codigo: t_codigo;
    cantidad: t_cantidad;
  end;
  t_vector_ventas=array[t_venta] of t_registro_venta;
  t_vector_cantidades=array[t_codigo] of int16;
procedure leer_venta(var registro_venta: t_registro_venta);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_venta.dia:=dia_salida
  else
    registro_venta.dia:=dia_ini+random(dia_fin);
  if (registro_venta.dia<>dia_salida) then
  begin
    registro_venta.codigo:=codigo_ini+random(codigo_fin);
    registro_venta.cantidad:=1+random(cantidad_total);
  end;
end;
procedure cargar_vector_ventas(var vector_ventas: t_vector_ventas; var ventas: int8);
var
  registro_venta: t_registro_venta;
begin
  leer_venta(registro_venta);
  while ((registro_venta.dia<>dia_salida) and (ventas<ventas_total)) do
  begin
    ventas:=ventas+1;
    vector_ventas[ventas]:=registro_venta;
    leer_venta(registro_venta);
  end;
end;
procedure imprimir_registro_venta(registro_venta: t_registro_venta; venta: t_venta);
begin
  textcolor(green); write('El día de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.dia);
  textcolor(green); write('El código de producto de la venta'); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.codigo);
  textcolor(green); write('La cantidad vendida del producto de la venta '); textcolor(yellow); write(venta); textcolor(green); write(' es '); textcolor(red); writeln(registro_venta.cantidad);
end;
procedure imprimir_vector_ventas(vector_ventas: t_vector_ventas; ventas: int8);
var
  i: t_venta;
begin
  for i:= 1 to ventas do
  begin
    textcolor(green); write('La información de la venta '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_venta(vector_ventas[i],i);
    writeln();
  end;
end;
procedure ordenar_vector_ventas(var vector_ventas: t_vector_ventas; ventas: int8);
var
  item: t_registro_venta;
  i, j, k: t_venta;
begin
  for i:= 1 to (ventas-1) do
  begin
    k:=i;
    for j:= (i+1) to ventas do
      if (vector_ventas[j].codigo<vector_ventas[k].codigo) then
        k:=j;
    item:=vector_ventas[k];
    vector_ventas[k]:=vector_ventas[i];
    vector_ventas[i]:=item;
  end;
end;
procedure verificar_codigos(var codigo1, codigo2: t_codigo);
var
  aux: t_codigo;
begin
  if (codigo1>codigo2) then
  begin
    aux:=codigo1;
    codigo1:=codigo2;
    codigo2:=aux;
  end;
end;
procedure eliminar_vector_ventas(var vector_ventas: t_vector_ventas; var ventas: int8; codigo1, codigo2: t_codigo);
var
  i, i_izq, i_der, salto: t_codigo;
begin
  i:=1;
  while ((i<ventas) and (vector_ventas[i].codigo<=codigo1)) do
    i:=i+1;
  i_izq:=i;
  while ((i<ventas) and (vector_ventas[i].codigo<codigo2)) do
    i:=i+1;
  i_der:=i;
  salto:=i_der-i_izq;
  while (i_izq+salto<=ventas) do
  begin
    vector_ventas[i_izq]:=vector_ventas[i_izq+salto]; 
    i_izq:=i_izq+1;
  end;
  ventas:=ventas-salto;
end;
procedure inicializar_vector_cantidades(var vector_cantidades: t_vector_cantidades);
var
  i: t_codigo;
begin
  for i:= codigo_ini to codigo_fin do
  begin
    vector_cantidades[i]:=0;
  end;
end;
procedure cargar_vector_cantidades(var vector_cantidades: t_vector_cantidades; vector_ventas: t_vector_ventas; ventas: int8);
var
  i: t_venta;
  codigo: t_codigo;
begin
  for i:= 1 to ventas do
  begin
    codigo:=vector_ventas[i].codigo;
    if (codigo mod 2=0) then
      vector_cantidades[codigo]:=vector_cantidades[codigo]+vector_ventas[i].cantidad;
  end;
end;
procedure imprimir_vector_cantidades(vector_cantidades: t_vector_cantidades);
var
  i: t_codigo;
begin
  for i:= codigo_ini to codigo_fin do
  begin
    textcolor(green); write('La cantidad total de productos vendidos del código de producto '); textcolor(yellow); write(i); textcolor(green); write(' es '); textcolor(red); writeln(vector_cantidades[i]);
  end;
end;
var
  vector_ventas: t_vector_ventas;
  vector_cantidades: t_vector_cantidades;
  codigo1, codigo2: t_codigo;
  ventas: int8;
begin
  randomize;
  ventas:=0;
  inicializar_vector_cantidades(vector_cantidades);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_ventas(vector_ventas,ventas);
  if (ventas<>0) then
  begin
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    imprimir_vector_ventas(vector_ventas,ventas);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    ordenar_vector_ventas(vector_ventas,ventas);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    imprimir_vector_ventas(vector_ventas,ventas);
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    codigo1:=codigo_ini+random(codigo_fin); codigo2:=codigo_ini+random(codigo_fin);
    verificar_codigos(codigo1,codigo2);
    eliminar_vector_ventas(vector_ventas,ventas,codigo1,codigo2);
    if (ventas<>0) then
    begin
      writeln(); textcolor(red); writeln('INCISO (f):'); writeln();
      imprimir_vector_ventas(vector_ventas,ventas);
      writeln(); textcolor(red); writeln('INCISO (g):'); writeln();
      cargar_vector_cantidades(vector_cantidades,vector_ventas,ventas);
      writeln(); textcolor(red); writeln('INCISO (h):'); writeln();
      imprimir_vector_cantidades(vector_cantidades);
    end;
  end;
end.