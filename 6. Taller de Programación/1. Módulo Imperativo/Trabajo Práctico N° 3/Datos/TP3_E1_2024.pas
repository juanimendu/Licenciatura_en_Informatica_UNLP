{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 1}
{Escribir un programa que:
(a) Implemente un módulo que almacene información de socios de un club en un árbol binario de búsqueda. De cada socio, se debe almacenar número de socio, nombre y edad.
La carga finaliza con el número de socio 0 y el árbol debe quedar ordenado por número de socio. La información de cada socio debe generarse aleatoriamente.
(b) Una vez generado el árbol, realice módulos independientes que reciban el árbol como parámetro y que:
  (i) Informe los datos de los socios en orden creciente.
  (ii) Informe los datos de los socios en orden decreciente.
  (iii) Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
  (iv) Aumente en 1 la edad de los socios con edad impar e informe la cantidad de socios que se les aumentó la edad.
  (v) Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
  (vi) Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
  (vii) Informe el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.}

program TP3_E1;
{$codepage UTF8}
uses crt;
const
  numero_salida=0;
type
  t_registro_socio=record
    numero: int16;
    nombre: string;
    edad: int8;
  end;
  t_abb_socios=^t_nodo_abb_socios;
  t_nodo_abb_socios=record
    ele: t_registro_socio;
    hi: t_abb_socios;
    hd: t_abb_socios;
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
procedure leer_socio(var registro_socio: t_registro_socio);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_socio.numero:=numero_salida
  else
    registro_socio.numero:=1+random(high(int16));
  if (registro_socio.numero<>numero_salida) then
  begin
    registro_socio.nombre:=random_string(5+random(6));
    registro_socio.edad:=1+random(high(int8)-1);
  end;
end;
procedure agregar_abb_socios(var abb_socios: t_abb_socios; registro_socio: t_registro_socio);
begin
  if (abb_socios=nil) then
  begin
    new(abb_socios);
    abb_socios^.ele:=registro_socio;
    abb_socios^.hi:=nil;
    abb_socios^.hd:=nil;
  end
  else
    if (registro_socio.numero<=abb_socios^.ele.numero) then
      agregar_abb_socios(abb_socios^.hi,registro_socio)
    else
      agregar_abb_socios(abb_socios^.hd,registro_socio);
end;
procedure cargar_abb_socios(var abb_socios: t_abb_socios);
var
  registro_socio: t_registro_socio;
begin
  leer_socio(registro_socio);
  while (registro_socio.numero<>numero_salida) do
  begin
    agregar_abb_socios(abb_socios,registro_socio);
    leer_socio(registro_socio);
  end;
end;
procedure imprimir_registro_socio(registro_socio: t_registro_socio);
begin
  textcolor(green); write('El número de socio del socio es '); textcolor(red); writeln(registro_socio.numero);
  textcolor(green); write('El nombre del socio es '); textcolor(red); writeln(registro_socio.nombre);
  textcolor(green); write('La edad del socio es '); textcolor(red); writeln(registro_socio.edad);
  writeln();
end;
procedure imprimir1_abb_socios(abb_socios: t_abb_socios);
begin
  if (abb_socios<>nil) then
  begin
    imprimir1_abb_socios(abb_socios^.hi);
    imprimir_registro_socio(abb_socios^.ele);
    imprimir1_abb_socios(abb_socios^.hd);
  end;
end;
procedure imprimir2_abb_socios(abb_socios: t_abb_socios);
begin
  if (abb_socios<>nil) then
  begin
    imprimir2_abb_socios(abb_socios^.hd);
    imprimir_registro_socio(abb_socios^.ele);
    imprimir2_abb_socios(abb_socios^.hi);
  end;
