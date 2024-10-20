{TRABAJO PRÁCTICO N° 4.2}
{EJERCICIO 4}
{Una cátedra dispone de información de sus alumnos (a lo sumo, 1000).
De cada alumno, se conoce número de alumno, apellido y nombre y cantidad de asistencias a clase.
Dicha información se encuentra ordenada por número de alumno de manera ascendente.
Se pide:
(a)	Un módulo que retorne la posición del alumno con un número de alumno recibido por parámetro. El alumno seguro existe.
(b)	Un módulo que reciba un alumno y lo inserte en el vector.
(c)	Un módulo que reciba la posición de un alumno dentro del vector y lo elimine.
(d)	Un módulo que reciba un número de alumno y elimine dicho alumno del vector.
(e)	Un módulo que elimine del vector todos los alumnos con cantidad de asistencias en 0.
Nota: Realizar el programa principal que invoque los módulos desarrollados en los incisos previos con datos leídos de teclado.}

program TP4_E4;
{$codepage UTF8}
uses crt;
const
  alumnos_total=1000;
  numero_salida=-1;
  asistencias_corte=0;
type
  t_alumno=1..alumnos_total;
  t_registro_alumno=record
    numero: int16;
    apellido: string;
    nombre: string;
    asistencias: int8;
  end;
  t_vector_alumnos=array[t_alumno] of t_registro_alumno;
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
procedure leer_alumno(var registro_alumno: t_registro_alumno);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_alumno.numero:=numero_salida
  else
    registro_alumno.numero:=1+random(high(int16));
  if (registro_alumno.numero<>numero_salida) then
  begin
    registro_alumno.apellido:=random_string(5+random(6));
    registro_alumno.nombre:=random_string(5+random(6));
    registro_alumno.asistencias:=random(100);
  end;
end;
function buscar_ordenado1_vector_alumnos(vector_alumnos: t_vector_alumnos; alumnos, numero: int16): int16;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=alumnos) and (vector_alumnos[pos].numero<numero)) do
    pos:=pos+1;
  buscar_ordenado1_vector_alumnos:=pos;
end;
procedure insertar_vector_alumnos(var vector_alumnos: t_vector_alumnos; var alumnos: int16; registro_alumno: t_registro_alumno; pos: int16);
var
  i: t_alumno;
begin
  if ((alumnos<alumnos_total) and ((pos>=1) and (pos<=alumnos))) then
    for i:= alumnos downto pos do
      vector_alumnos[i+1]:=vector_alumnos[i];
  if ((alumnos<alumnos_total) and ((pos>=1) and (pos<=alumnos+1))) then
  begin
    vector_alumnos[pos]:=registro_alumno;
    alumnos:=alumnos+1;
  end;
end;
procedure cargar_vector_alumnos(var vector_alumnos: t_vector_alumnos; var alumnos: int16);
var
  registro_alumno: t_registro_alumno;
  pos: int16;
begin
  pos:=0;
  leer_alumno(registro_alumno);
  while ((registro_alumno.numero<>numero_salida) and (alumnos<alumnos_total)) do
  begin
    pos:=buscar_ordenado1_vector_alumnos(vector_alumnos,alumnos,registro_alumno.numero);
    insertar_vector_alumnos(vector_alumnos,alumnos,registro_alumno,pos);
    leer_alumno(registro_alumno);
  end;
end;
function calcular_a(vector_alumnos: t_vector_alumnos; alumnos, numero: int16): int16;
begin
  calcular_a:=buscar_ordenado1_vector_alumnos(vector_alumnos,alumnos,numero);
end;
procedure calcular_b(var vector_alumnos: t_vector_alumnos; var alumnos: int16; registro_alumno: t_registro_alumno);
var
  pos: int16;
begin
  pos:=0;
  if (alumnos<alumnos_total) then
  begin
    pos:=buscar_ordenado1_vector_alumnos(vector_alumnos,alumnos,registro_alumno.numero);
    insertar_vector_alumnos(vector_alumnos,alumnos,registro_alumno,pos);
  end;
end;
procedure calcular_c(var vector_alumnos: t_vector_alumnos; var alumnos: int16; pos: int16);
var
  i: t_alumno;
begin
  if ((pos>=1) and (pos<=alumnos)) then
  begin
    for i:= pos to (alumnos-1) do
      vector_alumnos[i]:=vector_alumnos[i+1];
    alumnos:=alumnos-1;
  end;
end;
function buscar_ordenado2_vector_alumnos(vector_alumnos: t_vector_alumnos; alumnos, numero: int16): int16;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=alumnos) and (vector_alumnos[pos].numero<numero)) do
    pos:=pos+1;
  if ((pos<=alumnos) and (vector_alumnos[pos].numero=numero)) then
    buscar_ordenado2_vector_alumnos:=pos
  else
    buscar_ordenado2_vector_alumnos:=-1;
end;
procedure calcular_d(var vector_alumnos: t_vector_alumnos; var alumnos: int16; numero: int16);
begin
  calcular_c(vector_alumnos,alumnos,buscar_ordenado2_vector_alumnos(vector_alumnos,alumnos,numero));
end;
procedure buscar_desordenado_vector_alumnos(vector_alumnos: t_vector_alumnos; alumnos: int16; var pos: int16);
begin
  while ((pos<=alumnos) and (vector_alumnos[pos].asistencias<>asistencias_corte)) do
    pos:=pos+1;
  if (pos>alumnos) then
    pos:=-1;
end;
procedure calcular_e(var vector_alumnos: t_vector_alumnos; var alumnos: int16);
var
  pos: int16;
begin
  pos:=1;
  buscar_desordenado_vector_alumnos(vector_alumnos,alumnos,pos);
  while ((pos>=1) and (pos<=alumnos)) do
  begin
    calcular_c(vector_alumnos,alumnos,pos);
    buscar_desordenado_vector_alumnos(vector_alumnos,alumnos,pos);
  end;
end;
var
  registro_alumno: t_registro_alumno;
  vector_alumnos: t_vector_alumnos;
  alumnos, pos, numero: int16;
begin
  randomize;
  alumnos:=0;
  cargar_vector_alumnos(vector_alumnos,alumnos);
  if (alumnos>0) then
  begin
    writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
    numero:=1+random(high(int16));
    textcolor(green); write('La posición en el vector del alumno con número de alumno '); textcolor(yellow); write(numero); textcolor(green); write(' es '); textcolor(red); writeln(calcular_a(vector_alumnos,alumnos,numero));
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    leer_alumno(registro_alumno);
    calcular_b(vector_alumnos,alumnos,registro_alumno);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    pos:=1+random(alumnos);
    calcular_c(vector_alumnos,alumnos,pos);
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    numero:=1+random(high(int16));
    calcular_d(vector_alumnos,alumnos,numero);
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    calcular_e(vector_alumnos,alumnos);
  end;
end.