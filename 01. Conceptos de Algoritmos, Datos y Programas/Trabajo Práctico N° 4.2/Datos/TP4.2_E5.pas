{TRABAJO PRÁCTICO N° 4.2}
{EJERCICIO 5}
{La empresa Amazon Web Services (AWS) dispone de la información de sus 500 clientes monotributistas más grandes del país.
De cada cliente, conoce la fecha de firma del contrato con AWS, la categoría del monotributo (entre la A y la F), el código de la ciudad donde se encuentran las oficinas (entre 1 y 2400) y el monto mensual acordado en el contrato.
La información se ingresa ordenada por fecha de firma de contrato (los más antiguos primero, los más recientes últimos).
Realizar un programa que lea y almacene la información de los clientes en una estructura de tipo vector.
Una vez almacenados los datos, procesar dicha estructura para obtener:
•	Cantidad de contratos por cada mes y cada año, y año en que se firmó la mayor cantidad de contratos.
•	Cantidad de clientes para cada categoría de monotributo.
•	Código de las 10 ciudades con mayor cantidad de clientes.
•	Cantidad de clientes que superan, mensualmente, el monto promedio entre todos los clientes.}

program TP4_E5;
{$codepage UTF8}
uses crt;
const
  clientes_total=500;
  ciudades_total=2400;
  mes_ini=1; mes_fin=12;
  anio_ini=2001; anio_fin=2020;
  cat_ini='A'; cat_fin='F';
  ciudad_ini=1; ciudad_fin=10;
type
  t_cliente=1..clientes_total;
  t_mes=mes_ini..mes_fin;
  t_anio=anio_ini..anio_fin;
  t_categoria=cat_ini..cat_fin;
  t_ciudad1=1..ciudades_total;
  t_ciudad2=ciudad_ini..ciudad_fin;
  t_registro_cliente=record
    fecha: int16;
    categoria: t_categoria;
    ciudad: t_ciudad1;
    monto: real;
  end;
  t_registro_ciudad=record
    ciudad: int16;
    clientes: int16;
  end;
  t_vector_clientes=array[t_cliente] of t_registro_cliente;
  t_vector_meses=array[t_mes] of int16;
  t_vector_anios=array[t_anio] of int16;
  t_vector_categorias=array[t_categoria] of int16;
  t_vector_ciudades1=array[t_ciudad1] of int16;
  t_vector_ciudades2=array[t_ciudad2] of t_registro_ciudad;
procedure inicializar_vectores(var vector_meses1, vector_meses2: t_vector_meses; var vector_anios: t_vector_anios; var vector_categorias: t_vector_categorias; var vector_ciudades1: t_vector_ciudades1; var vector_ciudades2: t_vector_ciudades2);
var
  i: t_mes;
  j: t_anio;
  k: t_categoria;
  l: t_ciudad1;
  m: t_ciudad2;
begin
  for i:= mes_ini to mes_fin do
  begin
    vector_meses1[i]:=0;
    vector_meses2[i]:=0;
  end;
  for j:= anio_ini to anio_fin do
    vector_anios[j]:=0;
  for k:= cat_ini to cat_fin do
    vector_categorias[k]:=0;
  for l:= 1 to ciudades_total do
    vector_ciudades1[l]:=0;
  for m:= ciudad_ini to ciudad_fin do
  begin
    vector_ciudades2[m].ciudad:=0;
    vector_ciudades2[m].clientes:=0;
  end;
end;
procedure leer_cliente(var registro_cliente: t_registro_cliente);
begin
  registro_cliente.fecha:=(anio_ini*12-1)+random((anio_fin-anio_ini+1)*12);
  registro_cliente.categoria:=chr(ord(cat_ini)+random(6));
  registro_cliente.ciudad:=1+random(ciudades_total);
  registro_cliente.monto:=1+random(100);
end;
function buscar_ordenado_vector_clientes(vector_clientes: t_vector_clientes; clientes, fecha: int16): int16;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=clientes) and (vector_clientes[pos].fecha<fecha)) do
    pos:=pos+1;
  buscar_ordenado_vector_clientes:=pos;
end;
procedure insertar_vector_clientes(var vector_clientes: t_vector_clientes; var clientes: int16; registro_cliente: t_registro_cliente; pos: int16);
var
  i: t_cliente;
