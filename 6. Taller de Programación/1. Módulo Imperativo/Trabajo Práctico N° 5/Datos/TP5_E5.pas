{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 5}
{Realizar el inciso (a) del ejercicio anterior, pero sabiendo que todos los reclamos de un mismo DNI se leen de forma consecutiva (no significa que vengan ordenados los DNI).}

program TP5_E5;
{$codepage UTF8}
uses crt;
const
  anio_ini=2000; anio_fin=2023;
  codigo_salida=-1;
type
  t_anio=anio_ini..anio_fin;
  t_registro_reclamo1=record
    codigo: int16;
    dni: int32;
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
    dni: int32;
    reclamos: t_lista_reclamos;
    cantidad: int16;
  end;
  t_abb_dnis=^t_nodo_abb_dnis;
  t_nodo_abb_dnis=record
    ele: t_registro_dni;
    hi: t_abb_dnis;
    hd: t_abb_dnis;
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
procedure leer_reclamo(var registro_reclamo1: t_registro_reclamo1; dni: int32);
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
    i:=random(2);
    if (i=0) then
      registro_reclamo1.dni:=dni
    else
      registro_reclamo1.dni:=10000000+random(40000001);
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
procedure agregar_abb_dnis(var abb_dnis: t_abb_dnis; registro_dni: t_registro_dni);
begin
  if (abb_dnis=nil) then
  begin
    new(abb_dnis);
    abb_dnis^.ele:=registro_dni;
    abb_dnis^.hi:=nil;
    abb_dnis^.hd:=nil;
  end
  else
    if (registro_dni.dni<abb_dnis^.ele.dni) then
      agregar_abb_dnis(abb_dnis^.hi,registro_dni)
    else if (registro_dni.dni>abb_dnis^.ele.dni) then
      agregar_abb_dnis(abb_dnis^.hd,registro_dni);
end;
procedure cargar_abb_dnis(var abb_dnis: t_abb_dnis);
var
  registro_reclamo1: t_registro_reclamo1;
  registro_dni: t_registro_dni;
begin
  leer_reclamo(registro_reclamo1,10000000+random(40000001));
  while (registro_reclamo1.codigo<>codigo_salida) do
  begin
    registro_dni.dni:=registro_reclamo1.dni;
    registro_dni.reclamos:=nil;
    registro_dni.cantidad:=0;
    while ((registro_reclamo1.codigo<>codigo_salida) and (registro_reclamo1.dni=registro_dni.dni)) do
    begin
      agregar_adelante_lista_reclamos(registro_dni.reclamos,registro_reclamo1);
      registro_dni.cantidad:=registro_dni.cantidad+1;
      leer_reclamo(registro_reclamo1,registro_dni.dni);
    end;
    agregar_abb_dnis(abb_dnis,registro_dni);
  end;
end;
procedure imprimir_registro_reclamo2(registro_reclamo2: t_registro_reclamo2; dni: int32; reclamo: int16);
begin
  textcolor(green); write('El código de reclamo del reclamo '); textcolor(yellow); write(reclamo); textcolor(green); write(' del DNI '); textcolor(yellow); write(dni); textcolor(green); write(' es '); textcolor(red); writeln(registro_reclamo2.codigo);
  textcolor(green); write('El año del reclamo '); textcolor(yellow); write(reclamo); textcolor(green); write(' del DNI '); textcolor(yellow); write(dni); textcolor(green); write(' es '); textcolor(red); writeln(registro_reclamo2.anio);
  textcolor(green); write('El tipo de reclamo del reclamo '); textcolor(yellow); write(reclamo); textcolor(green); write(' del DNI '); textcolor(yellow); write(dni); textcolor(green); write(' es '); textcolor(red); writeln(registro_reclamo2.tipo);
end;
procedure imprimir_lista_reclamos(lista_reclamos: t_lista_reclamos; dni: int32);
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
var
  abb_dnis: t_abb_dnis;
begin
  randomize;
  abb_dnis:=nil;
  cargar_abb_dnis(abb_dnis);
  imprimir_abb_dnis(abb_dnis);
end.