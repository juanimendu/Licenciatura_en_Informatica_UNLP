{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 1}
{Implementar un programa que invoque a los siguientes módulos:
(a) Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los almacene en un vector con dimensión física igual a 10 y retorne el vector.
(b) Un módulo que reciba el vector generado en (a) e imprima el contenido del vector.
(c) Un módulo recursivo que reciba el vector generado en (a) e imprima el contenido del vector.
(d) Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.
(e) Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una lista con los caracteres leídos.
(f) Un módulo recursivo que reciba la lista generada en (e) e imprima los valores de la lista en el mismo orden que están almacenados.
(g) Un módulo recursivo que reciba la lista generada en (e) e imprima los valores de la lista en orden inverso al que están almacenados.}

program TP2_E1;
{$codepage UTF8}
uses crt;
const
  char_salida='.';
  dimF=10;
type
  t_vector_chars=array[1..dimF] of char;
  t_lista_chars=^t_nodo_chars;
  t_nodo_chars=record
    ele: char;
    sig: t_lista_chars;
  end;
procedure leer_char(var c: char);
begin
  c:=chr(ord('.')+random(dimF));
end;
procedure cargar_vector_chars(var vector_chars: t_vector_chars; var dimL: int8);
var
  c: char;
begin
  leer_char(c);
  if ((dimL<dimF) and (c<>char_salida)) then
  begin
    dimL:=dimL+1;
    vector_chars[dimL]:=c;
    cargar_vector_chars(vector_chars,dimL);
  end;
end;
procedure imprimir_secuencial_vector_chars(vector_chars: t_vector_chars; dimL: int8);
var
  i: int8;
begin
  for i:= 1 to dimL do
  begin
    textcolor(green); write('Elemento ',i,' del vector: '); textcolor(red); writeln(vector_chars[i]);
  end;
end;
procedure imprimir_recursivo_vector_chars(vector_chars: t_vector_chars; dimL: int8);
begin
  if (dimL>0) then
  begin
    imprimir_recursivo_vector_chars(vector_chars,dimL-1);
    textcolor(green); write('Elemento ',dimL,' del vector: '); textcolor(red); writeln(vector_chars[dimL]);
  end;
end;
function contar_chars(): int16;
var
  c: char;
begin
  leer_char(c);
  if (c=char_salida) then
    contar_chars:=0
  else
    contar_chars:=contar_chars()+1
end;
procedure agregar_adelante_lista_chars(var lista_chars: t_lista_chars; c: char);
var
  nuevo: t_lista_chars;
begin
  new(nuevo);
  nuevo^.ele:=c;
  nuevo^.sig:=lista_chars;
  lista_chars:=nuevo;
end;
procedure cargar_lista_chars(var lista_chars: t_lista_chars);
var
  c: char;
begin
  leer_char(c);
  if (c<>char_salida) then
  begin
    agregar_adelante_lista_chars(lista_chars,c);
    cargar_lista_chars(lista_chars);
  end;
end;
procedure imprimir1_lista_chars(lista_chars: t_lista_chars; i: int8);
begin
  if (lista_chars<>nil) then
  begin
    i:=i+1;
    textcolor(green); write('Elemento ',i,' de la lista: '); textcolor(red); writeln(lista_chars^.ele);
    imprimir1_lista_chars(lista_chars^.sig,i);
  end;
end;
procedure imprimir2_lista_chars(lista_chars: t_lista_chars; i: int8);
begin
  if (lista_chars<>nil) then
  begin
    i:=i+1;
    imprimir2_lista_chars(lista_chars^.sig,i);
    textcolor(green); write('Elemento ',i,' de la lista: '); textcolor(red); writeln(lista_chars^.ele);
  end;
end;
var
  vector_chars: t_vector_chars;
  lista_chars: t_lista_chars;
  dimL, i: int8;
begin
  randomize;
  dimL:=0;
  lista_chars:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_chars(vector_chars,dimL);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  imprimir_secuencial_vector_chars(vector_chars,dimL);
  writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
  imprimir_recursivo_vector_chars(vector_chars,dimL);
  writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
  textcolor(green); write('La cantidad de caracteres leídos es '); textcolor(red); writeln(contar_chars());
  writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
  cargar_lista_chars(lista_chars);
  if (lista_chars<>nil) then
  begin
    writeln(); textcolor(red); writeln('INCISO (f):'); writeln();
    i:=0;
    imprimir1_lista_chars(lista_chars,i);
    writeln(); textcolor(red); writeln('INCISO (g):'); writeln();
    i:=0;
    imprimir2_lista_chars(lista_chars,i);
  end;
end.