begin
  if ((clientes<clientes_total) and ((pos>=1) and (pos<=clientes))) then
    for i:= clientes downto pos do
      vector_clientes[i+1]:=vector_clientes[i];
  if ((clientes<clientes_total) and ((pos>=1) and (pos<=clientes+1))) then
  begin
    vector_clientes[pos]:=registro_cliente;
    clientes:=clientes+1;
  end;
end;
procedure cargar_vector_clientes(var vector_clientes: t_vector_clientes; var monto_prom: real);
var
  registro_cliente: t_registro_cliente;
  i: t_cliente;
  clientes, pos: int16;
  monto_total: real;
begin
  clientes:=0; pos:=0;
  monto_total:=0;
  for i:= 1 to clientes_total do
  begin
    leer_cliente(registro_cliente);
    pos:=buscar_ordenado_vector_clientes(vector_clientes,clientes,registro_cliente.fecha);
    insertar_vector_clientes(vector_clientes,clientes,registro_cliente,pos);
    monto_total:=monto_total+vector_clientes[i].monto;
  end;
  monto_prom:=monto_total/clientes_total;
end;
procedure agregar_vector_meses1(fecha: int16; var vector_meses1: t_vector_meses);
begin
  vector_meses1[(fecha mod 12)+1]:=vector_meses1[(fecha mod 12)+1]+1;
end;
procedure agregar_vector_anios(fecha: int16; var vector_anios: t_vector_anios);
begin
  vector_anios[fecha div 12]:=vector_anios[fecha div 12]+1;
end;
procedure agregar_vector_categorias(categoria: t_categoria; var vector_categorias: t_vector_categorias);
begin
  vector_categorias[categoria]:=vector_categorias[categoria]+1;
end;
procedure agregar_vector_ciudades1(ciudad: t_ciudad1; var vector_ciudades1: t_vector_ciudades1);
begin
  vector_ciudades1[ciudad]:=vector_ciudades1[ciudad]+1;
end;
procedure agregar_vector_meses2(fecha: int16; monto, monto_prom: real; var vector_meses2: t_vector_meses);
begin
  if (monto>monto_prom) then
    vector_meses2[(fecha mod 12)+1]:=vector_meses2[(fecha mod 12)+1]+1;
end;
procedure actualizar_maximo(vector_anios: t_vector_anios; var anio_max: int16);
var
  i: t_anio;
  num_max: int16;
begin
  num_max:=low(int16);
  for i:= anio_ini to anio_fin do
    if (vector_anios[i]>num_max) then
    begin
      num_max:=vector_anios[i];
      anio_max:=i;
    end;
end;
function buscar_ordenado_vector_ciudades2(vector_ciudades2: t_vector_ciudades2; ciudades, clientes: int16): int16;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=ciudades) and (vector_ciudades2[pos].clientes>clientes)) do
    pos:=pos+1;
  buscar_ordenado_vector_ciudades2:=pos;
end;
procedure insertar_vector_ciudades2(var vector_ciudades2: t_vector_ciudades2; var ciudades: int16; registro_ciudad: t_registro_ciudad; pos: int16);
var
  i: t_ciudad2;
begin
  if ((ciudades<ciudad_fin) and ((pos>1) and (pos<=ciudades))) then
    for i:= ciudades downto pos do
      vector_ciudades2[i+1]:=vector_ciudades2[i];
  if ((ciudades<ciudad_fin) and ((pos>1) and (pos<=ciudades+1))) then
  begin
    vector_ciudades2[pos]:=registro_ciudad;
    ciudades:=ciudades+1;
  end;
end;
procedure actualizar_maximos(vector_ciudades1: t_vector_ciudades1; var vector_ciudades2: t_vector_ciudades2);
var
  registro_ciudad: t_registro_ciudad;
  i: t_ciudad1;
  ciudades, pos: int16; 
begin
  ciudades:=0; pos:=0;
  for i:= 1 to ciudades_total do
  begin
    pos:=buscar_ordenado_vector_ciudades2(vector_ciudades2,ciudades,vector_ciudades1[i]);
    if (pos<=ciudad_fin) then
    begin
      if (ciudades=ciudad_fin) then
        ciudades:=ciudades-1;
      registro_ciudad.ciudad:=i;
      registro_ciudad.clientes:=vector_ciudades1[i];
      insertar_vector_ciudades2(vector_ciudades2,ciudades,registro_ciudad,pos);
    end;
  end;
