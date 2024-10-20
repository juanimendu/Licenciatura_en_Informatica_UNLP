{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 2}
{El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
(a) Generar un vector, sin orden, con, a lo sumo, las 300 oficinas que administra.
De cada oficina, se ingresa el código de identificación, DNI del propietario y valor de la expensa.
La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
(b) Ordenar el vector, aplicando el método de inserción, por código de identificación de la oficina.
(c) Ordenar el vector aplicando el método de selección, por código de identificación de la oficina.}

program TP1_E2;
{$codepage UTF8}
uses crt;
const
  oficinas_total=300;
  codigo_salida=-1;
type
  t_oficina=1..oficinas_total;
  t_registro_oficina=record
    codigo: int16;
    dni: int32;
    expensa: real;
  end;
  t_vector_oficinas=array[t_oficina] of t_registro_oficina;
procedure leer_oficina(var registro_oficina: t_registro_oficina);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_oficina.codigo:=codigo_salida
  else
    registro_oficina.codigo:=1+random(high(int16));
  if (registro_oficina.codigo<>codigo_salida) then
  begin
    registro_oficina.dni:=1+random(high(int32));
    registro_oficina.expensa:=1+random(100);
  end;
end;
procedure cargar_vector_oficinas(var vector_oficinas: t_vector_oficinas; var oficinas: int16);
var
  registro_oficina: t_registro_oficina;
begin
  leer_oficina(registro_oficina);
  while (registro_oficina.codigo<>codigo_salida) and (oficinas<oficinas_total) do
  begin
    oficinas:=oficinas+1;
    vector_oficinas[oficinas]:=registro_oficina;
    leer_oficina(registro_oficina);
  end;
end;
procedure imprimir_registro_oficina(registro_oficina: t_registro_oficina; oficina: t_oficina);
begin
  textcolor(green); write('El código de identificación de la oficina '); textcolor(yellow); write(oficina); textcolor(green); write(' es '); textcolor(red); writeln(registro_oficina.codigo);
  textcolor(green); write('El DNI del propietario de la oficina '); textcolor(yellow); write(oficina); textcolor(green); write(' es '); textcolor(red); writeln(registro_oficina.dni);
  textcolor(green); write('El valor de la expensa de la oficina '); textcolor(yellow); write(oficina); textcolor(green); write(' es '); textcolor(red); writeln(registro_oficina.expensa:0:2);
end;
procedure imprimir_vector_oficinas(vector_oficinas: t_vector_oficinas; oficinas: int16);
var
  i: t_oficina;
begin
  for i:= 1 to oficinas do
  begin
    textcolor(green); write('La información de la oficina '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_oficina(vector_oficinas[i],i);
    writeln();
  end;
end;
procedure ordenacion_insercion_vector_oficinas(var vector_oficinas: t_vector_oficinas; oficinas: int16);
var
  actual: t_registro_oficina;
  i, j: t_oficina;
begin
  for i:= 2 to oficinas do
  begin
    actual:=vector_oficinas[i];
    j:=i-1;
    while ((j>0) and (vector_oficinas[j].codigo>actual.codigo)) do
    begin
      vector_oficinas[j+1]:=vector_oficinas[j];
      j:=j-1;
    end;
    vector_oficinas[j+1]:=actual;
  end;
end;
procedure ordenacion_seleccion_vector_oficinas(var vector_oficinas: t_vector_oficinas; oficinas: int16);
var
  item: t_registro_oficina;
  i, j, k: t_oficina;
begin
  for i:= 1 to (oficinas-1) do
  begin
    k:=i;
    for j:= (i+1) to oficinas do
      if (vector_oficinas[j].codigo<vector_oficinas[k].codigo) then
        k:=j;
    item:=vector_oficinas[k];
    vector_oficinas[k]:=vector_oficinas[i];
    vector_oficinas[i]:=item;
  end;
end;
var
  vector_oficinas: t_vector_oficinas;
  oficinas: int16;
begin
  randomize;
  oficinas:=0;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_oficinas(vector_oficinas,oficinas);
  if (oficinas>0) then
  begin
    imprimir_vector_oficinas(vector_oficinas,oficinas);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    ordenacion_insercion_vector_oficinas(vector_oficinas,oficinas);
    imprimir_vector_oficinas(vector_oficinas,oficinas);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    ordenacion_seleccion_vector_oficinas(vector_oficinas,oficinas);
    imprimir_vector_oficinas(vector_oficinas,oficinas);
  end;
end.