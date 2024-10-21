{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 2}
{Escribir un programa que:
(a) Implemente un módulo recursivo que genere y retorne una lista de números enteros “random” en el rango 100-200. Finalizar con el número 100.
(b) Un módulo recursivo que reciba la lista generada en (a) e imprima los valores de la lista en el mismo orden que están almacenados.
(c) Implemente un módulo recursivo que reciba la lista generada en (a) e imprima los valores de la lista en orden inverso al que están almacenados.
(d) Implemente un módulo recursivo que reciba la lista generada en (a) y devuelva el mínimo valor de la lista.
(e) Implemente un módulo recursivo que reciba la lista generada en (a) y un valor y devuelva verdadero si dicho valor se encuentra en la lista o falso en caso contrario.}

program TP2_E2;
{$codepage UTF8}
uses crt;
const
  num_ini=100; num_fin=200;
  num_salida=100;
type
  t_numero=num_ini..num_fin;
  t_lista_numeros=^t_nodo_numeros;
  t_nodo_numeros=record
    ele: t_numero;
    sig: t_lista_numeros;
  end;
procedure leer_numero(var num: t_numero);
begin
  num:=num_salida+random(num_fin-num_salida);
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
procedure imprimir1_lista_numeros(lista_numeros: t_lista_numeros; i: int16);
begin
  if (lista_numeros<>nil) then
  begin
    i:=i+1;
    textcolor(green); write('Elemento ',i,' de la lista: '); textcolor(red); writeln(lista_numeros^.ele);
    imprimir1_lista_numeros(lista_numeros^.sig,i);
  end;
end;
procedure imprimir2_lista_numeros(lista_numeros: t_lista_numeros; i: int16);
begin
  if (lista_numeros<>nil) then
  begin
    i:=i+1;
    imprimir2_lista_numeros(lista_numeros^.sig,i);
    textcolor(green); write('Elemento ',i,' de la lista: '); textcolor(red); writeln(lista_numeros^.ele);
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
function buscar_lista_numeros(lista_numeros: t_lista_numeros; num: t_numero): boolean;
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
  num_min, num: t_numero;
  i: int16;
begin
  randomize;
  lista_numeros:=nil;
  num_min:=high(t_numero);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_numeros(lista_numeros);
  if (lista_numeros<>nil) then
  begin
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    i:=0;
    imprimir1_lista_numeros(lista_numeros,i);
    writeln(); textcolor(red); writeln('INCISO (c):');
    i:=0;
    imprimir2_lista_numeros(lista_numeros,i);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    calcular_minimo_lista_numeros(lista_numeros,num_min);
    textcolor(green); write('El mínimo valor de la lista es '); textcolor(red); writeln(num_min);
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    num:=num_ini+random(num_fin-num_ini);
    textcolor(green); write('¿El número '); textcolor(yellow); write(num); textcolor(green); write(' se encuentra en la lista?: '); textcolor(red); write(buscar_lista_numeros(lista_numeros,num));
  end;
end.