end;
procedure procesar_vector_clientes(vector_clientes: t_vector_clientes; monto_prom: real; var vector_meses1, vector_meses2: t_vector_meses; var vector_anios: t_vector_anios; var anio_max: int16; var vector_categorias: t_vector_categorias; var vector_ciudades1: t_vector_ciudades1; var vector_ciudades2: t_vector_ciudades2);
var
  i: t_cliente;
begin
  for i:= 1 to clientes_total do
  begin
    agregar_vector_meses1(vector_clientes[i].fecha,vector_meses1);
    agregar_vector_anios(vector_clientes[i].fecha,vector_anios);
    agregar_vector_categorias(vector_clientes[i].categoria,vector_categorias);
    agregar_vector_ciudades1(vector_clientes[i].ciudad,vector_ciudades1);
    agregar_vector_meses2(vector_clientes[i].fecha,vector_clientes[i].monto,monto_prom,vector_meses2);
  end;
  actualizar_maximo(vector_anios,anio_max);
  actualizar_maximos(vector_ciudades1,vector_ciudades2);
end;
procedure imprimir_vector_meses(vector_meses: t_vector_meses);
var
  i: t_mes;
begin
  for i:= mes_ini to mes_fin do
  begin
    textcolor(green); write('Mes ',i,': '); textcolor(red); writeln(vector_meses[i]);
  end;
end;
procedure imprimir_vector_anios(vector_anios: t_vector_anios);
var
  i: t_anio;
begin
  for i:= anio_ini to anio_fin do
  begin
    textcolor(green); write('Año ',i,': '); textcolor(red); writeln(vector_anios[i]);
  end;
end;
procedure imprimir_vector_categorias(vector_categorias: t_vector_categorias);
var
  i: t_categoria;
begin
  for i:= cat_ini to cat_fin do
  begin
    textcolor(green); write('Categoría ',i,': '); textcolor(red); writeln(vector_categorias[i]);
  end;
end;
procedure imprimir_vector_ciudades(vector_ciudades: t_vector_ciudades2);
var
  i: t_ciudad2;
begin
  for i:= ciudad_ini to ciudad_fin do
  begin
    textcolor(green); write('Ciudad ',i,': '); textcolor(red); writeln(vector_ciudades[i].ciudad);
  end;
end;
var
  vector_clientes: t_vector_clientes;
  vector_meses1, vector_meses2: t_vector_meses;
  vector_anios: t_vector_anios;
  vector_categorias: t_vector_categorias;
  vector_ciudades1: t_vector_ciudades1;
  vector_ciudades2: t_vector_ciudades2;
  anio_max: int16;
  monto_prom: real;
begin
  randomize;
  anio_max:=0;
  monto_prom:=0;
  inicializar_vectores(vector_meses1,vector_meses2,vector_anios,vector_categorias,vector_ciudades1,vector_ciudades2);
  cargar_vector_clientes(vector_clientes,monto_prom);
  procesar_vector_clientes(vector_clientes,monto_prom,vector_meses1,vector_meses2,vector_anios,anio_max,vector_categorias,vector_ciudades1,vector_ciudades2);
  writeln(); textcolor(red); writeln('La cantidad de contratos para cada mes es '); writeln();
  imprimir_vector_meses(vector_meses1);
  writeln(); textcolor(red); writeln('La cantidad de contratos para cada año es '); writeln();
  imprimir_vector_anios(vector_anios);
  writeln(); textcolor(red); write('El año en que se firmó la mayor cantidad de contratos es '); textcolor(red); writeln(anio_max); writeln();
  writeln(); textcolor(red); writeln('La cantidad de clientes para cada categoría de monotributo es '); writeln();
  imprimir_vector_categorias(vector_categorias);
  writeln(); textcolor(red); writeln('El código de las 10 ciudades con mayor cantidad de clientes es '); writeln();
  imprimir_vector_ciudades(vector_ciudades2);
  writeln(); textcolor(red); writeln('La cantidad de clientes que superan, mensualmente, el monto promedio entre todos los clientes es '); writeln();
  imprimir_vector_meses(vector_meses2);
end.