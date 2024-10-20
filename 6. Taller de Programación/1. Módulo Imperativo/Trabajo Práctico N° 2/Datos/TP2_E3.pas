{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 3}
{Escribir un programa que:
(a) Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. Finalizar con el número 0.
(b) Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
(c) Implemente un módulo recursivo que devuelva el máximo valor de la lista.
(d) Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario.}

program TP2_E3;
{$codepage UTF8}
uses crt;
const
  num_ini=0; num_fin=100;
  num_salida=0;
type
  t_numero=num_ini..num_fin;
  t_lista_numeros=^t_nodo_numeros;
  t_nodo_numeros=record
    ele: int16;
    sig: t_lista_numeros;
  end;
procedure leer_numero(var num: t_numero);
begin
  num:=num_salida+random(num_fin);
end;
procedure agregar_adelante_lista_numeros(var lista_numeros: t_lista_numeros; num: t_numero);
var
  nuevo: t_lista_numeros;
begin
  new(nuevo);
  nuevo^.ele:=num;
  nuevo^.sig:=lista_numeros;
  lista_numeros:=nuevo;
end;
procedure cargar_lista_numeros(var lista_numeros: t_lista_numeros);
var
  num: t_numero;
begin
  leer_numero(num);
  if (num<>num_salida) then
  begin
    agregar_adelante_lista_numeros(lista_numeros,num);
    cargar_lista_numeros(lista_numeros);
  end;
end;
procedure imprimir_lista_numeros(lista_numeros: t_lista_numeros; i: int16);
begin
  if (lista_numeros<>nil) then
  begin
    i:=i+1;
    textcolor(green); write('Elemento ',i,' de la lista: '); textcolor(red); writeln(lista_numeros^.ele);
    imprimir_lista_numeros(lista_numeros^.sig,i);
  end;
end;
procedure calcular_minimo_lista_numeros(lista_numeros: t_lista_numeros; var num_min: t_numero);
begin
  if (lista_numeros<>nil) then
  begin
    if (lista_numeros^.ele<num_min) then
      num_min:=lista_numeros^.ele;
    calcular_minimo_lista_numeros(lista_numeros^.sig,num_min);
  end;
end;
procedure calcular_maximo_lista_numeros(lista_numeros: t_lista_numeros; var num_max: t_numero);
begin
  if (lista_numeros<>nil) then
  begin
    if (lista_numeros^.ele>num_max) then
      num_max:=lista_numeros^.ele;
    calcular_maximo_lista_numeros(lista_numeros^.sig,num_max);
  end;
end;
function buscar_lista_numeros(lista_numeros: t_lista_numeros; num: int16): boolean;
begin
  if (lista_numeros=nil) then
    buscar_lista_numeros:=false
  else
    if (lista_numeros^.ele=num) then
      buscar_lista_numeros:=true
    else
      buscar_lista_numeros:=buscar_lista_numeros(lista_numeros^.sig,num);
end;
var
  lista_numeros: t_lista_numeros;
  num_min, num_max: t_numero;
  i, num: int16;
begin
  randomize;
  lista_numeros:=nil;
  num_min:=high(t_numero);
  num_max:=low(t_numero);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_numeros(lista_numeros);
  if (lista_numeros<>nil) then
  begin
    i:=0;
    imprimir_lista_numeros(lista_numeros,i);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    calcular_minimo_lista_numeros(lista_numeros,num_min);
    textcolor(green); write('El mínimo valor de la lista es '); textcolor(red); writeln(num_min);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    calcular_maximo_lista_numeros(lista_numeros,num_max);
    textcolor(green); write('El máximo valor de la lista es '); textcolor(red); writeln(num_max);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    num:=(num_ini+1)+random(num_fin-(num_ini+1));
    textcolor(green); write('¿El número '); textcolor(yellow); write(num); textcolor(green); write(' se encuentra en la lista?: '); textcolor(red); write(buscar_lista_numeros(lista_numeros,num));
  end;
end.