end;
procedure buscar_numero_mayor_edad(abb_socios: t_abb_socios; var edad_max: int8; var numero_max: int16);
begin
  if (abb_socios<>nil) then
  begin
    buscar_numero_mayor_edad(abb_socios^.hi,edad_max,numero_max);
    if (abb_socios^.ele.edad>edad_max) then
    begin
      edad_max:=abb_socios^.ele.edad;
      numero_max:=abb_socios^.ele.numero;
    end;
    buscar_numero_mayor_edad(abb_socios^.hd,edad_max,numero_max);
  end;
end;
procedure aumentar_edad(var abb_socios: t_abb_socios; var socios_edad: int16);
begin
  if (abb_socios<>nil) then
  begin
    aumentar_edad(abb_socios^.hi,socios_edad);
    if (abb_socios^.ele.edad mod 2<>0) then
    begin
      abb_socios^.ele.edad:=abb_socios^.ele.edad+1;
      socios_edad:=socios_edad+1;
    end;
    aumentar_edad(abb_socios^.hd,socios_edad);
  end;
end;
function buscar_nombre(abb_socios: t_abb_socios; nombre: string): boolean;
begin
  if (abb_socios=nil) then
    buscar_nombre:=false
  else
    if (nombre=abb_socios^.ele.nombre) then
      buscar_nombre:=true
    else
      buscar_nombre:=buscar_nombre(abb_socios^.hi,nombre) or buscar_nombre(abb_socios^.hd,nombre);
end;
function contar_socios(abb_socios: t_abb_socios): int16;
begin
  if (abb_socios=nil) then
    contar_socios:=0
  else
    contar_socios:=contar_socios(abb_socios^.hi)+contar_socios(abb_socios^.hd)+1;
end;
function contar_edades(abb_socios: t_abb_socios): int16;
begin
  if (abb_socios=nil) then
    contar_edades:=0
  else
    contar_edades:=contar_edades(abb_socios^.hi)+contar_edades(abb_socios^.hd)+abb_socios^.ele.edad;
end;
function calcular_edad_promedio(abb_socios: t_abb_socios): real;
begin
  calcular_edad_promedio:=contar_edades(abb_socios)/contar_socios(abb_socios);
end;
var
  abb_socios: t_abb_socios;
  edad_max: int8;
  numero_max, socios_edad: int16;
  nombre: string;
begin
  randomize;
  abb_socios:=nil;
  edad_max:=low(int8); numero_max:=numero_salida;
  socios_edad:=0;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abb_socios(abb_socios);
  if (abb_socios<>nil) then
  begin
    writeln(); textcolor(red); writeln('INCISO (b.i):'); writeln();
    imprimir1_abb_socios(abb_socios);
    writeln(); textcolor(red); writeln('INCISO (b.ii):'); writeln();
    imprimir2_abb_socios(abb_socios);
    writeln(); textcolor(red); writeln('INCISO (b.iii):'); writeln();
    buscar_numero_mayor_edad(abb_socios,edad_max,numero_max);
    textcolor(green); write('El número de socio con mayor edad es '); textcolor(red); writeln(numero_max);
    writeln(); textcolor(red); writeln('INCISO (b.iv):'); writeln();
    aumentar_edad(abb_socios,socios_edad);
    textcolor(green); write('La cantidad de socios que se les aumentó la edad es '); textcolor(red); writeln(socios_edad);
    writeln(); textcolor(red); writeln('INCISO (b.v):'); writeln();
    nombre:=random_string(5+random(6));
    textcolor(green); write('¿El nombre de socio '); textcolor(yellow); write(nombre); textcolor(green); write(' se encuentra en el abb?: '); textcolor(red); writeln(buscar_nombre(abb_socios,nombre));
    writeln(); textcolor(red); writeln('INCISO (b.vi):'); writeln();
    textcolor(green); write('La cantidad de socios es '); textcolor(red); writeln(contar_socios(abb_socios));
    writeln(); textcolor(red); writeln('INCISO (b.vii):'); writeln();
    textcolor(green); write('El promedio de edad de los socios es '); textcolor(red); write(calcular_edad_promedio(abb_socios):0:2);
  end;
end.