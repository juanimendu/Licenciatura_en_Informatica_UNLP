{TRABAJO PRÁCTICO N° 4.2}
{EJERCICIO 2}
{Realizar un programa que resuelva los siguientes incisos:
(a) Lea nombres de alumnos y los almacene en un vector de, a lo sumo, 500 elementos. La lectura finaliza cuando se lee el nombre “ZZZ”, que no debe procesarse.
(b) Lea un nombre y elimine la primera ocurrencia de dicho nombre en el vector.
(c) Lea un nombre y lo inserte en la posición 4 del vector.
(d) Lea un nombre y lo agregue al vector.
Nota: Realizar todas las validaciones necesarias.}

program TP4_E2;
{$codepage UTF8}
uses crt;
const
  nombres_total=500;
  nombre_salida='ZZZ';
  pos_corte=4;
type
  t_nombre=1..nombres_total;
  t_vector_nombres=array[t_nombre] of string;
procedure inicializar_vector_nombres(var vector_nombres: t_vector_nombres);
var
  i: t_nombre;
begin
  for i:= 1 to nombres_total do
    vector_nombres[i]:='';
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
procedure leer_nombre(var nombre: string);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    nombre:=nombre_salida
  else
    nombre:=random_string(5+random(6));
end;
procedure cargar_vector_nombres(var vector_nombres: t_vector_nombres; var nombres: int16);
var
  nombre: string;
begin
  leer_nombre(nombre);
  while ((nombre<>nombre_salida) and (nombres<nombres_total)) do
  begin
    nombres:=nombres+1;
    vector_nombres[nombres]:=nombre;
    leer_nombre(nombre);
  end;
end;
function buscar_desordenado_vector_nombres(vector_nombres: t_vector_nombres; nombres: int16; nombre: string): int16;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=nombres) and (vector_nombres[pos]<>nombre)) do
    pos:=pos+1;
  if (pos<=nombres) then
    buscar_desordenado_vector_nombres:=pos
  else
    buscar_desordenado_vector_nombres:=-1;
end;
procedure eliminar_vector_nombres(var vector_nombres: t_vector_nombres; var nombres: int16; nombre: string; pos: int16);
var
  i: t_nombre;
begin
  if ((pos>=1) and (pos<=nombres)) then
  begin
    for i:= pos to (nombres-1) do
      vector_nombres[i]:=vector_nombres[i+1];
    nombres:=nombres-1;
  end;
end;
procedure insertar_vector_nombres(var vector_nombres: t_vector_nombres; var nombres: int16; nombre: string; pos: int16);
var
  i: t_nombre;
begin
  if ((nombres<nombres_total) and ((pos>=1) and (pos<=nombres))) then
  begin
    for i:= nombres downto pos do
      vector_nombres[i+1]:=vector_nombres[i];
    vector_nombres[pos_corte]:=nombre;
    nombres:=nombres+1;
  end;
end;
procedure agregar_vector_nombres(var vector_nombres: t_vector_nombres; var nombres: int16; nombre: string);
begin
  if (nombres<nombres_total) then
  begin
    nombres:=nombres+1;
    vector_nombres[nombres]:=nombre;
  end;
end;
procedure imprimir_vector_nombres(vector_nombres: t_vector_nombres; nombres: int16);
var
  i: int16;
begin
  for i:= 1 to nombres do
  begin
    textcolor(green); write('Elemento ',i,' del vector: '); textcolor(red); writeln(vector_nombres[i]);
  end;
end;
var
  vector_nombres: t_vector_nombres;
  nombre: string;
  nombres: int16;
begin
  randomize;
  nombres:=0;
  inicializar_vector_nombres(vector_nombres);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_nombres(vector_nombres,nombres);
  if (nombres>0) then
  begin
    imprimir_vector_nombres(vector_nombres,nombres);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    nombre:=vector_nombres[1+random(nombres)];
    eliminar_vector_nombres(vector_nombres,nombres,nombre,buscar_desordenado_vector_nombres(vector_nombres,nombres,nombre));
    imprimir_vector_nombres(vector_nombres,nombres);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    nombre:=random_string(5+random(6));
    insertar_vector_nombres(vector_nombres,nombres,nombre,pos_corte);
    imprimir_vector_nombres(vector_nombres,nombres);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    nombre:=random_string(5+random(6));
    agregar_vector_nombres(vector_nombres,nombres,nombre);
    imprimir_vector_nombres(vector_nombres,nombres);
  end;
end.