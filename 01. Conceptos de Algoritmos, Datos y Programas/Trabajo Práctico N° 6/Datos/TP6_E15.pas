{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 15}
{La cátedra de CADP está organizando la cursada para el año 2019. Para ello, dispone de una lista con todos los alumnos que cursaron EPA.
De cada alumno, se conoce su DNI, apellido, nombre y la nota obtenida.
Escribir un programa que procese la información de alumnos disponible y los distribuya en turnos utilizando los siguientes criterios:
•	Los alumnos que obtuvieron, al menos, 8 en EPA deberán ir a los turnos 1 o 4.
•	Los alumnos que obtuvieron entre 5 y 8 deberán ir a los turnos 2, 3 o 5.
•	Los alumnos que no alcanzaron la nota 5 no se les asignará turno en CADP.
Al finalizar, el programa debe imprimir en pantalla la lista de alumnos para cada turno.
Nota: La distribución de alumnos debe ser lo más equitativa posible.}

program TP6_E15;
{$codepage UTF8}
uses crt;
const
  dni_salida=0;
  nota_ini=1; nota_fin=10;
  turno_ini=1; turno_fin=5;
  nota_corte1=8; nota_corte2=5;
type
  t_nota=nota_ini..nota_fin;
  t_turno=turno_ini..turno_fin;
  t_registro_alumno=record
    dni: int32;
    apellido: string;
    nombre: string;
    nota: t_nota;
  end;
  t_lista_alumnos=^t_nodo_alumnos;
  t_nodo_alumnos=record
    ele: t_registro_alumno;
    sig: t_lista_alumnos;
  end;
  t_vector_turnos=array[t_turno] of t_lista_alumnos;
procedure inicializar_vector_turnos(var vector_turnos: t_vector_turnos);
var
  i: t_turno;
begin
  for i:= turno_ini to turno_fin do
    vector_turnos[i]:=nil;
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
procedure leer_alumno(var registro_alumno: t_registro_alumno);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_alumno.dni:=dni_salida
  else
    registro_alumno.dni:=10000000+random(40000001);
  if (registro_alumno.dni<>dni_salida) then
  begin
    registro_alumno.apellido:=random_string(5+random(6));
    registro_alumno.nombre:=random_string(5+random(6));
    registro_alumno.nota:=nota_ini+random(nota_fin);
  end;
end;
procedure agregar_adelante_lista_alumnos(var lista_alumnos: t_lista_alumnos; registro_alumno: t_registro_alumno);
var
  nuevo: t_lista_alumnos;
begin
  new(nuevo);
  nuevo^.ele:=registro_alumno;
  nuevo^.sig:=lista_alumnos;
  lista_alumnos:=nuevo;
end;
procedure cargar_lista_alumnos(var lista_alumnos: t_lista_alumnos);
var
  registro_alumno: t_registro_alumno;
begin
  leer_alumno(registro_alumno);
  while (registro_alumno.dni<>dni_salida) do
  begin
    agregar_adelante_lista_alumnos(lista_alumnos,registro_alumno);
    leer_alumno(registro_alumno);
  end;
end;
procedure procesar_lista_alumnos(lista_alumnos: t_lista_alumnos; var vector_turnos: t_vector_turnos);
var
  vector_turnos1: array[1..2] of int8=(1, 4);
  vector_turnos2: array[1..3] of int8=(2, 3, 5);
begin
  while (lista_alumnos<>nil) do
  begin
    if (lista_alumnos^.ele.nota>=nota_corte1) then
      agregar_adelante_lista_alumnos(vector_turnos[vector_turnos1[1+random(2)]],lista_alumnos^.ele)
    else if (lista_alumnos^.ele.nota>=nota_corte2) then
      agregar_adelante_lista_alumnos(vector_turnos[vector_turnos2[1+random(3)]],lista_alumnos^.ele);
    lista_alumnos:=lista_alumnos^.sig;
  end;
end;
procedure imprimir_lista_alumnos(lista_alumnos: t_lista_alumnos; turno: t_turno);
begin
  while (lista_alumnos<>nil) do
  begin
    textcolor(green); write('TURNO ',turno,': '); textcolor(green); write('DNI '); textcolor(red); write(lista_alumnos^.ele.dni); textcolor(green); write('; APELLIDO '); textcolor(red); write(lista_alumnos^.ele.apellido); textcolor(green); write('; NOMBRE '); textcolor(red); write(lista_alumnos^.ele.nombre);; textcolor(green); write('; NOTA '); textcolor(red); writeln(lista_alumnos^.ele.nota);
    lista_alumnos:=lista_alumnos^.sig;
  end;
end;
procedure imprimir_vector_turnos(vector_turnos: t_vector_turnos);
var
  i: t_turno;
begin
  for i:= turno_ini to turno_fin do
  begin
    imprimir_lista_alumnos(vector_turnos[i],i);
    writeln();
  end;
end;
var
  vector_turnos: t_vector_turnos;
  lista_alumnos: t_lista_alumnos;
begin
  randomize;
  lista_alumnos:=nil;
  inicializar_vector_turnos(vector_turnos);
  cargar_lista_alumnos(lista_alumnos);
  if (lista_alumnos<>nil) then
  begin
    procesar_lista_alumnos(lista_alumnos,vector_turnos);
    imprimir_vector_turnos(vector_turnos);
  end;
end.