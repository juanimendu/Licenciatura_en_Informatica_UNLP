{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 4}
{Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo, se lee código, DNI de la persona, año y tipo de reclamo.
La lectura finaliza con el código de igual a -1. Se pide:
(a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI, se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
(b) Un módulo que reciba la estructura generada en (a) y un DNI y retorne la cantidad de reclamos efectuados por ese DNI.
(c) Un módulo que reciba la estructura generada en (a) y dos DNI y retorne la cantidad de reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
(d) Un módulo que reciba la estructura generada en (a) y un año y retorne los códigos de los reclamos realizados en el año recibido.}

program TP5_E4;
{$codepage UTF8}
uses crt;
const
  anio_ini=2000; anio_fin=2023;
  codigo_salida=-1;
type
  t_anio=anio_ini..anio_fin;
  t_registro_reclamo1=record
    codigo: int16;
    dni: int8;
    anio: t_anio;
    tipo: string;
  end;
  t_registro_reclamo2=record
    codigo: int16;
    anio: t_anio;
    tipo: string;
  end;
  t_lista_reclamos=^t_nodo_reclamos;
  t_nodo_reclamos=record
    ele: t_registro_reclamo2;
    sig: t_lista_reclamos;
  end;
  t_registro_dni=record
    dni: int8;
    reclamos: t_lista_reclamos;
    cantidad: int16;
  end;
  t_abb_dnis=^t_nodo_abb_dnis;
  t_nodo_abb_dnis=record
    ele: t_registro_dni;
    hi: t_abb_dnis;
    hd: t_abb_dnis;
  end;
  t_lista_codigos=^t_nodo_codigos2;
  t_nodo_codigos2=record
    ele: int16;
    sig: t_lista_codigos;
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
procedure leer_reclamo(var registro_reclamo1: t_registro_reclamo1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_reclamo1.codigo:=codigo_salida
  else
    registro_reclamo1.codigo:=1+random(high(int16));
  if (registro_reclamo1.codigo<>codigo_salida) then
  begin
    registro_reclamo1.dni:=1+random(high(int8));
    registro_reclamo1.anio:=anio_ini+random(anio_fin-anio_ini+1);
    registro_reclamo1.tipo:=random_string(5+random(6));
  end;
end;
procedure cargar_registro_reclamo2(var registro_reclamo2: t_registro_reclamo2; registro_reclamo1: t_registro_reclamo1);
begin
  registro_reclamo2.codigo:=registro_reclamo1.codigo;
  registro_reclamo2.anio:=registro_reclamo1.anio;
  registro_reclamo2.tipo:=registro_reclamo1.tipo;
end;
procedure agregar_adelante_lista_reclamos(var lista_reclamos: t_lista_reclamos; registro_reclamo1: t_registro_reclamo1);
var
  nuevo: t_lista_reclamos;
begin
  new(nuevo);
  cargar_registro_reclamo2(nuevo^.ele,registro_reclamo1);
  nuevo^.sig:=lista_reclamos;
  lista_reclamos:=nuevo;
end;
procedure cargar_registro_dni(var registro_dni: t_registro_dni; registro_reclamo1: t_registro_reclamo1);
begin
  registro_dni.dni:=registro_reclamo1.dni;
  registro_dni.reclamos:=nil;
  agregar_adelante_lista_reclamos(registro_dni.reclamos,registro_reclamo1);
  registro_dni.cantidad:=1;
end;
procedure agregar_abb_dnis(var abb_dnis: t_abb_dnis; registro_reclamo1: t_registro_reclamo1);
begin
  if (abb_dnis=nil) then
  begin
    new(abb_dnis);
    cargar_registro_dni(abb_dnis^.ele,registro_reclamo1);
    abb_dnis^.hi:=nil;
    abb_dnis^.hd:=nil;
  end
  else
    if (registro_reclamo1.dni=abb_dnis^.ele.dni) then
    begin
      agregar_adelante_lista_reclamos(abb_dnis^.ele.reclamos,registro_reclamo1);
      abb_dnis^.ele.cantidad:=abb_dnis^.ele.cantidad+1;
    end
    else if (registro_reclamo1.dni<abb_dnis^.ele.dni) then
      agregar_abb_dnis(abb_dnis^.hi,registro_reclamo1)
    else
      agregar_abb_dnis(abb_dnis^.hd,registro_reclamo1);
end;
procedure cargar_abb_dnis(var abb_dnis: t_abb_dnis);
var
  registro_reclamo1: t_registro_reclamo1;
begin
  leer_reclamo(registro_reclamo1);
  while (registro_reclamo1.codigo<>codigo_salida) do
  begin
    agregar_abb_dnis(abb_dnis,registro_reclamo1);
    leer_reclamo(registro_reclamo1);
  end;
end;
procedure imprimir_registro_reclamo2(registro_reclamo2: t_registro_reclamo2; dni: int8; reclamo: int16);
begin
  textcolor(green); write('El código de reclamo del reclamo '); textcolor(yellow); write(reclamo); textcolor(green); write(' del DNI '); textcolor(yellow); write(dni); textcolor(green); write(' es '); textcolor(red); writeln(registro_reclamo2.codigo);
  textcolor(green); write('El año del reclamo '); textcolor(yellow); write(reclamo); textcolor(green); write(' del DNI '); textcolor(yellow); write(dni); textcolor(green); write(' es '); textcolor(red); writeln(registro_reclamo2.anio);
  textcolor(green); write('El tipo de reclamo del reclamo '); textcolor(yellow); write(reclamo); textcolor(green); write(' del DNI '); textcolor(yellow); write(dni); textcolor(green); write(' es '); textcolor(red); writeln(registro_reclamo2.tipo);
end;
procedure imprimir_lista_reclamos(lista_reclamos: t_lista_reclamos; dni: int8);
var
  i: int16;
begin
  i:=0;
  while (lista_reclamos<>nil) do
  begin
    i:=i+1;
    imprimir_registro_reclamo2(lista_reclamos^.ele,dni,i);
    lista_reclamos:=lista_reclamos^.sig;
  end;
end;
procedure imprimir_registro_dni(registro_dni: t_registro_dni);
begin
  textcolor(green); write('El DNI de la persona es '); textcolor(red); writeln(registro_dni.dni);
  textcolor(green); write('La cantidad total de reclamos que realizó la persona es '); textcolor(red); writeln(registro_dni.cantidad);
  imprimir_lista_reclamos(registro_dni.reclamos,registro_dni.dni);
  writeln();
end;
procedure imprimir_abb_dnis(abb_dnis: t_abb_dnis);
begin
  if (abb_dnis<>nil) then
  begin
    imprimir_abb_dnis(abb_dnis^.hi);
    imprimir_registro_dni(abb_dnis^.ele);
    imprimir_abb_dnis(abb_dnis^.hd);
  end;
end;
function contar_reclamos1(abb_dnis: t_abb_dnis; dni: int8): int16;
begin
  if (abb_dnis=nil) then
    contar_reclamos1:=0
  else
    if (dni=abb_dnis^.ele.dni) then
      contar_reclamos1:=abb_dnis^.ele.cantidad
    else if (dni<abb_dnis^.ele.dni) then
      contar_reclamos1:=contar_reclamos1(abb_dnis^.hi,dni)
    else
      contar_reclamos1:=contar_reclamos1(abb_dnis^.hd,dni);
end;
procedure verificar_dnis(var dni1, dni2: int8);
var
  aux: int8;
begin
  if (dni1>dni2) then
  begin
    aux:=dni1;
    dni1:=dni2;
    dni2:=aux;
  end;
end;
function contar_reclamos2(abb_dnis: t_abb_dnis; dni1, dni2: int8): int16;
begin
  if (abb_dnis=nil) then
    contar_reclamos2:=0
  else
    if (dni1>=abb_dnis^.ele.dni) then
      contar_reclamos2:=contar_reclamos2(abb_dnis^.hd,dni1,dni2)
    else if (dni2<=abb_dnis^.ele.dni) then
      contar_reclamos2:=contar_reclamos2(abb_dnis^.hi,dni1,dni2)
    else
      contar_reclamos2:=contar_reclamos2(abb_dnis^.hi,dni1,dni2)+contar_reclamos2(abb_dnis^.hd,dni1,dni2)+1;
end;
procedure agregar_adelante_lista_codigos(var lista_codigos: t_lista_codigos; codigo: int16);
var
  nuevo: t_lista_codigos;
begin
  new(nuevo);
  nuevo^.ele:=codigo;
  nuevo^.sig:=lista_codigos;
  lista_codigos:=nuevo;
end;
procedure recorrer_lista_reclamos(var lista_codigos: t_lista_codigos; lista_reclamos: t_lista_reclamos; anio: t_anio);
begin
  while (lista_reclamos<>nil) do
  begin
    if (anio=lista_reclamos^.ele.anio) then
      agregar_adelante_lista_codigos(lista_codigos,lista_reclamos^.ele.codigo);
    lista_reclamos:=lista_reclamos^.sig;
  end;
end;
procedure cargar_lista_codigos(var lista_codigos: t_lista_codigos; abb_dnis: t_abb_dnis; anio: t_anio);
begin
  if (abb_dnis<>nil) then
  begin
    cargar_lista_codigos(lista_codigos,abb_dnis^.hd,anio);
    recorrer_lista_reclamos(lista_codigos,abb_dnis^.ele.reclamos,anio);
    cargar_lista_codigos(lista_codigos,abb_dnis^.hi,anio);
  end;
end;
procedure imprimir_lista_codigos(lista_codigos: t_lista_codigos; anio: t_anio);
var
  i: int16;
begin
  i:=0;
  while (lista_codigos<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('Código de reclamo '); textcolor(yellow); write(i); textcolor(green); write(' del año '); textcolor(yellow); write(anio); textcolor(green); write(': '); textcolor(red); writeln(lista_codigos^.ele);
    lista_codigos:=lista_codigos^.sig;
  end;
end;
var
  lista_codigos: t_lista_codigos;
  abb_dnis: t_abb_dnis;
  anio: t_anio;
  dni, dni1, dni2: int8;
begin
  randomize;
  abb_dnis:=nil;
  lista_codigos:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abb_dnis(abb_dnis);
  if (abb_dnis<>nil) then
  begin
    imprimir_abb_dnis(abb_dnis);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    dni:=1+random(high(int8));
    textcolor(green); write('La cantidad de reclamos del DNI '); textcolor(yellow); write(dni); textcolor(green); write(' es '); textcolor(red); writeln(contar_reclamos1(abb_dnis,dni));
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    dni1:=1+random(high(int8)); dni2:=1+random(high(int8));
    verificar_dnis(dni1,dni2);
    textcolor(green); write('La cantidad de reclamos en el abb cuyo DNI se encuentra entre '); textcolor(yellow); write(dni1); textcolor(green); write(' y '); textcolor(yellow); write(dni2); textcolor(green); write(' es '); textcolor(red); writeln(contar_reclamos2(abb_dnis,dni1,dni2));
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    anio:=anio_ini+random(anio_fin-anio_ini+1);
    cargar_lista_codigos(lista_codigos,abb_dnis,anio);
    if (lista_codigos<>nil) then
      imprimir_lista_codigos(lista_codigos,anio);
  end;
end.